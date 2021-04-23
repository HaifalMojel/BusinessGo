import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Project.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/ViewMap.dart';

class user_input extends StatefulWidget {
  Project project;

  user_input(proj) {
    project = proj;
  }

  @override
  _user_input createState() => _user_input(project);
}

class _user_input extends State<user_input> {
  String dropdownValue1 = 'المدينة',
      dropdownValue2 = 'القطاع',
      dropdownValue3 = 'الدولة',
      userID;

  RangeValues _currentRangeValues = const RangeValues(30, 500);

  TextEditingController nameController = TextEditingController(),
      moneyController = TextEditingController();

  bool correctMoney = true,
      notEmptyName = true,
      citySelected = false,
      qSelected = false,
      countrySelected = false;

  Project p, proj;

  _user_input(Project proj) {
    this.proj = proj;
  }

  @override
  void initState() {
    super.initState();
    if (proj != null) setData();
  }

  setData() {
    setState(() {
      dropdownValue2 = proj.industry;
      nameController.text = proj.projectName;
      moneyController.text = proj.capital.toString();
      double min = proj.minSpace, max = proj.maxSpace;
      _currentRangeValues = RangeValues(min, max);
      var userRef = Firestore.instance.collection('locations');
      userRef.document(proj.locationID).get().then((DocumentSnapshot doc) => {
            setState(() {
              dropdownValue1 = doc.data['city'];
              dropdownValue3 = doc.data['country'];
            })
          });
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
              border: Border.all(width: 1.0, color: const Color(0xff707070)),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(
                      0.0,
                      0.0,
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(
                            0.0,
                            0.0,
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height),
                        size: Size(363.0, 812.0),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffd3edea),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 1.115, 0.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color(0xffeff8f8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 9,
                MediaQuery.of(context).size.height / 4.2),
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      onChanged: (value) {
                        if (value.isEmpty)
                          setState(() {
                            notEmptyName = false;
                          });
                        else
                          setState(() {
                            notEmptyName = true;
                          });
                      },
                      textAlignVertical: TextAlignVertical.bottom,
                      textAlign: TextAlign.center,
                      controller: nameController,
                      maxLength: 20,
                      decoration: new InputDecoration(
                        focusColor: Colors.blue,
                        hintText: 'اسم المشروع',
                        hintStyle: TextStyle(
                            height: 0.0,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1b5070)),
                        errorText: notEmptyName
                            ? null
                            : '                       اسم المشروع يجب الا يكون فارغ',
                        errorStyle: TextStyle(height: 0.0),
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xff1b5070),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
          Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 15,
                  MediaQuery.of(context).size.height / 2.7),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.55,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              errorText: countrySelected
                                  ? '              يجب تحديد الدولة اولا'
                                  : null,
                              errorStyle: TextStyle(height: 0, fontSize: 14),
                              border: InputBorder.none,
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox(),
                              value: dropdownValue3,
                              icon: Icon(Icons.arrow_drop_down_circle,
                                  color: const Color(0x8b1b5070), size: 40),
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontFamily: 'STC',
                                fontSize: 17,
                                color: const Color(0x8b1b5070),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue3 = newValue;
                                  if (newValue == 'الدولة')
                                    countrySelected = true;
                                  else
                                    countrySelected = false;
                                });
                              },
                              items: <String>[
                                'الدولة',
                                'السعودية'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                      child: Text(
                                    value,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                  )),
                                );
                              }).toList(),
                            ),
                          ),
                        )),
                    Icon(Icons.location_city,
                        color: const Color(0x8b1b5070), size: 40),
                  ],
                ),
              )),
          Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 15,
                  MediaQuery.of(context).size.height / 2.15),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.55,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              errorText: citySelected
                                  ? '              يجب تحديد المدينة اولا'
                                  : null,
                              errorStyle: TextStyle(height: 0, fontSize: 14),
                              border: InputBorder.none,
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox(),
                              value: dropdownValue1,
                              icon: Icon(Icons.arrow_drop_down_circle,
                                  color: const Color(0x8b1b5070), size: 40),
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontFamily: 'STC',
                                fontSize: 17,
                                color: const Color(0x8b1b5070),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue1 = newValue;
                                  if (newValue == 'المدينة')
                                    citySelected = true;
                                  else
                                    citySelected = false;
                                });
                              },
                              items: <String>[
                                'المدينة',
                                'الرياض'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                      child: Text(
                                    value,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                  )),
                                );
                              }).toList(),
                            ),
                          ),
                        )),
                    Icon(Icons.location_city,
                        color: const Color(0x8b1b5070), size: 40),
                  ],
                ),
              )),
          Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 15,
                  MediaQuery.of(context).size.height / 1.8),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.55,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              errorText: qSelected
                                  ? '               يجب تحديد القطاع اولا'
                                  : null,
                              errorStyle: TextStyle(height: 0, fontSize: 14),
                              border: InputBorder.none,
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox(),
                              value: dropdownValue2,
                              icon: Icon(Icons.arrow_drop_down_circle,
                                  color: const Color(0x8b1b5070), size: 40),
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontFamily: 'STC',
                                fontSize: 17,
                                color: const Color(0x8b1b5070),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue2 = newValue;
                                  if (newValue == 'القطاع')
                                    qSelected = true;
                                  else
                                    qSelected = false;
                                });
                              },
                              items: <String>[
                                'القطاع',
                                'المقاهي'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                      child: Text(
                                    value,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                  )),
                                );
                              }).toList(),
                            ),
                          ),
                        )),
                    Icon(Icons.business,
                        color: const Color(0x8b1b5070), size: 40),
                  ],
                ),
              )),
          Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 15,
                  MediaQuery.of(context).size.height / 1.53),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 12, 0.0, 0.0, 0.0),
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.55,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      onChanged: (value) {
                        if (int.parse(value) < 100000)
                          setState(() {
                            correctMoney = false;
                          });
                        else
                          setState(() {
                            correctMoney = true;
                          });
                      },
                      controller: moneyController,
                      textAlignVertical: TextAlignVertical.bottom,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.blue,
                          hintText: 'رأس المال',
                          hintStyle: TextStyle(
                              height: 0.0, color: const Color(0x8b1b5070)),
                          errorText: correctMoney
                              ? null
                              : '         يجب ادخال رأس مال لايقل عن 100,000',
                          errorStyle: TextStyle(height: 0, fontSize: 14),
                          prefixIcon: const Icon(
                            Icons.attach_money,
                            size: 40.0,
                            color: const Color(0x8b1b5070),
                          )),
                    ),
                  ),
                ),
              )),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 4,
                MediaQuery.of(context).size.height / 1.36),
            child: SizedBox(
              width: 151.0,
              child: Text(
                'المساحة بالمتر المربع',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 16,
                  color: const Color(0xfe1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
              offset: Offset(10, MediaQuery.of(context).size.height / 1.36),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xffa6dcea),
                  inactiveTrackColor: Colors.white,
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 15.0,
                  thumbColor: const Color(0xffa6dcea),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 10,
                  child: RangeSlider(
                    values: _currentRangeValues,
                    min: 30,
                    max: 500,
                    divisions: 500,
                    labels: RangeLabels('-', '+'),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                ),
              )),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 12,
                MediaQuery.of(context).size.height / 1.23),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: 24.0,
              child: Text(
                ' م² ' + _currentRangeValues.start.round().toString(),
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 16,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 1.5,
                MediaQuery.of(context).size.height / 1.23),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: 22.0,
              child: Text(
                ' م² ' + _currentRangeValues.end.round().toString(),
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 16,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 3.1,
                MediaQuery.of(context).size.height / 20),
            child:
                // Adobe XD layer: 'logo3-07' (group)
                SizedBox(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 7,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(
                        0.0,
                        0.0,
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height / 2.8),
                    size: Size(MediaQuery.of(context).size.width, 320.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'logo3-07' (shape)
                        Container(
                      height: MediaQuery.of(context).size.height / 2.8,
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
              offset: Offset(MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 50),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => home_page(this.userID)));
                },
                icon: Icon(
                  Icons.backspace,
                  color: const Color(0xff1b5070),
                ),
                iconSize: 30.0,
              )),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 1.22,
                MediaQuery.of(context).size.height / 1.158),
            child: Container(
              width: 66.0,
              height: 62.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xffeff8f8),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 1.20,
                MediaQuery.of(context).size.height / 1.15),
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xffcaeeee),
              ),
            ),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width / 1.16,
              top: MediaQuery.of(context).size.height / 1.155,
              child: Draggable(
                  feedback: Container(),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.keyboard_backspace,
                        color: const Color(0xff1b5070),
                        size: 23,
                      ),
                      Icon(
                        Icons.touch_app,
                        color: const Color(0xff1b5070),
                        size: 25,
                      ),
                    ],
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (details) async {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final FirebaseUser user = await auth.currentUser();
                    final uid = user.uid;
                    if (nameController.text.isNotEmpty &&
                        moneyController.text.isNotEmpty &&
                        dropdownValue1 != 'المدينة' &&
                        dropdownValue2 != 'القطاع' &&
                        dropdownValue3 != 'الدولة' &&
                        correctMoney) {
                      p = Project(
                          nameController.text,
                          double.parse(moneyController.text).round() + 0.0,
                          dropdownValue2,
                          uid);
                      if (proj != null) p.projectID = proj.projectID;
                      p.minSpace = _currentRangeValues.start;
                      p.maxSpace = _currentRangeValues.end;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewMap(
                                  double.parse(moneyController.text).round(),
                                  p,
                                  dropdownValue1,
                                  dropdownValue3,
                                  proj)));
                    }
                    if (moneyController.text.isEmpty)
                      setState(() {
                        correctMoney = false;
                      });
                    if (nameController.text.isEmpty)
                      setState(() {
                        notEmptyName = false;
                      });
                    if (dropdownValue1 == 'المدينة')
                      setState(() {
                        citySelected = true;
                      });
                    if (dropdownValue2 == 'القطاع')
                      setState(() {
                        qSelected = true;
                      });
                    if (dropdownValue3 == 'الدولة')
                      setState(() {
                        countrySelected = true;
                      });
                  })),
        ],
      ),
    );
  }
}

const String _svg_mka4zy =
    '<svg viewBox="286.8 431.0 1.0 1.0" ><path transform="translate(287.5, 376.91)" d="M -0.721562385559082 54.08586883544922" fill="#fafafa" stroke="#85cde5" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_4sohdv =
    '<svg viewBox="46.5 164.5 283.0 1.0" ><path transform="translate(46.5, 164.5)" d="M 0 0 L 283 0" fill="none" fill-opacity="0.22" stroke="#1b5070" stroke-width="1" stroke-opacity="0.22" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_nh6um8 =
    '<svg viewBox="279.1 312.0 22.9 22.1" ><path transform="translate(274.57, 309.0)" d="M 19.78857421875 13.45263862609863 L 19.78857421875 6.484213352203369 L 15.9664306640625 3 L 12.144287109375 6.484213352203369 L 12.144287109375 8.807021141052246 L 4.5 8.807021141052246 L 4.5 25.06668090820312 L 27.432861328125 25.06668090820312 L 27.432861328125 13.45263862609863 L 19.78857421875 13.45263862609863 Z M 9.59619140625 22.74387359619141 L 7.048095226287842 22.74387359619141 L 7.048095226287842 20.42106437683105 L 9.59619140625 20.42106437683105 L 9.59619140625 22.74387359619141 Z M 9.59619140625 18.0982551574707 L 7.048095226287842 18.0982551574707 L 7.048095226287842 15.77544689178467 L 9.59619140625 15.77544689178467 L 9.59619140625 18.0982551574707 Z M 9.59619140625 13.45263862609863 L 7.048095226287842 13.45263862609863 L 7.048095226287842 11.1298303604126 L 9.59619140625 11.1298303604126 L 9.59619140625 13.45263862609863 Z M 17.240478515625 22.74387359619141 L 14.69238185882568 22.74387359619141 L 14.69238185882568 20.42106437683105 L 17.240478515625 20.42106437683105 L 17.240478515625 22.74387359619141 Z M 17.240478515625 18.0982551574707 L 14.69238185882568 18.0982551574707 L 14.69238185882568 15.77544689178467 L 17.240478515625 15.77544689178467 L 17.240478515625 18.0982551574707 Z M 17.240478515625 13.45263862609863 L 14.69238185882568 13.45263862609863 L 14.69238185882568 11.1298303604126 L 17.240478515625 11.1298303604126 L 17.240478515625 13.45263862609863 Z M 17.240478515625 8.807021141052246 L 14.69238185882568 8.807021141052246 L 14.69238185882568 6.484213352203369 L 17.240478515625 6.484213352203369 L 17.240478515625 8.807021141052246 Z M 24.884765625 22.74387359619141 L 22.336669921875 22.74387359619141 L 22.336669921875 20.42106437683105 L 24.884765625 20.42106437683105 L 24.884765625 22.74387359619141 Z M 24.884765625 18.0982551574707 L 22.336669921875 18.0982551574707 L 22.336669921875 15.77544689178467 L 24.884765625 15.77544689178467 L 24.884765625 18.0982551574707 Z" fill="none" fill-opacity="0.55" stroke="#1b5070" stroke-width="1" stroke-opacity="0.55" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cn18m2 =
    '<svg viewBox="279.0 390.0 23.0 97.0" ><path transform="translate(274.52, 459.5)" d="M 16.82380104064941 14.58446598052979 C 13.78175258636475 13.83132266998291 12.8034725189209 13.05264854431152 12.8034725189209 11.83995914459229 C 12.8034725189209 10.44855785369873 14.15698337554932 9.478407859802246 16.42176818847656 9.478407859802246 C 18.80716133117676 9.478407859802246 19.6916332244873 10.56344509124756 19.77204132080078 12.15908813476562 L 22.73368263244629 12.15908813476562 C 22.6398754119873 9.963482856750488 21.23275947570801 7.946589946746826 18.43193054199219 7.295567035675049 L 18.43193054199219 4.5 L 14.4116039276123 4.5 L 14.4116039276123 7.257271289825439 C 11.81179141998291 7.793407917022705 9.721220016479492 9.401816368103027 9.721220016479492 11.86548900604248 C 9.721220016479492 14.81423759460449 12.28082942962646 16.28223037719727 16.01973342895508 17.13749504089355 C 19.3700065612793 17.90340423583984 20.04006195068359 19.02673721313477 20.04006195068359 20.21389579772949 C 20.04006195068359 21.09469032287598 19.38340759277344 22.49885749816895 16.42176818847656 22.49885749816895 C 13.66114234924316 22.49885749816895 12.57565307617188 21.324462890625 12.42824172973633 19.81817626953125 L 9.480001449584961 19.81817626953125 C 9.640814781188965 22.61374282836914 11.83859443664551 24.18385696411133 14.4116039276123 24.70722579956055 L 14.4116039276123 27.47726440429688 L 18.43193054199219 27.47726440429688 L 18.43193054199219 24.73275756835938 C 21.04514312744141 24.26044654846191 23.122314453125 22.81798553466797 23.122314453125 20.20113182067871 C 23.122314453125 16.57582855224609 19.86584854125977 15.33761024475098 16.82380104064941 14.58446598052979 Z" fill="none" fill-opacity="0.55" stroke="#1b5070" stroke-width="1" stroke-opacity="0.55" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(279.0, 387.75)" d="M 21.34305763244629 8.409172058105469 L 15.09375 12.54678916931152 L 15.09375 9.355523109436035 C 15.09375 8.471427917480469 14.15349102020264 7.934735774993896 13.43680572509766 8.409172058105469 L 7.1875 12.54678916931152 L 7.1875 3.371710777282715 C 7.1875 2.752199411392212 6.704814434051514 2.25 6.109375 2.25 L 1.078125 2.25 C 0.4826855361461639 2.25 0 2.752199411392212 0 3.371710777282715 L 0 22.06688690185547 C 0 22.68639945983887 0.4826855361461639 23.1885986328125 1.078125 23.1885986328125 L 21.921875 23.1885986328125 C 22.51731300354004 23.1885986328125 23 22.68639945983887 23 22.06688690185547 L 23 9.355523109436035 C 23 8.471381187438965 22.05974006652832 7.934735774993896 21.34305763244629 8.409172058105469 Z" fill="none" fill-opacity="0.55" stroke="#1b5070" stroke-width="1" stroke-opacity="0.55" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t71j0c =
    '<svg viewBox="66.0 591.0 209.0 11.0" ><path transform="translate(66.0, 591.0)" d="M 5.5 0 L 203.5 0 C 206.5375671386719 0 209 2.462433815002441 209 5.5 C 209 8.537566184997559 206.5375671386719 11 203.5 11 L 5.5 11 C 2.462433815002441 11 0 8.537566184997559 0 5.5 C 0 2.462433815002441 2.462433815002441 0 5.5 0 Z" fill="#b7e0ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_s23x2 =
    '<svg viewBox="59.0 568.7 15.0 21.8" ><path transform="translate(51.52, 565.69)" d="M 14.99157524108887 3 C 10.86050701141357 3 7.500000953674316 6.423777103424072 7.500000953674316 10.63262367248535 C 7.500000953674316 16.35709190368652 14.99157524108887 24.8074951171875 14.99157524108887 24.8074951171875 C 14.99157524108887 24.8074951171875 22.483154296875 16.35709190368652 22.483154296875 10.63262367248535 C 22.483154296875 6.423777103424072 19.12264633178711 3 14.99157524108887 3 Z M 19.27247619628906 11.72299766540527 L 16.06180000305176 11.72299766540527 L 16.06180000305176 14.99412250518799 L 13.92135047912598 14.99412250518799 L 13.92135047912598 11.72299766540527 L 10.7106761932373 11.72299766540527 L 10.7106761932373 9.542248725891113 L 13.92135047912598 9.542248725891113 L 13.92135047912598 6.271124839782715 L 16.06180000305176 6.271124839782715 L 16.06180000305176 9.542248725891113 L 19.27247619628906 9.542248725891113 L 19.27247619628906 11.72299766540527 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_65e7bb =
    '<svg viewBox="10.0 10.9 11.2 9.4" ><path transform="translate(0.0, -3.48)" d="M 10.25971221923828 14.81484413146973 C 9.890252113342285 15.34218788146973 9.890252113342285 16.20703125 10.25971221923828 16.734375 L 14.97401809692383 23.44218826293945 C 15.3336238861084 23.95546913146973 15.91490745544434 23.96953201293945 16.28436660766602 23.484375 L 20.92970657348633 16.875 C 21.11689949035645 16.60781288146973 21.21049499511719 16.26328086853027 21.21049499511719 15.91171836853027 C 21.21049499511719 15.56718730926514 21.11689949035645 15.21562480926514 20.93463325500488 14.95546817779541 C 20.5651741027832 14.42812442779541 19.96418571472168 14.42109298706055 19.58979988098145 14.95546817779541 L 15.59963607788086 20.56640625 L 11.60454559326172 14.80781269073486 C 11.23508453369141 14.28046894073486 10.63409805297852 14.28046894073486 10.25971221923828 14.81484413146973 Z" fill="#7e9cad" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_j4q5fr =
    '<svg viewBox="3.4 3.4 24.5 23.0" ><path  d="M 3.375 14.87862491607666 C 3.375 21.23327445983887 8.847289085388184 26.38225173950195 15.60095119476318 26.38225173950195 C 22.35461616516113 26.38225173950195 27.826904296875 21.23327445983887 27.826904296875 14.87862491607666 C 27.826904296875 8.523979187011719 22.35461616516113 3.375 15.60095119476318 3.375 C 8.847288131713867 3.375 3.375 8.523979187011719 3.375 14.87862491607666 Z M 22.91301345825195 7.99857234954834 C 24.87034034729004 9.83472728729248 25.94598960876465 12.27924823760986 25.94598960876465 14.87862491607666 C 25.94598960876465 17.47800254821777 24.87034034729004 19.92252349853516 22.91301345825195 21.75868034362793 C 20.96156311035156 23.60036659240723 18.36354827880859 24.61246299743652 15.60095119476318 24.61246299743652 C 12.83835697174072 24.61246299743652 10.24034118652344 23.60036659240723 8.28889274597168 21.75868034362793 C 6.331564426422119 19.92252349853516 5.255915641784668 17.47800254821777 5.255915641784668 14.87862491607666 C 5.255915641784668 12.27924823760986 6.331564426422119 9.83472728729248 8.28889274597168 7.99857234954834 C 10.24034118652344 6.156886100769043 12.83835697174072 5.14478874206543 15.60095119476318 5.14478874206543 C 18.36354827880859 5.14478874206543 20.96156311035156 6.156886100769043 22.91301345825195 7.99857234954834 Z" fill="#7e9cad" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_js5qfv =
    '<svg viewBox="0.0 2.3 23.7 17.3" ><path  d="M 9.973712921142578 3.484802484512329 L 20.66769790649414 3.484802484512329 C 21.50189590454102 3.484802484512329 22.17814826965332 4.037642002105713 22.17814826965332 4.719604969024658 L 22.17814826965332 17.067626953125 C 22.17814826965332 17.74959182739258 21.50189781188965 18.30242919921875 20.66770172119141 18.30242919921875 L 9.973713874816895 18.30242919921875 C 9.532245635986328 18.30252265930176 9.112825393676758 18.14471817016602 8.825773239135742 17.87052536010742 L 1.51049542427063 10.89361572265625 L 8.827114105224609 3.916708946228027 C 9.113861083984375 3.642805814743042 9.532713890075684 3.48503041267395 9.973712921142578 3.484802484512329 Z M 20.66769790649414 2.25 C 22.33609390258789 2.25 23.6885986328125 3.355679988861084 23.6885986328125 4.719604969024658 L 23.6885986328125 17.067626953125 C 23.6885986328125 18.43155288696289 22.33609580993652 19.53723335266113 20.66770172119141 19.53723335266113 L 9.973713874816895 19.53723335266113 C 9.091571807861328 19.53750991821289 8.253352165222168 19.2225513458252 7.679173946380615 18.6750659942627 L 0.3638963997364044 11.69651126861572 C -0.1211129948496819 11.23405075073242 -0.1211126744747162 10.55153560638428 0.3638966679573059 10.08907318115234 L 7.679172039031982 3.114361763000488 C 8.252845764160156 2.566060543060303 9.091136932373047 2.250272989273071 9.973712921142578 2.25 L 20.66769790649414 2.25 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_iz61ih =
    '<svg viewBox="7.5 5.5 13.5 10.8" ><path transform="translate(-5.28, -5.75)" d="M 13.11699962615967 11.51259899139404 C 12.90540599822998 11.68125629425049 12.78648853302002 11.91026020050049 12.78648853302002 12.14907836914062 C 12.78648853302002 12.38789749145508 12.90540599822998 12.61690139770508 13.11699962615967 12.78555774688721 L 24.36700057983398 21.77537155151367 C 24.80689811706543 22.12644958496094 25.5196590423584 22.1260871887207 25.9590015411377 21.77457046508789 C 26.39834213256836 21.42305374145508 26.39789581298828 20.85348892211914 25.95800018310547 20.50241470336914 L 14.70800018310547 11.51259899139404 C 14.49694061279297 11.34351634979248 14.21036148071289 11.24848937988281 13.91149997711182 11.24848937988281 C 13.61263847351074 11.24848937988281 13.32605934143066 11.34351634979248 13.11499977111816 11.51259899139404 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qjhksf =
    '<svg viewBox="7.5 5.5 13.5 10.8" ><path transform="translate(-5.28, -5.75)" d="M 25.95800018310547 11.51279926300049 C 26.16959381103516 11.6814546585083 26.28851127624512 11.91045761108398 26.28851127624512 12.1492748260498 C 26.28851127624512 12.38809204101562 26.16959381103516 12.61709403991699 25.95800018310547 12.78575038909912 L 14.70800018310547 21.77551651000977 C 14.26810741424561 22.12703323364258 13.55489635467529 22.12703323364258 13.11500072479248 21.77552032470703 C 12.67510604858398 21.42400360107422 12.67510604858398 20.85408020019531 13.11500072479248 20.50256729125977 L 24.36499977111816 11.51279926300049 C 24.80434036254883 11.16172122955322 25.51665878295898 11.16172122955322 25.95599937438965 11.51279926300049 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
