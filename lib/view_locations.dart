import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Locations extends StatefulWidget {
  @override
  _LocateUsState createState() => _LocateUsState();
}

class _LocateUsState extends State<Locations> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  VoidCallback _showBottomSheetCallback;
  MapType _defaultMapType;
  bool visibility = false;
  final Set<Marker> _markers = Set();

  @override
  void initState() {
    _goToTheLake();
    BackButtonInterceptor.add(myInterceptor);
    _showBottomSheetCallback = _showBottomSheet;
    _defaultMapType = MapType.normal;
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!");
    Navigator.pop(context); // Do some stuff.
    return true;
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.6735341, -1.633525),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: _scaffoldKey,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.decelerate,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              markers: _markers,
              mapType: _defaultMapType,
              indoorViewEnabled: true,

              initialCameraPosition: _kLake,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              compassEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference.unbounded,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,

            ),
            Container(
              margin: EdgeInsets.only(top: 80, right: 10),
              alignment: Alignment.topRight,
              child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                        child: Icon(Icons.layers),
                        elevation: 5,
                        backgroundColor: Colors.teal[200],
                        onPressed: () {
                          _goToNewYork("Francis", "All networks", "0fsdf5sdfa");
                          print('Changing the Map Type');
                        }),
                  ]),
            ),

            Visibility(
              child: AnimatedContainer(
                margin: EdgeInsets.only(left: 40, right: 40, top: 100, bottom: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: Duration(milliseconds: 400),
                curve: Curves.decelerate,
                child: Container(

                  child: Stack(
                    children: <Widget>[
                      Align(
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              child: Icon(Icons.person_pin),
                              radius: 50,
                            ),
                            Text("Francis Eshun")
                          ],
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  )
                ),
              ),
              visible: visibility,
            ),


          ],
        ),
      ),


      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _showBottomSheetCallback,
        label: Text('Options'),
        icon: Icon(Icons.play_arrow),
      ),*/
    );
  }

  void _visibilitymethod() {
    setState(() {
      if (visibility) {
        visibility = false;
      } else {
        visibility = true;
              }
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _goToNewYork(title, snippet, id) async {
    double lat = 6.1735341;
    double long = -1.633525;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 150));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('kumasi'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: title,
                snippet: snippet,
            onTap: _visibilitymethod)
        ),
      );
    });
  }



  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  _launchURL() async {
    const url = "google.navigation:q=${6.6735341},${-1.633525}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showBottomSheet() {
    setState(() { // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      final ThemeData themeData = Theme.of(context);
      return Container(
        height: MediaQuery.of(context).size.height*0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: themeData.disabledColor))
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                SizedBox(height: 30,),

                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blue),
                        margin: EdgeInsets.only(right: 0, top: 50),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                child: InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Open with Google Maps',
                                          style: TextStyle(fontSize: 17, color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CircleAvatar(
                                        radius: 17,
                                        child: Icon(
                                          Icons.map,
                                          size: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _launchURL();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blue),
                        margin: EdgeInsets.only(right: 0, top: 50),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                child: InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Go to New York',
                                          style: TextStyle(fontSize: 17, color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CircleAvatar(
                                        radius: 17,
                                        child: Icon(
                                          Icons.location_on,
                                          size: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _goToNewYork("Francis", "All networks", "0fsdf5sdfa");
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    })
        .closed.whenComplete(() {
      if (mounted) {
        setState(() { // re-enable the button
          _showBottomSheetCallback = _showBottomSheet;
        });
      }
    });
  }

  void _showMessage() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('You tapped the floating action button.'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
