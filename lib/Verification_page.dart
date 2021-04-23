import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sign_page.dart';
import 'sign_welcome.dart';

class verification_page extends StatelessWidget {

  final collRef = Firestore.instance.collection('BusinessOwner');

  FirebaseUser newUser;

  verification_page(FirebaseUser user){
    newUser = user;


  }

  alert1Dialog(BuildContext context) {
    // This is the ok button
    Widget ok = FlatButton(
      child: Text("تم"),
      onPressed: () {Navigator.of(context).pop();},
    );
    // show the alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("خطأ بالتحقق بالبريد"),
          content: Text("يجب تحقق بريدك الالكتروني الخاص بك أولا قبل الدخول إلى حسابك"),
          actions: [
            ok,
          ],
          elevation: 5,

        );
      },
    );
  }

  alert2Dialog(BuildContext context) {
    // This is the ok button
    Widget ok = FlatButton(
      child: Text("تم"),
      onPressed: () {Navigator.of(context).pop();},
    );
    // show the alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("إرسال بريد الالكتروني اخر للتأكيد"),
          content: Text("تم إرسال بريد اخر لتأكيد بريدك الالكتروني"),
          actions: [
            ok,
          ],
          elevation: 5,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdae7e7),
      body: Center(
        child: Container(
          padding: new EdgeInsets.fromLTRB(5.0,100.0,5.0,0),
          child: Column(
            children: <Widget>[
              Text(
                'تم ارسال بريد التحقق الى البريد الالكتروني',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 18,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                newUser.email,
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 18,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
              Transform.translate(
                offset: Offset(0, MediaQuery.of(context).size.height/6),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.7,
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.7,
                    height: MediaQuery.of(context).size.width/5,
                    child: FloatingActionButton.extended(
                      heroTag: 'btn1',
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: ()  async {
                        if(newUser == null){
                          alert1Dialog(context);


                          }
                        //user.reload();
                       // print(FirebaseAuth.instance.currentUser());

                        else{
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                        (context) =>
                        sign_welcome(newUser.uid)
                        )
                        );}
                      },
                      label:Text(
                          'الذهاب إلى حسابي',
                          style: TextStyle(
                            fontFamily: 'STC',
                            fontSize: 24,
                            color: const Color(0xff1b5070),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      backgroundColor: Colors.white70,
                      ),
                    ),
                  ),
                ),
              Transform.translate(
                offset: Offset(0, MediaQuery.of(context).size.height/5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.7,
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.7,
                    height: MediaQuery.of(context).size.width/5,
                    child: FloatingActionButton.extended(
                      heroTag: 'btn2',
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: (){
                        newUser.sendEmailVerification();
                        alert2Dialog(context);
                      },
                      label:Text(
                        'إعادة إرسال بريد التحقق',
                        style: TextStyle(
                          fontFamily: 'STC',
                          fontSize: 24,
                          color: const Color(0xff1b5070),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.white70,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, MediaQuery.of(context).size.height/4),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.height/15,
                    child: FlatButton(
                      child:Text(
                        'الرجوع إلى صفحةالتسجيل',
                        style: TextStyle(
                          fontFamily: 'STC',
                          fontSize: 24,
                          color: const Color(0xff01756a),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      textTheme: ButtonTextTheme.primary,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder:
                                (context) =>
                                sign_page()
                            )
                        );
                      },
                    )
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, MediaQuery.of(context).size.height/2.8),
                child: Container(
                  height: MediaQuery.of(context).size.height/5,
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
        )
      )
    );
  }
}

