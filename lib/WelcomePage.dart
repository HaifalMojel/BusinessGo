
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:async';
import 'sign_page.dart';


class WelcomePage extends StatefulWidget {
  @override
  _MyWelcomePageState createState() => _MyWelcomePageState();
}

class _MyWelcomePageState extends State<WelcomePage> {


  @override
  void initState() {
   // modelResult();
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    sign_page()
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
          Container(),
          Container(),
          Container(),
          Transform.translate(
            offset: Offset(0.0, 216.0),
            child:
                // Adobe XD layer: 'logo3-07' (group)
                SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.8,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/2.8),
                    size: Size(MediaQuery.of(context).size.width, 320.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'logo3-07' (shape)
                        Container(
                          height: MediaQuery.of(context).size.height/2.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/images/bgo_logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, MediaQuery.of(context).size.height/1.7),
            child: SizedBox(
              width: 400.0,
              child: Text(
                'BusinessGO',
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 58,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.height/1.3),
            child:
            // Adobe XD layer: 'logo3-07' (group)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4.5,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/4.5),
                    size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/4.5),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                    // Adobe XD layer: 'logo3-07' (shape)
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/images/bgo_building.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
