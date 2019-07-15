
import 'package:flutter/material.dart';
import 'package:mobile_moneey_merchant/models/character.dart';
import 'package:mobile_moneey_merchant/pages/character_detail_screen.dart';

import '../styleguide.dart';
import '../view_locations.dart';

class CharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Stack(
      children: [
        PageView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[





          ],
        )
      ],
    );
  }
}


