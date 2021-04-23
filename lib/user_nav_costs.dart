import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_app/user_input.dart';
import 'package:flutter_app/user_nav_map.dart';
import 'package:flutter_app/user_nav_revenue.dart';
import 'package:intl/intl.dart';

import 'Project.dart';
import 'home_page.dart';

class user_nav_costs extends StatefulWidget {

  var project;

  user_nav_costs( project){
    this.project = project;
  }

  _user_nav_cost_state createState() => _user_nav_cost_state(project);
}
class _user_nav_cost_state extends State<user_nav_costs> {

  double capital  = 300000, fixedCost = 0 , variableCost = 0 , FCost = 0 , eqCost = 0 , rCost = 0;
  Project project;

  _user_nav_cost_state(project){
    this.project = project;
    capital = project.capital;
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  getData() async{
    var userRef = Firestore.instance.collection('costs');
    try{
      await userRef.document(project.projectCostsID).get().then((DocumentSnapshot doc) => {
      setState((){
        fixedCost = doc.data['fixedCost'];
        variableCost = doc.data['variableCost'];
        FCost = doc.data['FCost'];
        eqCost = doc.data['eqCost'];
        rCost = doc.data['rCost'];
      })
      });
    }catch(Exception){}
  }


  String getCategory(double capital){
    if(capital < 300000)
      return 'الاقتصادية';
    else if(capital < 500000)
      return 'القياسية';
    else
      return 'الممتازة';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff8f8),
      body: Stack(
        children: <Widget>[
          Scaffold(
              bottomNavigationBar: ConvexAppBar(
                items: [
                  TabItem(icon: Icon(Icons.home , size: 35, color: Colors.teal), title: ''),
                  TabItem(icon: Icon(Icons.map , size: 35, color: Colors.teal), title: ''),
                  TabItem(icon: Icon(Icons.monetization_on , size: 35, color: Colors.teal), title: ''),
                  TabItem(icon: Icon(Icons.show_chart , size: 35, color: Colors.teal), title: ''),
                  TabItem(icon: Icon(Icons.settings , size: 35, color: Colors.teal), title: ''),
                ],
                initialActiveIndex: 2,//optional, default as 0
                onTap: (int i) => {
                  if(i == 0){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            home_page(project.projectOwnerID)
                        )
                    )
                  }
                  else if(i == 3){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            user_nav_revenue(project)
                        )
                    )
                  }
                  else if(i == 1){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              user_nav_map(project)
                          )
                      )
                    }
                    else if(i == 4){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder:
                                (context) =>
                                user_input(project)
                            )
                        )
                      }
                },
                backgroundColor: const Color(0xffeff8f8),
              )
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/1.1,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: const Color(0xff707070)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/4.5,
            decoration: BoxDecoration(
              color: const Color(0xffb7e0ee),
            ),
          ),
          Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.height/20),
            child:
            // Adobe XD layer: 'logo3-07' (group)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/7,
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
            offset: Offset(MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.height/7),
            child: Container(
              width: 322.0,
              height: 113.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xffffffff),
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
            offset: Offset(MediaQuery.of(context).size.width/2.5, MediaQuery.of(context).size.height/6.5),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/2.2,
              child: Text(
                'التكلفة الإجمالية',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 25,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/2.5, MediaQuery.of(context).size.height/4.6),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/2.2,
              child: Text(
                capital.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SAR',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 25,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/18, MediaQuery.of(context).size.height/3.3),
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width/1.12,
                height: MediaQuery.of(context).size.height/12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              onTap: (){
              },
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/18, MediaQuery.of(context).size.height/2.4),
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width/1.12,
                height: MediaQuery.of(context).size.height/12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              onTap: (){
              },
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/18, MediaQuery.of(context).size.height/1.89),
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width/1.12,
                height: MediaQuery.of(context).size.height/12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              onTap: (){
              },
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/18, MediaQuery.of(context).size.height/1.56),
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width/1.12,
                height: MediaQuery.of(context).size.height/12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              onTap: (){
              },
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/18, MediaQuery.of(context).size.height/1.325),
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width/1.12,
                height: MediaQuery.of(context).size.height/12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              onTap: (){
              },
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/9, MediaQuery.of(context).size.height/4.7),
            child: SizedBox(
              width: 90.0,
              child: Text(
                getCategory(capital),
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 20,
                  color: const Color(0xff01756a),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/1.9, MediaQuery.of(context).size.height/3.24),
            child: SizedBox(
                width: MediaQuery.of(context).size.width/2.5,
                height: MediaQuery.of(context).size.height/14,
                child: OutlineButton(borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.solid
                ),
                  onPressed: (){
                  },
                  child: Text(
                    'التكاليف الثابتة',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff01756a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/1.9, MediaQuery.of(context).size.height/2.36),
            child: SizedBox(
                width: MediaQuery.of(context).size.width/2.5,
                height: MediaQuery.of(context).size.height/14,
                child: OutlineButton(borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.solid
                ),
                  onPressed: (){
                  },
                  child: Text(
                    'التكاليف المتغيرة',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff01756a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/1.9, MediaQuery.of(context).size.height/1.87),
            child: SizedBox(
                width: MediaQuery.of(context).size.width/2.5,
                height: MediaQuery.of(context).size.height/14,
                child: OutlineButton(borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.solid
                ),
                  onPressed: (){
                  },
                  child: Text(
                    'تكاليف الأثاث',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff01756a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/1.9, MediaQuery.of(context).size.height/1.545),
            child: SizedBox(
                width: MediaQuery.of(context).size.width/2.5,
                height: MediaQuery.of(context).size.height/14,
                child: OutlineButton(borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.solid
                ),
                  onPressed: (){
                  },
                  child: Text(
                    'تكاليف المعدات',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff01756a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/1.9, MediaQuery.of(context).size.height/1.315),
            child: SizedBox(
                width: MediaQuery.of(context).size.width/2.5,
                height: MediaQuery.of(context).size.height/14,
                child: OutlineButton(borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.solid
                ),
                  onPressed: (){
                  },
                  child: Text(
                    'سعر الإيجار',
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff01756a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          ),

          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/13, MediaQuery.of(context).size.height/1.31),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/3.8,
              child: Text(
                rCost.round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SAR',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 17,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/13, MediaQuery.of(context).size.height/1.53),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/3.8,
              child: Text(
                eqCost.round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SAR',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 17,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/13, MediaQuery.of(context).size.height/1.83),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/3.8,
              child: Text(
                FCost.round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SAR',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 17,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/13, MediaQuery.of(context).size.height/2.3),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/3.8,
              child: Text(
                variableCost.round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SAR',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 17,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/13, MediaQuery.of(context).size.height/3.1),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/3.8,
              child: Text(
                fixedCost.round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SAR',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 17,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/2.3, MediaQuery.of(context).size.height/1.496),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/8.9,
              child: Text(
                NumberFormat("##.##").format(eqCost*100/capital).toString() + '%',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 12,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/2.3, MediaQuery.of(context).size.height/1.792),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/8.9,
              child: Text(
                NumberFormat("##.##").format(FCost*100/capital).toString() + '%',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 12,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/2.3, MediaQuery.of(context).size.height/2.235),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/8.9,
              child: Text(
                NumberFormat("##.##").format(variableCost*100/capital).toString() + '%',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 12,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/2.3, MediaQuery.of(context).size.height/3),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/8.9,
              child: Text(
                NumberFormat("##.##").format(fixedCost*100/capital).toString() + '%',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 12,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/2.3, MediaQuery.of(context).size.height/1.279),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/8.9,
              child: Text(
                NumberFormat("##.##").format(rCost*100/capital).toString() + '%',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 12,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/9, MediaQuery.of(context).size.height/5.5),
            child: SizedBox(
              width: 72.0,
              child: Text(
                'التصنيف:',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 18,
                  color: const Color(0xff1b5070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
              offset: Offset(10, MediaQuery.of(context).size.height/1.325),
              child:SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  disabledActiveTrackColor: const Color(0xffa6dcea),
                  disabledInactiveTrackColor: const Color(0xffbdceca),
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 10.0,
                  disabledThumbColor: const Color(0xffa6dcea),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.8,
                  height: MediaQuery.of(context).size.height/10,
                  child: Slider(
                    min: 0,
                    max: capital,
                    divisions: capital.round(),
                    value: rCost,
                    onChanged: null,
                  ),
                ),
              )
          ),
          Transform.translate(
              offset: Offset(10, MediaQuery.of(context).size.height/1.56),
              child:SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  disabledActiveTrackColor: const Color(0xffa6dcea),
                  disabledInactiveTrackColor: const Color(0xffbdceca),
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 10.0,
                  disabledThumbColor: const Color(0xffa6dcea),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.8,
                  height: MediaQuery.of(context).size.height/10,
                  child: Slider(
                    min: 0,
                    max: capital,
                    divisions: capital.round(),
                    value: eqCost,
                    onChanged: null,
                  ),
                ),
              )
          ),
          Transform.translate(
              offset: Offset(10, MediaQuery.of(context).size.height/1.88),
              child:SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  disabledActiveTrackColor: const Color(0xffa6dcea),
                  disabledInactiveTrackColor: const Color(0xffbdceca),
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 10.0,
                  disabledThumbColor: const Color(0xffa6dcea),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.8,
                  height: MediaQuery.of(context).size.height/10,
                  child: Slider(
                    min: 0,
                    max: capital,
                    divisions: capital.round(),
                    value: FCost,
                    onChanged: null,
                  ),
                ),
              )
          ),
          Transform.translate(
              offset: Offset(10, MediaQuery.of(context).size.height/2.38),
              child:SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  disabledActiveTrackColor: const Color(0xffa6dcea),
                  disabledInactiveTrackColor: const Color(0xffbdceca),
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 10.0,
                  disabledThumbColor: const Color(0xffa6dcea),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.8,
                  height: MediaQuery.of(context).size.height/10,
                  child: Slider(
                    min: 0,
                    max: capital,
                    value: variableCost,
                    divisions: capital.round(),
                    onChanged: null,
                  ),
                ),
              )
          ),
          Transform.translate(
              offset: Offset(10, MediaQuery.of(context).size.height/3.26),
              child:SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  disabledActiveTrackColor: const Color(0xffa6dcea),
                  disabledInactiveTrackColor: const Color(0xffbdceca),
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 10.0,
                  disabledThumbColor: const Color(0xffa6dcea),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.8,
                  height: MediaQuery.of(context).size.height/10,
                  child: Slider(
                    min: 0,
                    max: capital,
                    divisions: capital.round(),
                    value: fixedCost,
                    onChanged: null,
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}

const String _svg_nde5q4 =
    '<svg viewBox="0.0 0.0 40.0 6.0" ><path  d="M 1.051674365997314 0 L 38.91195297241211 0 C 39.49277496337891 0 39.963623046875 1.343145728111267 39.963623046875 3 C 39.963623046875 4.656854629516602 39.49277496337891 6 38.91195297241211 6 L 1.051674365997314 6 C 0.4708506762981415 6 0 4.656854629516602 0 3 C 0 1.343145728111267 0.4708506762981415 0 1.051674365997314 0 Z" fill="#b7e0ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eudj0g =
    '<svg viewBox="0.0 0.0 51.5 6.0" ><path  d="M 1.3558030128479 0 L 50.16471099853516 0 C 50.91350173950195 0 51.5205078125 1.343145728111267 51.5205078125 3 C 51.5205078125 4.656854629516602 50.91350173950195 6 50.16471099853516 6 L 1.3558030128479 6 C 0.6070137023925781 6 0 4.656854629516602 0 3 C 0 1.343145728111267 0.6070137023925781 0 1.3558030128479 0 Z" fill="#b7e0ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_asr8jc =
    '<svg viewBox="40.0 420.0 14.7 6.0" ><path transform="translate(40.0, 420.0)" d="M 0.3873034417629242 0 L 14.33022689819336 0 C 14.54412841796875 0 14.71752834320068 1.343145728111267 14.71752834320068 3 C 14.71752834320068 4.656854629516602 14.54412841796875 6 14.33022689819336 6 L 0.3873034417629242 6 C 0.1734016537666321 6 0 4.656854629516602 0 3 C 0 1.343145728111267 0.1734016537666321 0 0.3873034417629242 0 Z" fill="#b7e0ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_46yhl9 =
    '<svg viewBox="40.0 710.0 69.0 6.0" ><path transform="translate(40.0, 710.0)" d="M 1.81616222858429 0 L 67.19800567626953 0 C 68.20104217529297 0 69.01416015625 1.343145728111267 69.01416015625 3 C 69.01416015625 4.656854629516602 68.20104217529297 6 67.19800567626953 6 L 1.81616222858429 6 C 0.8131235241889954 6 0 4.656854629516602 0 3 C 0 1.343145728111267 0.8131235241889954 0 1.81616222858429 0 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qibjef =
    '<svg viewBox="0.4 0.0 44.8 44.7" ><path transform="translate(-91.94, -110.02)" d="M 104.0078125 131.1442413330078 C 104.0078125 137.0272369384766 109.1146469116211 141.7962951660156 115.4142608642578 141.7962951660156 C 121.7138748168945 141.7962951660156 126.8207092285156 137.0272369384766 126.8207092285156 131.1442413330078 C 126.8207092285156 125.2612686157227 121.7138748168945 120.4921875 115.4142608642578 120.4921875 C 109.1177291870117 120.4987716674805 104.0148696899414 125.2641448974609 104.0078125 131.1442413330078 Z M 115.4142608642578 131.8173828125 C 113.5214157104492 131.8272705078125 111.9175109863281 130.5180969238281 111.6753311157227 128.7648620605469 C 111.4331588745117 127.0120315551758 112.6285934448242 125.3650817871094 114.4623260498047 124.9263534545898 L 114.4623260498047 124.0258407592773 C 114.4623260498047 123.6180267333984 114.8161010742188 123.2876434326172 115.252815246582 123.2876434326172 C 115.6895141601562 123.2876434326172 116.0432968139648 123.6180267333984 116.0432968139648 124.0258407592773 L 116.0432968139648 124.881462097168 C 117.8368835449219 125.1648788452148 119.1461181640625 126.62109375 119.134651184082 128.3203735351562 C 119.134651184082 128.7232513427734 118.7848434448242 129.0499267578125 118.3534317016602 129.0499267578125 C 117.9220199584961 129.0499267578125 117.5722045898438 128.7232513427734 117.5722045898438 128.3203735351562 C 117.5708847045898 127.2052459716797 116.6021957397461 126.30224609375 115.4080810546875 126.3034896850586 C 114.2139739990234 126.3047256469727 113.2470397949219 127.2097625732422 113.2488098144531 128.3249053955078 C 113.2501373291016 129.4396362304688 114.2192687988281 130.3425903320312 115.4133758544922 130.3409576416016 C 117.3494491577148 130.3512573242188 118.9573287963867 131.7386779785156 119.120979309082 133.54052734375 C 119.2846374511719 135.3419494628906 117.9498138427734 136.9625396728516 116.0432968139648 137.2772674560547 L 116.0432968139648 138.1571807861328 C 116.0432968139648 138.5650024414062 115.6895141601562 138.8953704833984 115.252815246582 138.8953704833984 C 114.8161010742188 138.8953704833984 114.4623260498047 138.5650024414062 114.4623260498047 138.1571807861328 L 114.4623260498047 137.2319488525391 C 112.8103408813477 136.8245544433594 111.6559219360352 135.4338226318359 111.6448974609375 133.8383636474609 C 111.6448974609375 133.4259948730469 112.0030899047852 133.0915069580078 112.4446563720703 133.0915069580078 C 112.8862075805664 133.0915069580078 113.2444000244141 133.4259948730469 113.2444000244141 133.8383636474609 C 113.2470397949219 134.8694610595703 114.078987121582 135.734130859375 115.1764984130859 135.8465881347656 C 115.2170715332031 135.8404083251953 115.2585372924805 135.8375244140625 115.3000183105469 135.8371124267578 C 115.3595657348633 135.8371124267578 115.4186706542969 135.8437194824219 115.4768905639648 135.8560485839844 C 116.6626281738281 135.8288726806641 117.6035385131836 134.9151763916016 117.5863265991211 133.8078918457031 C 117.5691223144531 132.7001647949219 116.599983215332 131.8124237060547 115.4142608642578 131.8173828125 Z M 115.4142608642578 131.8173828125" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-56.68, -319.71)" d="M 98.45213317871094 353.8003540039062 C 98.44640350341797 353.80322265625 98.44023132324219 353.8061218261719 98.43360137939453 353.8089904785156 L 91.09560394287109 357.0464477539062 C 91.174560546875 357.4258728027344 91.20896911621094 357.8118896484375 91.19793701171875 358.1982727050781 C 91.18647003173828 358.5978088378906 90.83621978759766 358.916259765625 90.40833282470703 358.916259765625 C 90.40083312988281 358.916259765625 90.39334106445312 358.916259765625 90.38583374023438 358.916259765625 L 79.6463623046875 358.6402893066406 C 79.20965576171875 358.629150390625 78.86558532714844 358.2897033691406 78.87749481201172 357.8818969726562 C 78.889404296875 357.4740600585938 79.25332641601562 357.1527404785156 79.68959808349609 357.1638793945312 L 89.56139373779297 357.4176330566406 C 89.23407745361328 355.6310119628906 87.60282897949219 354.307861328125 85.66278076171875 354.255126953125 L 79.12981414794922 354.0874633789062 C 77.83953857421875 354.0528564453125 76.57441711425781 353.7476196289062 75.42794799804688 353.1943664550781 L 74.76318359375 352.873046875 C 71.49846649169922 351.2846069335938 67.56455993652344 351.4913940429688 64.51158905029297 353.4123229980469 L 64.25 362.2876281738281 L 65.37265014648438 361.7261657714844 C 66.48823547363281 361.1659240722656 67.79351043701172 361.0324096679688 69.01275634765625 361.3541564941406 L 80.09983062744141 364.2604064941406 C 82.23661804199219 364.6690673828125 84.45720672607422 364.4375610351562 86.44488525390625 363.5980224609375 L 101.8050842285156 354.3193664550781 C 100.9285736083984 353.4814758300781 99.57125091552734 353.27099609375 98.45213317871094 353.8003540039062 Z M 98.45213317871094 353.8003540039062" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, -309.64)" d="M 0.359375 353.7556762695312 L 0.7488827705383301 340.55078125 L 6.332562446594238 340.694580078125 L 5.943054676055908 353.8994445800781 L 0.359375 353.7556762695312 Z M 0.359375 353.7556762695312" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-174.95, 0.0)" d="M 199.1669006347656 8.75299072265625 L 199.1669006347656 0.7382041215896606 C 199.1669006347656 0.3303792178630829 198.8131256103516 0 198.3764190673828 0 C 197.9397125244141 0 197.5859222412109 0.3303792178630829 197.5859222412109 0.7382041215896606 L 197.5859222412109 8.75299072265625 C 197.5859222412109 9.160815238952637 197.9397125244141 9.491194725036621 198.3764190673828 9.491194725036621 C 198.8131256103516 9.491194725036621 199.1669006347656 9.160815238952637 199.1669006347656 8.75299072265625 Z M 199.1669006347656 8.75299072265625" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-228.18, -35.78)" d="M 259.1669006347656 44.53468322753906 L 259.1669006347656 40.73820877075195 C 259.1669006347656 40.33037948608398 258.8131103515625 40 258.3764343261719 40 C 257.9397277832031 40 257.5859375 40.33037948608398 257.5859375 40.73820877075195 L 257.5859375 44.53468322753906 C 257.5859375 44.94250869750977 257.9397277832031 45.27288436889648 258.3764343261719 45.27288436889648 C 258.8131103515625 45.27288436889648 259.1669006347656 44.94250869750977 259.1669006347656 44.53468322753906 Z M 259.1669006347656 44.53468322753906" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-121.73, -35.78)" d="M 139.1669006347656 44.53468322753906 L 139.1669006347656 40.73820877075195 C 139.1669006347656 40.33037948608398 138.8131103515625 40 138.3764190673828 40 C 137.939697265625 40 137.5859375 40.33037948608398 137.5859375 40.73820877075195 L 137.5859375 44.53468322753906 C 137.5859375 44.94250869750977 137.939697265625 45.27288436889648 138.3764190673828 45.27288436889648 C 138.8131103515625 45.27288436889648 139.1669006347656 44.94250869750977 139.1669006347656 44.53468322753906 Z M 139.1669006347656 44.53468322753906" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yh8fmc =
    '<svg viewBox="85.3 760.5 36.8 32.6" ><path transform="translate(85.25, 760.5)" d="M 18.375 0 C 13.93501281738281 0 10.3359375 3.596327304840088 10.3359375 8.032924652099609 C 10.3359375 11.61968898773193 15.59003829956055 18.15695762634277 17.60299491882324 20.52985954284668 C 18.01069068908691 21.01055908203125 18.73994636535645 21.01055908203125 19.14700508117676 20.52985954284668 C 21.15996170043945 18.15695762634277 26.41406059265137 11.61968898773193 26.41406059265137 8.032924652099609 C 26.41406059265137 3.596327304840088 22.81498718261719 0 18.375 0 Z M 18.375 10.71056461334229 C 16.89479064941406 10.71056461334229 15.6953125 9.512001991271973 15.6953125 8.032924652099609 C 15.6953125 6.553845882415771 16.89479064941406 5.355282306671143 18.375 5.355282306671143 C 19.85520935058594 5.355282306671143 21.0546875 6.553845882415771 21.0546875 8.032924652099609 C 21.0546875 9.512001991271973 19.85520935058594 10.71056461334229 18.375 10.71056461334229 Z M 1.283697843551636 13.76753902435303 C 0.5085467100143433 14.07734107971191 0.0001862711360445246 14.82743263244629 0 15.66165161132812 L 0 31.62039375305176 C 0 32.34207916259766 0.7292577624320984 32.83552932739258 1.399817705154419 32.56776809692383 L 10.20833301544189 28.56150817871094 L 10.20833301544189 13.70187187194824 C 9.644322395324707 12.6830940246582 9.183032989501953 11.6910924911499 8.852538108825684 10.74244213104248 L 1.283697843551636 13.76753902435303 Z M 18.375 22.93017387390137 C 17.47730445861816 22.93017387390137 16.62809944152832 22.53617477416992 16.04558372497559 21.84891700744629 C 14.79123592376709 20.36983871459961 13.45713520050049 18.68547439575195 12.25 16.9577579498291 L 12.25 28.56087112426758 L 24.5 32.64108657836914 L 24.5 16.95839500427246 C 23.29286193847656 18.68547439575195 21.95940208435059 20.37047576904297 20.70441436767578 21.84955024719238 C 20.12190055847168 22.53617477416992 19.27269554138184 22.93017387390137 18.375 22.93017387390137 Z M 35.35018157958984 10.27449226379395 L 26.54166603088379 14.28075408935547 L 26.54166603088379 32.6417236328125 L 35.46630096435547 29.0747241973877 C 36.24156951904297 28.76506423950195 36.74999237060547 28.01488304138184 36.75 27.18061065673828 L 36.75 11.22186660766602 C 36.75 10.50017929077148 36.0207405090332 10.00672817230225 35.35018157958984 10.27449226379395 Z" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_5hmvha =
    '<svg viewBox="254.0 759.0 37.4 36.0" ><path transform="translate(253.99, 759.0)" d="M 34.77799987792969 13.48700046539307 L 32.31900024414062 11.06400012969971 L 22.3439998626709 21.07400131225586 C 22.22666549682617 21.40200233459473 22.06266593933105 21.67133522033691 21.85199928283691 21.88200187683105 C 21.38399887084961 22.35000228881836 20.81033325195312 22.53733444213867 20.1309986114502 22.44400215148926 C 19.52233123779297 22.46733474731445 19.00733184814453 22.26833534240723 18.58599853515625 21.84700202941895 C 18.37533187866211 21.65966796875 18.22299766540527 21.41366767883301 18.12899780273438 21.10900115966797 L 16.82899856567383 19.80900192260742 C 16.7823314666748 19.87900161743164 16.14433288574219 20.58733558654785 14.91499900817871 21.93400192260742 C 13.68566608428955 23.28066825866699 13.01233196258545 24.0123348236084 12.89499855041504 24.12900161743164 C 12.42699909210205 24.59700202941895 11.84166526794434 24.78433418273926 11.13899803161621 24.69100189208984 C 10.5303316116333 24.71433448791504 10.01533126831055 24.51533508300781 9.593997955322266 24.09400177001953 C 9.383331298828125 23.90666770935059 9.230998039245605 23.66066741943359 9.136998176574707 23.35600090026855 L 8.96099853515625 23.18000030517578 L 4.675998687744141 27.46500015258789 C 4.652665615081787 27.48833274841309 4.623332023620605 27.51166725158691 4.587998867034912 27.53499984741211 C 4.552665710449219 27.5583324432373 4.523332118988037 27.58166694641113 4.499999046325684 27.60499954223633 L 4.499999046325684 31.46799850463867 L 33.72100067138672 31.46799850463867 C 34.32966613769531 31.46799850463867 34.8563346862793 31.69033241271973 35.30100250244141 32.1349983215332 C 35.74567031860352 32.57966613769531 35.9680061340332 33.11233139038086 35.96800231933594 33.73299789428711 C 35.96799850463867 34.35366439819336 35.74566650390625 34.88033294677734 35.30100250244141 35.3129997253418 C 34.85633850097656 35.74566650390625 34.32966995239258 35.96233367919922 33.72100067138672 35.9630012512207 L 2.25200080871582 35.9630012512207 C 1.620000839233398 35.9630012512207 1.087334156036377 35.74633407592773 0.6540007591247559 35.3129997253418 C 0.2206673622131348 34.87966537475586 0.005000442266464233 34.34766387939453 0.007000000216066837 33.71699905395508 L 0.007000000216066837 2.247999906539917 C 0.007000000216066837 1.639333248138428 0.2236666679382324 1.112666606903076 0.6570000052452087 0.6679998636245728 C 1.090333342552185 0.2233331501483917 1.616999983787537 0.0009998282184824347 2.236999988555908 0.0009998679161071777 C 2.85699987411499 0.0009999076137319207 3.389666557312012 0.2233332395553589 3.835000038146973 0.6679998636245728 C 4.280333518981934 1.112666487693787 4.50266695022583 1.639333128929138 4.501999855041504 2.247999906539917 L 4.501999855041504 21.74099922180176 L 6.889999866485596 19.35299873352051 C 6.983333110809326 19.07233238220215 7.135666370391846 18.82633209228516 7.346999645233154 18.61499786376953 C 7.768332958221436 18.19366455078125 8.283332824707031 17.99466514587402 8.891999244689941 18.01799774169922 C 9.571332931518555 17.947998046875 10.14499950408936 18.13533210754395 10.61299896240234 18.57999801635742 C 10.82366561889648 18.79066467285156 10.9876651763916 19.07166481018066 11.10499858856201 19.42299842834473 L 11.20999813079834 19.52799797058105 L 14.75699806213379 15.98099803924561 C 14.85033130645752 15.70033073425293 15.00266456604004 15.45433139801025 15.21399784088135 15.24299812316895 C 15.63533115386963 14.82166481018066 16.15033149719238 14.62266445159912 16.75899696350098 14.64599800109863 C 17.4616641998291 14.57599830627441 18.03533172607422 14.76333141326904 18.4799976348877 15.20799827575684 C 18.69066429138184 15.41866493225098 18.85466384887695 15.69966506958008 18.97199821472168 16.05099868774414 L 20.20099830627441 17.27999877929688 L 29.36799812316895 8.112998962402344 L 26.9799976348877 5.724998950958252 C 26.9566650390625 4.882332324981689 27.21433067321777 4.472665786743164 27.75299835205078 4.495998859405518 L 34.84799957275391 4.495998859405518 C 35.17599868774414 4.519331932067871 35.43933486938477 4.630665302276611 35.63800048828125 4.829998970031738 C 35.83666610717773 5.029332637786865 35.94800186157227 5.292665958404541 35.97200012207031 5.619998931884766 L 35.97200012207031 12.71499824523926 C 35.99533462524414 13.27699851989746 35.59733200073242 13.53466510772705 34.77799987792969 13.48799800872803 Z" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(272.34, 770.45)" d="M 15.71289348602295 11.57122230529785 L 15.71289348602295 9.663131713867188 C 16.38839912414551 9.815673828125 17.04853820800781 10.10555648803711 17.58916854858398 10.56161117553711 L 17.59144592285156 10.55899047851562 C 17.63185119628906 10.58887004852295 17.6807918548584 10.60878944396973 17.7365608215332 10.60878944396973 C 17.80997276306152 10.60878944396973 17.87257385253906 10.57628917694092 17.9163932800293 10.52806282043457 L 17.91923713684082 10.52858734130859 L 18.79221725463867 9.394741058349609 L 18.78993797302246 9.393692970275879 C 18.82579231262207 9.355425834655762 18.84969329833984 9.307199478149414 18.84969329833984 9.252682685852051 C 18.84969329833984 9.188730239868164 18.81839370727539 9.13211727142334 18.77058982849121 9.092276573181152 C 17.96078109741211 8.403477668762207 16.92675399780273 7.989883422851562 15.71289348602295 7.865123271942139 L 15.71289348602295 6.769544124603271 L 15.71289348602295 6.769544124603271 C 15.71289348602295 6.649501800537109 15.60704326629639 6.552000999450684 15.47672462463379 6.552000999450684 L 14.53886985778809 6.552000999450684 C 14.40854835510254 6.552000999450684 14.30269813537598 6.649501800537109 14.30269813537598 6.769544124603271 L 14.30269813537598 7.837340831756592 C 12.27675342559814 8.030770301818848 11.07598304748535 9.219657897949219 11.07598304748535 10.61612796783447 C 11.07598304748535 12.49643611907959 12.75706195831299 13.03531455993652 14.30269813537598 13.38128662109375 L 14.30269813537598 15.52369403839111 C 13.31021404266357 15.36014366149902 12.49414443969727 14.88626670837402 11.93928527832031 14.35577487945557 C 11.935302734375 14.35158157348633 11.93131828308105 14.34843635559082 11.92676639556885 14.34476661682129 L 11.91595268249512 14.33533191680908 L 11.91424560546875 14.33742809295654 C 11.87311935424805 14.3050012588501 11.82098293304443 14.28682899475098 11.76685428619385 14.28605651855469 C 11.68101119995117 14.28678894042969 11.60253810882568 14.33088302612305 11.56255149841309 14.40085506439209 L 11.55970478057861 14.4003324508667 L 10.71461391448975 15.55619430541992 L 10.71575164794922 15.55829238891602 C 10.67783832550049 15.59701347351074 10.65658855438232 15.64716053009033 10.65599822998047 15.69930171966553 C 10.65599822998047 15.7684965133667 10.69355773925781 15.8272066116333 10.74762058258057 15.86704635620117 L 10.74534511566162 15.87019157409668 C 11.57051849365234 16.63028144836426 12.72633075714111 17.18331527709961 14.30213069915771 17.30807304382324 L 14.30213069915771 18.33445930480957 C 14.30213069915771 18.45450210571289 14.40798091888428 18.552001953125 14.53830051422119 18.552001953125 L 15.47615528106689 18.552001953125 C 15.60647487640381 18.552001953125 15.71232509613037 18.45450210571289 15.71232509613037 18.33445930480957 L 15.71232509613037 18.33445930480957 L 15.71232509613037 17.30859756469727 C 17.91867065429688 17.10101509094238 19.01416015625 15.91265201568604 19.01416015625 14.37779235839844 C 19.01416015625 12.48385429382324 17.2733268737793 11.93082332611084 15.71232509613037 11.57122230529785 Z M 14.30213069915771 11.25303173065186 C 13.68694972991943 11.07375526428223 13.26639461517334 10.86617183685303 13.26639461517334 10.46515846252441 C 13.26639461517334 9.995474815368652 13.64199256896973 9.663656234741211 14.30213069915771 9.580307960510254 L 14.30213069915771 11.25303173065186 Z M 15.71289348602295 15.55252647399902 L 15.71289348602295 13.70052433013916 C 16.37360191345215 13.89395427703857 16.83854484558105 14.11569118499756 16.83854484558105 14.57122135162354 C 16.83854484558105 15.01364707946777 16.47831535339355 15.41413497924805 15.71289348602295 15.55252456665039 Z" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qqkewr =
    '<svg viewBox="3.4 2.2 24.7 27.3" ><path  d="M 15.05316066741943 2.534662961959839 C 15.23140621185303 2.351453542709351 15.47343158721924 2.248488664627075 15.72582912445068 2.248488426208496 C 15.97822761535645 2.248488426208496 16.22025299072266 2.351453542709351 16.39849853515625 2.534662961959839 L 27.79965209960938 14.22368144989014 C 27.97747039794922 14.40667724609375 28.07710838317871 14.65459156036377 28.07666015625 14.9128999710083 L 28.07665634155273 28.55008697509766 C 28.07666015625 29.08805656433105 27.65128707885742 29.52417182922363 27.12656211853027 29.52417182922363 L 18.57654190063477 29.52417182922363 C 18.05181694030762 29.52417182922363 17.62644577026367 29.08805656433105 17.62644577026367 28.55008697509766 L 17.62644577026367 20.75740814208984 L 13.82605934143066 20.75740814208984 L 13.82605934143066 28.55008697509766 C 13.82605934143066 29.08805656433105 13.40068626403809 29.52417182922363 12.87596225738525 29.52417182922363 L 4.325096130371094 29.52417182922363 C 3.800372362136841 29.52417182922363 3.374999523162842 29.08805656433105 3.374999523162842 28.55008697509766 L 3.374999523162842 14.9128999710083 C 3.374549388885498 14.65459156036377 3.474189519882202 14.40667724609375 3.652005910873413 14.22368144989014 L 15.05316066741943 2.534663200378418 Z M 5.275192260742188 15.31638717651367 L 5.275192260742188 27.57600212097168 L 11.92586612701416 27.57600212097168 L 11.92586612701416 19.78332328796387 C 11.92586612701416 19.24535179138184 12.35123920440674 18.80923843383789 12.87596225738525 18.80923843383789 L 18.57654190063477 18.80923843383789 C 19.10126495361328 18.80923843383789 19.52663803100586 19.24535179138184 19.52663803100586 19.78332328796387 L 19.52663803100586 27.57600212097168 L 26.17731094360352 27.57600212097168 L 26.17731094360352 15.31638717651367 L 15.72625160217285 4.601454257965088 L 5.275192260742188 15.31638717651367 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xyc8dl =
    '<svg viewBox="20.2 4.5 4.5 9.0" ><path transform="translate(-4.55, 0.0)" d="M 29.25 5.625 L 29.25 13.5 L 24.75 9 L 24.75 5.625 C 24.75 5.003679752349854 25.2536792755127 4.5 25.875 4.5 L 28.125 4.5 C 28.7463207244873 4.5 29.25 5.003679752349854 29.25 5.625 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_f0z6w2 =
    '<svg viewBox="2.0 2.0 33.0 33.0" ><path transform="translate(-1.76, -1.74)" d="M 20.33999824523926 10.99999904632568 C 15.1919994354248 10.99999904632568 11.09999942779541 15.09200096130371 11.09999942779541 20.23999786376953 C 11.09999942779541 25.38799858093262 15.1919994354248 29.48000144958496 20.33999824523926 29.48000144958496 C 25.48799896240234 29.48000144958496 29.58000183105469 25.38799858093262 29.58000183105469 20.23999786376953 C 29.58000183105469 15.09200096130371 25.48799896240234 10.99999904632568 20.33999824523926 10.99999904632568 Z M 20.33999824523926 26.84000015258789 C 16.64399909973145 26.84000015258789 13.74000072479248 23.93599891662598 13.74000072479248 20.23999786376953 C 13.74000072479248 16.54400062561035 16.64399909973145 13.63999938964844 20.33999824523926 13.63999938964844 C 24.03600120544434 13.63999938964844 26.93999862670898 16.54399871826172 26.93999862670898 20.23999786376953 C 26.93999862670898 23.93599891662598 24.0359992980957 26.84000015258789 20.33999824523926 26.84000015258789 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, 0.0)" d="M 33.76250457763672 15.09687900543213 L 30.875 14.1687536239624 L 30.25625419616699 12.6218786239624 L 31.70000839233398 9.940628051757812 C 32.00937652587891 9.321876525878906 31.90625 8.496878623962402 31.390625 7.981252670288086 L 28.91563034057617 5.506250858306885 C 28.4000072479248 4.990625858306885 27.57500648498535 4.887501239776611 26.95625877380371 5.196876049041748 L 24.2750072479248 6.640625476837158 L 22.7281322479248 6.021875858306885 L 21.80000686645508 3.134376049041748 C 21.59375190734863 2.515625 20.97500419616699 1.999999761581421 20.25313186645508 1.999999761581421 L 16.74688148498535 1.999999761581421 C 16.02500343322754 1.999999761581421 15.40625381469727 2.515625 15.30312824249268 3.237500429153442 L 14.37500286102295 6.125000476837158 C 13.75625038146973 6.22812557220459 13.24062538146973 6.434375762939453 12.72500038146973 6.743749618530273 L 10.04375076293945 5.300000667572021 C 9.42500114440918 4.990624904632568 8.600001335144043 5.09375 8.084377288818359 5.609375 L 5.609375 8.084377288818359 C 5.09375 8.600000381469727 4.990624904632568 9.42500114440918 5.300000667572021 10.04375267028809 L 6.640625476837158 12.6218786239624 C 6.434375762939453 13.1375036239624 6.228125095367432 13.75625228881836 6.021876335144043 14.27187728881836 L 3.134375333786011 15.20000171661377 C 2.515625 15.40625381469727 1.999999761581421 16.02500152587891 1.999999761581421 16.74687767028809 L 1.999999761581421 20.25312995910645 C 1.999999761581421 20.97500228881836 2.515625 21.5937557220459 3.237500429153442 21.80000686645508 L 6.125000476837158 22.72813034057617 L 6.743750095367432 24.27500534057617 L 5.300000667572021 26.95625686645508 C 4.99062442779541 27.57500648498535 5.09375 28.40000534057617 5.609375 28.91563034057617 L 8.084377288818359 31.39062881469727 C 8.600000381469727 31.90625381469727 9.42500114440918 32.00938034057617 10.04375076293945 31.70000457763672 L 12.72500038146973 30.25625419616699 L 14.27187538146973 30.87500381469727 L 15.19999980926514 33.86562728881836 C 15.40625190734863 34.48437881469727 16.02499961853027 35 16.74687767028809 35 L 20.25312995910645 35 C 20.97500419616699 35 21.59375190734863 34.48437881469727 21.80000495910645 33.86562728881836 L 22.72813034057617 30.87500381469727 L 24.27500534057617 30.25625419616699 L 26.95625686645508 31.70000457763672 C 27.57500457763672 32.00938034057617 28.40000534057617 31.90625381469727 28.91563034057617 31.39062881469727 L 31.390625 28.91563034057617 C 31.90625 28.40000534057617 32.00937652587891 27.57500648498535 31.70000839233398 26.95625686645508 L 30.25625419616699 24.27500534057617 L 30.875 22.72813034057617 L 33.86563110351562 21.80000686645508 C 34.484375 21.5937557220459 35 20.97500228881836 35 20.25312995910645 L 35 16.74687767028809 C 35 16.02500152587891 34.484375 15.30312633514404 33.76250076293945 15.0968770980835 Z M 32.9375 19.94375228881836 L 29.22500610351562 21.0781307220459 L 29.12187957763672 21.5937557220459 L 28.19375610351562 23.7593822479248 L 27.8843822479248 24.2750072479248 L 29.74062919616699 27.67813301086426 L 27.67813110351562 29.74063301086426 L 24.2750072479248 27.8843822479248 L 23.7593822479248 28.19375801086426 C 23.03750419616699 28.60625648498535 22.31563186645508 28.9156322479248 21.59375190734863 29.12188148498535 L 21.0781307220459 29.22500801086426 L 19.94375228881836 32.93750762939453 L 17.05625343322754 32.93750762939453 L 15.92187881469727 29.22500801086426 L 15.40625381469727 29.12188148498535 L 13.24062538146973 28.19375801086426 L 12.72500038146973 27.8843822479248 L 9.32187557220459 29.74063301086426 L 7.259374618530273 27.67813301086426 L 9.115626335144043 24.2750072479248 L 8.80625057220459 23.7593822479248 C 8.39375114440918 23.03750419616699 8.084376335144043 22.31563377380371 7.878124713897705 21.5937557220459 L 7.77500057220459 21.0781307220459 L 4.062500476837158 19.94375228881836 L 4.062500476837158 17.05625343322754 L 7.568751335144043 16.02500152587891 L 7.77500057220459 15.50937652587891 C 7.981249809265137 14.6843786239624 8.290626525878906 13.96250343322754 8.703125953674316 13.24062919616699 L 9.01250171661377 12.72500419616699 L 7.259376525878906 9.321876525878906 L 9.321876525878906 7.259376049041748 L 12.62187767028809 9.115626335144043 L 13.13750267028809 8.806251525878906 C 13.85937786102295 8.393752098083496 14.58125305175781 8.084377288818359 15.40625381469727 7.878126621246338 L 15.92187881469727 7.671877384185791 L 17.05625343322754 4.062500476837158 L 19.94375228881836 4.062500476837158 L 21.0781307220459 7.671876430511475 L 21.59375190734863 7.878126621246338 C 22.31563186645508 8.084377288818359 23.03750419616699 8.39375114440918 23.7593822479248 8.80625057220459 L 24.2750072479248 9.115626335144043 L 27.67813110351562 7.259374618530273 L 29.74062919616699 9.32187557220459 L 27.8843822479248 12.72500133514404 L 28.19375610351562 13.24062633514404 C 28.60625457763672 13.96250247955322 28.91563034057617 14.68437767028809 29.12187957763672 15.40625381469727 L 29.22500610351562 15.92187881469727 L 32.9375 17.05625343322754 L 32.9375 19.94375228881836 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
