import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_app/fav_list.dart';
import 'package:flutter_app/project_list.dart';
import 'package:flutter_app/user_input.dart';
import 'sign_page.dart';

class home_page extends StatelessWidget {

  String userID , fullName;
  final collRef = Firestore.instance.collection('BusinessOwner');

  home_page(String userID){
    this.userID = userID;
    getName(userID);
  }

  Future<void> getName(String id)  {
     collRef.document(userID).get().then((DocumentSnapshot snap){
      fullName = snap.data['FullName'];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff8f8),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: const Color(0xffeff8f8),
            ),
          ),
          Transform.translate(
            offset: Offset(310.0, 30.0 ),
            child: IconButton(
              onPressed: () {
                showDialog<void>(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    return new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0 , 0 , 0 , 0),
                          child: new Container(
                            height: MediaQuery.of(context).size.height/2.7,
                            width: MediaQuery.of(context).size.width/1.8,
                            color: const Color.fromRGBO(255 , 255 , 255 , 0.82),
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Transform.translate(
                                  offset: Offset(MediaQuery.of(context).size.width/4,10.0),
                                  child: Row(
                                      children: <Widget>[
                                        Icon(Icons.person_outline , size: 50,color: Colors.black54,),
                                        Transform.translate(
                                          offset: Offset(MediaQuery.of(context).size.width/50,0.0),
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            textColor: Colors.black54,
                                            child: const Icon(Icons.clear),
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                Center(
                                  child: Text('أهلا بك ' + fullName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black54,
                                        decoration: TextDecoration.none
                                    ),),
                                ),
                                Transform.translate(
                                  offset: Offset(MediaQuery.of(context).size.width/50,10.0),
                                  child: Row(
                                      children: <Widget>[
                                        Transform.translate(
                                          offset: Offset(MediaQuery.of(context).size.width/50,0.0),
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(builder:
                                                      (context) =>
                                                      home_page(userID)
                                                  )
                                              );
                                            },
                                            textColor: Colors.black54,
                                            child: Text('الصفحة الرئيسية ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black54
                                              ),),
                                          ),
                                        ),
                                        Icon(Icons.home , size: 50,color: Colors.black54,),
                                      ]
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(MediaQuery.of(context).size.width/50,30.0),
                                  child: Row(
                                      children: <Widget>[
                                        Transform.translate(
                                          offset: Offset(MediaQuery.of(context).size.width/50,0.0),
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(builder:
                                                      (context) =>
                                                      fav_list()
                                                  )
                                              );
                                            },
                                            textColor: Colors.black54,
                                            child: Text('     مفضلاتي         ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black54
                                              ),),
                                          ),
                                        ),
                                        Icon(Icons.favorite , size: 50,color: Colors.black54,),
                                      ]
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(MediaQuery.of(context).size.width/50,45.0),
                                  child: Row(
                                      children: <Widget>[
                                        Transform.translate(
                                          offset: Offset(MediaQuery.of(context).size.width/50,0.0),
                                          child: FlatButton(
                                            onPressed: () {
                                              FirebaseAuth.instance.signOut();
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(builder:
                                                      (context) =>
                                                      sign_page()
                                                  )
                                              );
                                            },
                                            textColor: Colors.black54,
                                            child: Text(' تسجيل الخروج  ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black54
                                              ),),
                                          ),
                                        ),
                                        Icon(Icons.exit_to_app , size: 50,color: Colors.black54,),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              iconSize: 40.0,
              icon: Icon(
                Icons.dehaze,
                color: Colors.black54,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/3.5, MediaQuery.of(context).size.height/4.3),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/2.3,
              child: Container(
                width: MediaQuery.of(context).size.width/2.3,
                height: MediaQuery.of(context).size.width/2.3,
                child: FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            user_input(null)
                        )
                    );
                  },
                  child: Text(
                    'مشروع جديد',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 29,
                      color: const Color(0xff1b5070),
                      shadows: [
                        Shadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.white70,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/3.5, MediaQuery.of(context).size.height/2.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/2.3,
              child: Container(
                width: MediaQuery.of(context).size.width/2.3,
                height: MediaQuery.of(context).size.width/2.3,
                child: FloatingActionButton(
                  heroTag: 'btn2',
                  onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            project_list()
                        )
                    );
                  },
                  child: Text(
                    'مشاريعي' + '\nالسابقة',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 29,
                      color: const Color(0xff1b5070),
                      shadows: [
                        Shadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.white70,
                ),
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
                    child: Container(
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
    );
  }
}

const String _svg_ftq3ej =
    '<svg viewBox="94.0 206.0 183.0 186.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(99.0, 220.0)" d="M 87 0 C 135.0487670898438 0 174 38.6638298034668 174 86.35807800292969 C 174 134.0523223876953 135.0487670898438 172.7161560058594 87 172.7161560058594 C 38.95122909545898 172.7161560058594 0 134.0523223876953 0 86.35807800292969 C 0 38.6638298034668 38.95122909545898 0 87 0 Z" fill="#1b5070" fill-opacity="0.55" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(94.0, 206.0)" d="M 91.5 0 C 142.0340576171875 0 183 39.39894485473633 183 88 C 183 136.6010589599609 142.0340576171875 176 91.5 176 C 40.96595001220703 176 0 136.6010589599609 0 88 C 0 39.39894485473633 40.96595001220703 0 91.5 0 Z" fill="#f6f9f8" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_y7pkz9 =
    '<svg viewBox="95.0 436.0 183.0 186.7" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(100.0, 450.0)" d="M 87 0 C 135.0487670898438 0 174 38.6638298034668 174 86.35807800292969 C 174 134.0523223876953 135.0487670898438 172.7161560058594 87 172.7161560058594 C 38.95122909545898 172.7161560058594 0 134.0523223876953 0 86.35807800292969 C 0 38.6638298034668 38.95122909545898 0 87 0 Z" fill="#1b5070" fill-opacity="0.55" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(95.0, 436.0)" d="M 91.5 0 C 142.0340576171875 0 183 39.39894485473633 183 88 C 183 136.6010589599609 142.0340576171875 176 91.5 176 C 40.96595001220703 176 0 136.6010589599609 0 88 C 0 39.39894485473633 40.96595001220703 0 91.5 0 Z" fill="#f6f9f8" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_mbue90 =
    '<svg viewBox="4.5 18.0 27.0 1.0" ><path  d="M 4.5 18 L 31.5 18" fill="none" stroke="#1b5070" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_k1tf7i =
    '<svg viewBox="4.5 9.0 27.0 1.0" ><path  d="M 4.5 9 L 31.5 9" fill="none" stroke="#1b5070" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_2azwiy =
    '<svg viewBox="4.5 27.0 27.0 1.0" ><path  d="M 4.5 27 L 31.5 27" fill="none" stroke="#1b5070" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
