import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:async';
import 'home_page.dart';
import 'Verification_page.dart';

class sign_welcome extends StatefulWidget {

  String userID;
  sign_welcome(String userID){
    this.userID = userID;
  }

  @override
  _MySign_welcomeState createState() => _MySign_welcomeState(this.userID);
}

class _MySign_welcomeState extends State<sign_welcome> {

  String userID;
  _MySign_welcomeState(String userID){
    this.userID = userID;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    home_page(this.userID)
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff8f8),
      body: Center(child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffb7e0ee),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(MediaQuery.of(context).size.width/5.5, MediaQuery.of(context).size.height/2.75, MediaQuery.of(context).size.width/1.5, MediaQuery.of(context).size.width/1.5),
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                  fixedWidth: true,
                  fixedHeight: true,
                  child: Text(
                    'مرحبا',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 100,
                      color: const Color(0xff1b5070),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}

const String _svg_kb3hkb =
    '<svg viewBox="136.0 854.4 30.2 16.8" ><path transform="translate(128.5, 840.9)" d="M 22.57467842102051 30.27401351928711 C 22.07152938842773 30.27511215209961 21.58392333984375 30.08012771606445 21.19650077819824 29.7229118347168 L 8.276060104370117 17.74228286743164 C 7.360304832458496 16.89534378051758 7.234970092773438 15.38272190093994 7.99611759185791 14.36374759674072 C 8.757266044616699 13.3447732925415 10.11666488647461 13.20531177520752 11.03242111206055 14.05225086212158 L 22.57467842102051 24.78689193725586 L 34.116943359375 14.43563175201416 C 34.56182479858398 14.03363513946533 35.13236236572266 13.84554386138916 35.70224380493164 13.91300296783447 C 36.27212524414062 13.98046207427979 36.79433059692383 14.29790592193604 37.15324783325195 14.79505252838135 C 37.55191421508789 15.29311084747314 37.7459831237793 15.95352458953857 37.68876647949219 16.61744689941406 C 37.63155364990234 17.28136825561523 37.3282356262207 17.88871383666992 36.85177230834961 18.29339599609375 L 23.93132781982422 29.86667633056641 C 23.53276634216309 30.16743087768555 23.05510711669922 30.31084823608398 22.57467842102051 30.27401351928711 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
