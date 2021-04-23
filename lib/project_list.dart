import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_app/Project.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/sign_page.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter_app/user_nav.dart';
import 'package:flutter_app/fav_list.dart';

class project_list extends StatefulWidget{
  @override
  _project_list_state createState() => _project_list_state();
}

class _project_list_state extends State<project_list> {

  List<Project> entries = [];

  List<Project> filtered = [];

  List<String> ids = [];

  var userRef = Firestore.instance.collection('project');

  String uid , pid = '';

  getProjects () async {
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseUser user = await auth.currentUser();
      uid = user.uid;
      userRef.getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((DocumentSnapshot doc) {
          if(uid == doc.data['owner']) {
            setState(() {
              var project = Project(doc.data['name'], doc.data['capital'] + 0.0,
                  doc.data['industry'], doc.data['owner']);
              project.isFavourite = doc.data['favourite'];
              project.locationID = doc.data['locationID'];
              project.revenueID = doc.data['revenueID'];
              project.projectCostsID = doc.data['costsID'];
              project.minSpace = doc.data['minSpace'];
              project.maxSpace = doc.data['maxSpace'];
              project.space = doc.data['space'];
              entries.add(project);
              filtered.add(project);
              ids.add(doc.documentID);
            });
          }
        });
      });
    }catch(ex){}
  }

  @override
  void initState(){
    super.initState();
    getProjects ();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff8f8),
      body: Stack(
        children: <Widget>[
          Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/1.25, MediaQuery.of(context).size.height/40),
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
                            padding: const EdgeInsets.fromLTRB(0 , 10 , 10 , 0),
                            child: new Container(
                              height: MediaQuery.of(context).size.height/4,
                              width: MediaQuery.of(context).size.width/1.8,
                              color: const Color.fromRGBO(255 , 255 , 255 , 0.82),
                              child: new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
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
                                                    home_page(uid)
                                                ));
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
                                              child: Text('     مفضلاتي       ',
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
                  color: const Color(0xff1b5070),
                ),
              )
          ),
          Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.height/4.5),
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
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/3.8, MediaQuery.of(context).size.height/10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/1.35,
              child: Text(
                'قائمة المشاريع السابقة',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 30,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/3, MediaQuery.of(context).size.height/6.5),
            child: SizedBox(
                width: MediaQuery.of(context).size.width/1.7,
                height: MediaQuery.of(context).size.height/20,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                      onChanged: (value) {
                        setState(() {
                          filtered.clear();
                          for(int i = 0; i < entries.length; i++)
                            if(entries[i].projectName.contains(value))
                              filtered.add(entries[i]);
                        });
                      },
                      decoration: new InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        hintText: 'ابحث عن مشروع',
                        hintStyle: TextStyle(height: 0.0),
                      )
                  ),
                )
            ),
          ),
          Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.height/50),
              child: IconButton(
                onPressed: () async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                          (context) =>  home_page(user.uid)));
                },
                icon: Icon(
                  Icons.backspace,
                  color: const Color(0xff1b5070),
                ),
                iconSize: 30.0,
              )
          ),
          Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.height/2.5),
            child: Container(constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height),
              padding: EdgeInsets.fromLTRB(0, 15, 0, MediaQuery.of(context).size.height/2.5),
              child: filtered.isNotEmpty ? ListView.separated(
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: true,
                  itemCount: filtered.length,
                  separatorBuilder: (cont , index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        color: index % 2 == 1? const Color(0xFFD3FAFA):const Color(0xFFB9E1F0),
                        height: 100,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Transform.translate(
                                    offset: Offset(MediaQuery.of(context).size.width/25, MediaQuery.of(context).size.height/35),
                                    child: IconButton(
                                      onPressed: () async {
                                        filtered[index].projectID = ids[entries.indexOf(filtered[index])];
                                        FirebaseUser user = await FirebaseAuth.instance.currentUser();
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder:
                                                (context) =>  user_nav(filtered[index])));
                                      },
                                      icon: Icon(
                                        Icons.touch_app ,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      iconSize: 30.0,
                                    )
                                ),
                                Transform.translate(
                                  offset: Offset(MediaQuery.of(context).size.width/11 , MediaQuery.of(context).size.height/35),
                                  child: IconButton(
                                    icon: filtered[index].isFavourite? Icon(Icons.favorite): Icon(Icons.favorite_border_outlined),
                                    iconSize: 30,
                                    onPressed: () async {
                                      if(filtered[index].isFavourite){
                                        if (await confirm(
                                          context,
                                          title: Text('تأكيد حذف مشروع من المفضلات'),
                                          content: Text('هل تريد حذف هذا المشروع من المفضلات؟'),
                                          textOK: Text('تأكيد'),
                                          textCancel: Text('إلغاء'),
                                        )) {
                                          setState(() {
                                            filtered[index].isFavourite = false;
                                            userRef.document(ids[entries.indexOf(filtered[index])]).setData({
                                              'name' : filtered[index].projectName,
                                              'capital': filtered[index].capital,
                                              'industry': filtered[index].industry,
                                              'owner': filtered[index].projectOwnerID,
                                              'favourite': false,
                                              'locationID': filtered[index].locationID,
                                              'revenueID': filtered[index].revenueID,
                                              'costsID': filtered[index].projectCostsID,
                                              'minSpace': filtered[index].minSpace,
                                              'maxSpace': filtered[index].maxSpace,
                                              'space': filtered[index].space,
                                            });
                                          });
                                        }
                                      }
                                      else{
                                        if (await confirm(
                                          context,
                                          title: Text('تأكيد اضافة مشروع إلي المفضلات'),
                                          content: Text('هل تريد إضافة هذا المشروع إلي المفضلات؟'),
                                          textOK: Text('تأكيد'),
                                          textCancel: Text('إلغاء'),
                                        )) {
                                          setState(() {
                                            filtered[index].isFavourite = true;
                                            userRef.document(ids[entries.indexOf(filtered[index])]).setData({
                                              'name' : filtered[index].projectName,
                                              'capital': filtered[index].capital,
                                              'industry': filtered[index].industry,
                                              'owner': filtered[index].projectOwnerID,
                                              'favourite': true,
                                              'locationID': filtered[index].locationID,
                                              'revenueID': filtered[index].revenueID,
                                              'costsID': filtered[index].projectCostsID,
                                              'minSpace': filtered[index].minSpace,
                                              'maxSpace': filtered[index].maxSpace,
                                              'space': filtered[index].space,
                                            });
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(MediaQuery.of(context).size.width/7 , MediaQuery.of(context).size.height/35),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 30,
                                    onPressed: () async {
                                      if (await confirm(
                                        context,
                                        title: Text('تأكيد حذف مشروع من قائمة المشاريع'),
                                        content: Text('هل تريد حذف هذا المشروع من قائمة المشاريع؟'),
                                        textOK: Text('تأكيد'),
                                        textCancel: Text('إلغاء'),
                                      )) {
                                        setState(() {
                                          userRef.document(ids[entries.indexOf(filtered[index])]).delete();
                                          entries.remove(filtered[index]);
                                          filtered.removeAt(index);
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(MediaQuery.of(context).size.width/4 , MediaQuery.of(context).size.height/30),
                                  child: Text(
                                    filtered[index].projectName,
                                    style: TextStyle(
                                      fontFamily: 'STC',
                                      fontSize: 25,
                                      color: const Color(0xff1b5070),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    );
                  }
              ): Center(
                child: Text(
                  'لا يوجد اي مشاريع',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 28,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

