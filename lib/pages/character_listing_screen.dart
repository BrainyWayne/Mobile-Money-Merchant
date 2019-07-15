import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:mobile_moneey_merchant/models/character.dart';

import '../styleguide.dart';
import '../view_locations.dart';
import 'character_detail_screen.dart';

class CharacterListingScreen extends StatefulWidget {
  @override
  _CharacterListingScreenState createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {
  var location = new Location();
  Map<String, double> userLocation;
  var first, addresses;
  var displayLocation = "";
  var displaySubLocality = "";

  PageController pageController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
    getCurrentPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              getCurrentPosition().then((value) {
                setState(() {
                  userLocation = value;
                });
              });
            },
            child: Icon(Icons.menu)),
        actions: <Widget>[
          InkWell(
            onTap: () {
              getAddress();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Mobile Money Agents",
                          style: AppTheme.display1),
                      TextSpan(text: "\n"),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, top: 0.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(

                      child: Icon(Icons.location_on, color: Colors.white,
                      ),
                      backgroundColor: Colors.black,
                      radius: 18,
                    ),
                    SizedBox(width: 15,),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: displaySubLocality + ",\n" + displayLocation, style: AppTheme.display2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: PageView(
                  controller: pageController,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) => Locations()));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[0].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[0].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[0].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[0].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[0].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[1])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[1].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[1].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[1].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[1].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[1].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[2])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[2].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[2].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[1].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[2].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[2].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[3])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[3].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[1].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[3].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[3].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[3].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[4])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[4].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[1].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[4].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[4].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[4].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[5])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[5].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[5].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[5].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[5].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[5].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[6])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[6].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[6].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[6].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[6].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[6].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[7])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[7].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[7].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[7].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[7].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[7].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[8])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[8].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[8].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[8].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[8].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[8].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, _, __) =>
                                    CharacterDetailScreen(
                                        character: characters[9])));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: CharacterCardBackgroundClipper(),
                              child: Hero(
                                tag: "background-${characters[9].name}",
                                child: Container(
                                  height: 0.6 * screenHeight,
                                  width: 0.9 * screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: characters[9].colors,
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Hero(
                              tag: "image-{$characters[0].name}",
                              child: Image.asset(
                                characters[9].imagePath,
                                height: screenHeight * 0.55,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Hero(
                                  tag: "name-${characters[9].name}",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Text(
                                        characters[9].name,
                                        style: AppTheme.heading,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tap to View Merchants",
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getCurrentPosition() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
      setState(() {
        userLocation = currentLocation;
      });
      getAddress();
    } catch (e) {
      currentLocation = null;
    }

    return currentLocation;
  }

  Future getAddress() async {
    final coordinates =
        new Coordinates(userLocation["latitude"], userLocation["longitude"]);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    setState(() {
      displayLocation = first.adminArea.toString();
      displaySubLocality = first.subLocality.toString();
    });

    try {
      if (first.adminArea.toString().contains("Accra")) {
        pageController.animateToPage(1,
            duration: Duration(milliseconds: 700), curve: Curves.easeIn);
      }
    } catch (e) {}

    print(
        "${first.featureName} : ${first.addressLine} :  ${first.locality} : ${first.adminArea} : ${first.subLocality} : ${first.subAdminArea} : ${first.thoroughfare} : ${first.subThoroughfare}");
  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(
        1, (size.height * 0.30) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
