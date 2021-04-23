import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_app/Location.dart';
import 'package:flutter_app/ProjectCosts.dart';
import 'package:flutter_app/ViewMap.dart';
import 'package:flutter_app/revenue.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:intl/intl.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Project.dart';

class basic_costs extends StatefulWidget {
  double capital, rentalP;
  ProjectLocation loc;
  Project project, proj;

  basic_costs(double capital, rentalPrice, project, loc, proj) {
    this.capital = capital;
    rentalP = rentalPrice;
    this.project = project;
    this.loc = loc;
    this.proj = proj;
  }
  @override
  _basic_costsState createState() =>
      _basic_costsState(capital, rentalP, project, loc, proj);
}

class _basic_costsState extends State<basic_costs> {
  bool loading = true;
  double capital, fixedCost, variableCost, FCost, eqCost, rCost;
  bool fixedError = false, varError = false, fError = false, eqError = false;
  Project project, proj;
  ProjectLocation loc;

  _basic_costsState(double capital, rentalP, project, loc, proj) {
    this.capital = capital;
    rCost = rentalP;
    this.project = project;
    this.loc = loc;
    this.proj = proj;
  }

  getData() async {
    var userRef = Firestore.instance.collection('costs');
    try {
      await userRef
          .document(project.projectCostsID)
          .get()
          .then((DocumentSnapshot doc) => {
                setState(() {
                  fixedCost = doc.data['fixedCost'];
                  variableCost = doc.data['variableCost'];
                  FCost = doc.data['FCost'];
                  eqCost = doc.data['eqCost'];
                  rCost = doc.data['rCost'];
                })
              });
    } catch (Exception) {}
  }

//***************************************** Call Model API *****************************************
  void modelResult() async {
    double shopSpace = widget.project.maxSpace +
        widget.project.minSpace /
            2; // Take the average of the range of the shop space
    print(
        "values are capital=$capital, shopcpace=$shopSpace, city=${widget.loc.city} district=${widget.loc.district}"); // just to check
// request to  http and  encode the user inputs and send them as json
    var response =
        await http.post("https://ancient-escarpment-34424.herokuapp.com/",
            body: jsonEncode({
              "Capital": capital,
              "Shop_space": shopSpace,
              "City": widget.loc.city,
              "District": widget.loc.district,
            }));
// once the models predict the results, they return the results as list
    print(response.body);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        fixedCost = result[0];
        variableCost = result[1];
        FCost = result[2];
        eqCost = result[3];
        loading = false;
      });
    }
  }

  alertFixedCostDialog(BuildContext context) async {
    // This is the ok button
    final selectedValue = await showDialog<double>(
      context: context,
      builder: (context) =>
          FixedCostDialog(fixedValue: fixedCost, capValue: capital),
    );
    if (selectedValue != null)
      setState(() {
        if (selectedValue + variableCost + FCost + eqCost + rCost > capital)
          fixedError = true;
        else if (selectedValue + variableCost + FCost + eqCost + rCost <
            capital) {
          fixedError = false;
          varError = false;
          fError = false;
          eqError = false;
          var unChangedValue = variableCost + FCost + eqCost;

          var tempVariable = variableCost / unChangedValue;
          tempVariable = tempVariable * (fixedCost - selectedValue);
          variableCost = variableCost + tempVariable;

          var tempFurniture = FCost / unChangedValue;
          tempFurniture = tempFurniture * (fixedCost - selectedValue);
          FCost = FCost + tempFurniture;

          var tempeq = eqCost / unChangedValue;
          tempeq = tempeq * (fixedCost - selectedValue);
          eqCost = eqCost + tempeq;
        } else {
          fixedError = false;
          varError = false;
          fError = false;
          eqError = false;
        }
        fixedCost = selectedValue;
      });
  }

  alertVariableCostDialog(BuildContext context) async {
    // This is the ok button
    final selectedValue = await showDialog<double>(
      context: context,
      builder: (context) =>
          VariableCostDialog(fixedValue: variableCost, capValue: capital),
    );
    if (selectedValue != null)
      setState(() {
        if (selectedValue + fixedCost + FCost + eqCost + rCost > capital)
          varError = true;
        else if (selectedValue + fixedCost + FCost + eqCost + rCost < capital) {
          fixedError = false;
          varError = false;
          fError = false;
          eqError = false;
          var unChangedValue = fixedCost + FCost + eqCost;

          var tempFixed = fixedCost / unChangedValue;
          tempFixed = tempFixed * (variableCost - selectedValue);
          fixedCost = fixedCost + tempFixed;

          var tempFurniture = FCost / unChangedValue;
          tempFurniture = tempFurniture * (variableCost - selectedValue);
          FCost = FCost + tempFurniture;

          var tempeq = eqCost / unChangedValue;
          tempeq = tempeq * (variableCost - selectedValue);
          eqCost = eqCost + tempeq;
        } else {
          fixedError = false;
          varError = false;
          fError = false;
          eqError = false;
        }
        variableCost = selectedValue;
      });
  }

  alertFCostDialog(BuildContext context) async {
    // This is the ok button
    final selectedValue = await showDialog<double>(
      context: context,
      builder: (context) => FCostDialog(fValue: FCost, capValue: capital),
    );
    if (selectedValue != null)
      setState(() {
        if (selectedValue + variableCost + fixedCost + eqCost + rCost > capital)
          fError = true;
        else if (selectedValue + variableCost + fixedCost + eqCost + rCost <
            capital) {
          fixedError = false;
          varError = false;
          fError = false;
          eqError = false;
          var unChangedValue = fixedCost + variableCost + eqCost;

          var tempFixed = fixedCost / unChangedValue;
          tempFixed = tempFixed * (FCost - selectedValue);
          fixedCost = fixedCost + tempFixed;

          var tempVariable = variableCost / unChangedValue;
          tempVariable = tempVariable * (FCost - selectedValue);
          variableCost = variableCost + tempVariable;

          var tempeq = eqCost / unChangedValue;
          tempeq = tempeq * (FCost - selectedValue);
          eqCost = eqCost + tempeq;
        } else {
          fixedError = false;
          varError = false;
          fError = false;
          eqError = false;
        }
        FCost = selectedValue;
      });
  }

  alertEqCostDialog(BuildContext context) async {
    // This is the ok button
    final selectedValue = await showDialog<double>(
      context: context,
      builder: (context) => EqCostDialog(eqValue: eqCost, capValue: capital),
    );
    if (selectedValue != null)
      setState(() {
        if (selectedValue + variableCost + FCost + fixedCost + rCost > capital)
          eqError = true;
        else if (selectedValue + variableCost + FCost + fixedCost + rCost <
            capital) {
          fixedError = false;
          varError = false;
          fError = false;
          eqError = false;
          var unChangedValue = fixedCost + variableCost + FCost;

          var tempFixed = fixedCost / unChangedValue;
          tempFixed = tempFixed * (eqCost - selectedValue);
          fixedCost = fixedCost + tempFixed;

          var tempVariable = variableCost / unChangedValue;
          tempVariable = tempVariable * (eqCost - selectedValue);
          variableCost = variableCost + tempVariable;

          var tempFurniture = FCost / unChangedValue;
          tempFurniture = tempFurniture * (eqCost - selectedValue);
          FCost = FCost + tempFurniture;
        } else {
          fixedError = false;
          varError = false;
          fError = false;
          eqError = false;
        }
        eqCost = selectedValue;
      });
  }

  String getCategory(double capital) {
    if (capital < 300000)
      return 'الاقتصادية';
    else if (capital < 500000)
      return 'القياسية';
    else
      return 'الممتازة';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    modelResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff8f8),
      body: !loading
          ? Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xffb7e0ee),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, MediaQuery.of(context).size.height / 20),
                  child:
                      // Adobe XD layer: 'logo3-07' (group)
                      SizedBox(
                    width: MediaQuery.of(context).size.width,
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
                                image: const AssetImage(
                                    'assets/images/bgo_building.png'),
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
                  offset: Offset(MediaQuery.of(context).size.width / 10,
                      MediaQuery.of(context).size.height / 7),
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
                  offset: Offset(MediaQuery.of(context).size.width / 2.5,
                      MediaQuery.of(context).size.height / 6.5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
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
                  offset: Offset(MediaQuery.of(context).size.width / 2.5,
                      MediaQuery.of(context).size.height / 5.3),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      (fixedError || varError || fixedError || eqError)
                          ? 'تجاوزت رأس المال'
                          : '',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 2.5,
                      MediaQuery.of(context).size.height / 4.05),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      (fixedError || varError || fixedError || eqError)
                          ? (capital -
                                  (fixedCost +
                                      variableCost +
                                      FCost +
                                      eqCost +
                                      rCost))
                              .round()
                              .toString()
                          : '',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 2.5,
                      MediaQuery.of(context).size.height / 4.6),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      capital.toString().replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},') +
                          ' SAR',
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
                  offset: Offset(MediaQuery.of(context).size.width / 18,
                      MediaQuery.of(context).size.height / 3.3),
                  child: InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.12,
                      height: MediaQuery.of(context).size.height / 12,
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
                    onTap: () {},
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 18,
                      MediaQuery.of(context).size.height / 2.4),
                  child: InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.12,
                      height: MediaQuery.of(context).size.height / 12,
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
                    onTap: () {},
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 18,
                      MediaQuery.of(context).size.height / 1.89),
                  child: InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.12,
                      height: MediaQuery.of(context).size.height / 12,
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
                    onTap: () {},
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 18,
                      MediaQuery.of(context).size.height / 1.56),
                  child: InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.12,
                      height: MediaQuery.of(context).size.height / 12,
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
                    onTap: () {},
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 18,
                      MediaQuery.of(context).size.height / 1.325),
                  child: InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.12,
                      height: MediaQuery.of(context).size.height / 12,
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
                    onTap: () {},
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 9,
                      MediaQuery.of(context).size.height / 4.7),
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
                  offset: Offset(MediaQuery.of(context).size.width / 1.9,
                      MediaQuery.of(context).size.height / 3.24),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 14,
                      child: OutlineButton(
                        borderSide: const BorderSide(
                            color: Colors.transparent,
                            style: BorderStyle.solid),
                        onPressed: () {
                          alertFixedCostDialog(context);
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
                      )),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 1.9,
                      MediaQuery.of(context).size.height / 2.36),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 14,
                      child: OutlineButton(
                        borderSide: const BorderSide(
                            color: Colors.transparent,
                            style: BorderStyle.solid),
                        onPressed: () {
                          alertVariableCostDialog(context);
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
                      )),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 1.9,
                      MediaQuery.of(context).size.height / 1.87),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 14,
                      child: OutlineButton(
                        borderSide: const BorderSide(
                            color: Colors.transparent,
                            style: BorderStyle.solid),
                        onPressed: () {
                          alertFCostDialog(context);
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
                      )),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 1.9,
                      MediaQuery.of(context).size.height / 1.545),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 14,
                      child: OutlineButton(
                        borderSide: const BorderSide(
                            color: Colors.transparent,
                            style: BorderStyle.solid),
                        onPressed: () {
                          alertEqCostDialog(context);
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
                      )),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 1.9,
                      MediaQuery.of(context).size.height / 1.315),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 14,
                      child: OutlineButton(
                        borderSide: const BorderSide(
                            color: Colors.transparent,
                            style: BorderStyle.solid),
                        onPressed: () {},
                        child: Text(
                          'سعر الإيجار',
                          style: TextStyle(
                            fontFamily: 'STC',
                            fontSize: 17,
                            color: const Color(0xff01756a),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 1.8,
                      MediaQuery.of(context).size.height / 1.15),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 24,
                      child: Container(
                        child: OutlineButton(
                          color: const Color(0xffb7e0ee),
                          onPressed: () async {
                            var costs = ProjectCosts(
                                fixedCost, variableCost, FCost, eqCost, rCost);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        revenue(loc, project, costs, proj)));
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            'التالى',
                            style: TextStyle(shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(50, 0, 0, 50),
                              ),
                            ], color: Colors.blue, fontSize: 18),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(52.0),
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [
                              const Color(0xfffcffff),
                              const Color(0xfff3f8f7),
                              const Color(0xfff7fbfa),
                              const Color(0xffffffff)
                            ],
                            stops: [0.0, 0.325, 0.906, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      )),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 4.7,
                      MediaQuery.of(context).size.height / 1.15),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 24,
                      child: Container(
                        child: OutlineButton(
                          color: const Color(0xffb7e0ee),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewMap(capital,
                                        project, loc.city, loc.country, proj)));
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            'الغاء',
                            style: TextStyle(shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(50, 0, 0, 50),
                              ),
                            ], color: Colors.blue, fontSize: 18),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(52.0),
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [
                              const Color(0xfffcffff),
                              const Color(0xfff3f8f7),
                              const Color(0xfff7fbfa),
                              const Color(0xffffffff)
                            ],
                            stops: [0.0, 0.325, 0.906, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      )),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 13,
                      MediaQuery.of(context).size.height / 1.31),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: Text(
                      rCost.round().toString().replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},') +
                          ' SAR',
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
                  offset: Offset(MediaQuery.of(context).size.width / 13,
                      MediaQuery.of(context).size.height / 1.53),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: Text(
                      eqCost.round().toString().replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},') +
                          ' SAR',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 17,
                        color: eqError ? Colors.red : const Color(0xff1b5070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 13,
                      MediaQuery.of(context).size.height / 1.83),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: Text(
                      FCost.round().toString().replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},') +
                          ' SAR',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 17,
                        color: fError ? Colors.red : const Color(0xff1b5070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 13,
                      MediaQuery.of(context).size.height / 2.3),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: Text(
                      variableCost.round().toString().replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},') +
                          ' SAR',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 17,
                        color: varError ? Colors.red : const Color(0xff1b5070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 13,
                      MediaQuery.of(context).size.height / 3.1),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: Text(
                      fixedCost.round().toString().replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},') +
                          ' SAR',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 17,
                        color:
                            fixedError ? Colors.red : const Color(0xff1b5070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 2.3,
                      MediaQuery.of(context).size.height / 1.496),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 8.9,
                    child: Text(
                      NumberFormat("##.##")
                              .format(eqCost * 100 / capital)
                              .toString() +
                          '%',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 12,
                        color: eqError ? Colors.red : const Color(0xff1b5070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 2.3,
                      MediaQuery.of(context).size.height / 1.792),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 8.9,
                    child: Text(
                      NumberFormat("##.##")
                              .format(FCost * 100 / capital)
                              .toString() +
                          '%',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 12,
                        color: fError ? Colors.red : const Color(0xff1b5070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 2.3,
                      MediaQuery.of(context).size.height / 2.235),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 8.9,
                    child: Text(
                      NumberFormat("##.##")
                              .format(variableCost * 100 / capital)
                              .toString() +
                          '%',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 12,
                        color: varError ? Colors.red : const Color(0xff1b5070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 2.3,
                      MediaQuery.of(context).size.height / 3),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 8.9,
                    child: Text(
                      NumberFormat("##.##")
                              .format(fixedCost * 100 / capital)
                              .toString() +
                          '%',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 12,
                        color:
                            fixedError ? Colors.red : const Color(0xff1b5070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width / 2.3,
                      MediaQuery.of(context).size.height / 1.279),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 8.9,
                    child: Text(
                      NumberFormat("##.##")
                              .format(rCost * 100 / capital)
                              .toString() +
                          '%',
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
                  offset: Offset(MediaQuery.of(context).size.width / 9,
                      MediaQuery.of(context).size.height / 5.5),
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
                    offset:
                        Offset(10, MediaQuery.of(context).size.height / 1.325),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        disabledActiveTrackColor: const Color(0xffa6dcea),
                        disabledInactiveTrackColor: const Color(0xffbdceca),
                        trackShape: RectangularSliderTrackShape(),
                        trackHeight: 10.0,
                        disabledThumbColor: const Color(0xffa6dcea),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayColor: Colors.red.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 28.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Slider(
                          min: 0,
                          max: capital,
                          divisions: capital.round(),
                          value: rCost,
                          onChanged: null,
                        ),
                      ),
                    )),
                Transform.translate(
                    offset:
                        Offset(10, MediaQuery.of(context).size.height / 1.56),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        disabledActiveTrackColor: const Color(0xffa6dcea),
                        disabledInactiveTrackColor: const Color(0xffbdceca),
                        trackShape: RectangularSliderTrackShape(),
                        trackHeight: 10.0,
                        disabledThumbColor:
                            eqError ? Colors.red : const Color(0xffa6dcea),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayColor: Colors.red.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 28.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Slider(
                          min: 0,
                          max: capital,
                          divisions: capital.round(),
                          value: eqCost,
                          onChanged: null,
                        ),
                      ),
                    )),
                Transform.translate(
                    offset:
                        Offset(10, MediaQuery.of(context).size.height / 1.88),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        disabledActiveTrackColor: const Color(0xffa6dcea),
                        disabledInactiveTrackColor: const Color(0xffbdceca),
                        trackShape: RectangularSliderTrackShape(),
                        trackHeight: 10.0,
                        disabledThumbColor:
                            fError ? Colors.red : const Color(0xffa6dcea),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayColor: Colors.red.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 28.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Slider(
                          min: 0,
                          max: capital,
                          divisions: capital.round(),
                          value: FCost,
                          onChanged: null,
                        ),
                      ),
                    )),
                Transform.translate(
                    offset:
                        Offset(10, MediaQuery.of(context).size.height / 2.38),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        disabledActiveTrackColor: const Color(0xffa6dcea),
                        disabledInactiveTrackColor: const Color(0xffbdceca),
                        trackShape: RectangularSliderTrackShape(),
                        trackHeight: 10.0,
                        disabledThumbColor:
                            varError ? Colors.red : const Color(0xffa6dcea),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayColor: Colors.red.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 28.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Slider(
                          min: 0,
                          max: capital,
                          value: variableCost,
                          divisions: capital.round(),
                          onChanged: null,
                        ),
                      ),
                    )),
                Transform.translate(
                    offset:
                        Offset(10, MediaQuery.of(context).size.height / 3.26),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        disabledActiveTrackColor: const Color(0xffa6dcea),
                        disabledInactiveTrackColor: const Color(0xffbdceca),
                        trackShape: RectangularSliderTrackShape(),
                        trackHeight: 10.0,
                        disabledThumbColor:
                            fixedError ? Colors.red : const Color(0xffa6dcea),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayColor: Colors.red.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 28.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Slider(
                          min: 0,
                          max: capital,
                          divisions: capital.round(),
                          value: fixedCost,
                          onChanged: null,
                        ),
                      ),
                    )),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class FixedCostDialog extends StatefulWidget {
  /// initial selection for the slider
  final double fixedValue, capValue;

  const FixedCostDialog({Key key, this.fixedValue, this.capValue})
      : super(key: key);

  @override
  _FixedCostDialogState createState() => _FixedCostDialogState();
}

class _FixedCostDialogState extends State<FixedCostDialog> {
  /// current selection of the slider
  double fixedValue;
  TextEditingController value = TextEditingController();

  @override
  void initState() {
    super.initState();
    fixedValue = widget.fixedValue;
    value.text = fixedValue.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.capValue);
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.5,
        child: Stack(
          children: <Widget>[
            Pinned.fromSize(
              bounds: Rect.fromLTWH(
                  -MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 25,
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 3.5 -
                      MediaQuery.of(context).size.height / 25),
              size: Size(
                  MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 9.5,
                  MediaQuery.of(context).size.height / 3.5 -
                      MediaQuery.of(context).size.height / 40),
              pinLeft: true,
              pinRight: true,
              pinTop: true,
              pinBottom: true,
              child: SvgPicture.string(
                _svg_8fdebu,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),
            Transform.translate(
                offset: Offset(-MediaQuery.of(context).size.width / 15,
                    MediaQuery.of(context).size.height / 50),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xffa6dcea),
                    inactiveTrackColor: const Color(0xffbdceca),
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 10.0,
                    thumbColor: const Color(0xffa6dcea),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 10,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  value.text =
                                      (int.parse(value.text) + 1).toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffa6dcea),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.add),
                                // shape: CircleBorder(),
                              ),
                            ),
                            // Container(
                            //   width: 50,
                            //     child: TextField(
                            //       controller: value,
                            //       keyboardType: TextInputType.number,
                            //
                            //     )),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  value.text =
                                      (int.parse(value.text) - 1).toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xffa6dcea),
                                ),
                                child: Icon(Icons.remove),
                                // shape: CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                      )
                      // Slider(
                      //   min: 0,
                      //   max: 100,
                      //   divisions: 100,
                      //   value: fixedValue,
                      //   onChanged: (value){
                      //     setState(() {
                      //       fixedValue = value;
                      //     });
                      //   },
                      // ),
                      ),
                )),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 3.4,
                  MediaQuery.of(context).size.height / 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 12,
                child: Text(
                  NumberFormat("##.##")
                          .format(fixedValue * 100 / widget.capValue)
                          .toString() +
                      '%',
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
              offset: Offset(-MediaQuery.of(context).size.width / 100,
                  -MediaQuery.of(context).size.height / 120),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: TextField(
                    onChanged: (value) {
                      fixedValue = double.parse(value);
                    },
                    controller: value,
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff1b5070),
                    ),
                    textAlign: TextAlign.center,
                  )
                  // Text(
                  //
                  //   (widget.capValue * fixedValue / 100).round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SR',
                  //   style: TextStyle(
                  //     fontFamily: 'STC',
                  //     fontSize: 17,
                  //     color: const Color(0xff1b5070),
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 2.6,
                  MediaQuery.of(context).size.height / 1000),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  'التكاليف الثابتة',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 20,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 2.6,
                  MediaQuery.of(context).size.height / 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'الرواتب',
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
              offset: Offset(MediaQuery.of(context).size.width / 3.2,
                  MediaQuery.of(context).size.height / 6),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'صيانة الآلآت الدورية',
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
              offset: Offset(MediaQuery.of(context).size.width / 2.8,
                  MediaQuery.of(context).size.height / 4.8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'مصاريف اخرى',
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
                offset: Offset(0, MediaQuery.of(context).size.height / 3.8),
                child: Container(
                    width: 50,
                    height: 30,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (value.text.isNotEmpty) {
                            fixedValue = double.parse(value.text);
                          }
                        });

                        Navigator.pop(context, fixedValue);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                              style: BorderStyle.solid, color: Colors.grey)),
                      child: Text('تم'),
                    ))),
          ],
        ),
      ),
      elevation: 5,
    );
  }
}

class VariableCostDialog extends StatefulWidget {
  /// initial selection for the slider
  final double fixedValue, capValue;

  const VariableCostDialog({Key key, this.fixedValue, this.capValue})
      : super(key: key);

  @override
  _VariableCostDialogState createState() => _VariableCostDialogState();
}

class _VariableCostDialogState extends State<VariableCostDialog> {
  /// current selection of the slider
  double variableValue;
  TextEditingController variableController = TextEditingController();

  @override
  void initState() {
    super.initState();
    variableValue = widget.fixedValue;
    variableController.text = variableValue.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.5,
        child: Stack(
          children: <Widget>[
            Pinned.fromSize(
              bounds: Rect.fromLTWH(
                  -MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 25,
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 3.5 -
                      MediaQuery.of(context).size.height / 25),
              size: Size(
                  MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 9.5,
                  MediaQuery.of(context).size.height / 3.5 -
                      MediaQuery.of(context).size.height / 40),
              pinLeft: true,
              pinRight: true,
              pinTop: true,
              pinBottom: true,
              child: SvgPicture.string(
                _svg_8fdebu,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),
            Transform.translate(
                offset: Offset(-MediaQuery.of(context).size.width / 15,
                    MediaQuery.of(context).size.height / 50),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xffa6dcea),
                    inactiveTrackColor: const Color(0xffbdceca),
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 10.0,
                    thumbColor: const Color(0xffa6dcea),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 10,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  variableController.text =
                                      (int.parse(variableController.text) + 1)
                                          .toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffa6dcea),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.add),
                                // shape: CircleBorder(),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            // Container(
                            //     width: 50,
                            //     child: TextField(
                            //       controller: variableController,
                            //       keyboardType: TextInputType.number,
                            //
                            //     )),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  variableController.text =
                                      (int.parse(variableController.text) - 1)
                                          .toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xffa6dcea),
                                ),
                                child: Icon(Icons.remove),
                                // shape: CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                      )
                      // Slider(
                      //   min: 0,
                      //   max: 100,
                      //   divisions: 100,
                      //   value: variableValue,
                      //   onChanged: (value){
                      //     setState(() {
                      //       variableValue = value;
                      //     });
                      //   },
                      // ),
                      ),
                )),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 3.4,
                  MediaQuery.of(context).size.height / 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 12,
                child: Text(
                  NumberFormat("##.##")
                          .format(variableValue * 100 / widget.capValue)
                          .toString() +
                      '%',
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
              offset: Offset(-MediaQuery.of(context).size.width / 100,
                  -MediaQuery.of(context).size.height / 120),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: TextField(
                    onChanged: (value) {
                      variableValue = double.parse(variableController.text);
                    },
                    controller: variableController,
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff1b5070),
                    ),
                    textAlign: TextAlign.center,
                  )
                  // Text(
                  //   (widget.capValue * variableValue / 100).round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SR',
                  //   style: TextStyle(
                  //     fontFamily: 'STC',
                  //     fontSize: 17,
                  //     color: const Color(0xff1b5070),
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 2.6,
                  MediaQuery.of(context).size.height / 1000),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  'التكاليف المتغيرة',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 20,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'مواد الخام',
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
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 6),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'فواتير الكهرباء',
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
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 4.8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'مصاريف اخرى',
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
                offset: Offset(0, MediaQuery.of(context).size.height / 3.8),
                child: Container(
                    width: 50,
                    height: 30,
                    child: OutlineButton(
                      onPressed: () {
                        // Use the second argument of Navigator.pop(...) to pass
                        // back a result to the page that opened the dialog

                        setState(() {
                          if (variableController.text.isNotEmpty) {
                            variableValue =
                                double.parse(variableController.text);
                          }
                        });

                        Navigator.pop(context, variableValue);
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text('تم'),
                    ))),
          ],
        ),
      ),
      elevation: 5,
    );
  }
}

class FCostDialog extends StatefulWidget {
  /// initial selection for the slider
  final double fValue, capValue;

  const FCostDialog({Key key, this.fValue, this.capValue}) : super(key: key);

  @override
  _FCostDialogState createState() => _FCostDialogState();
}

class _FCostDialogState extends State<FCostDialog> {
  /// current selection of the slider
  double fValue;

  TextEditingController furnitureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fValue = widget.fValue;
    furnitureController.text = fValue.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.5,
        child: Stack(
          children: <Widget>[
            Pinned.fromSize(
              bounds: Rect.fromLTWH(
                  -MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 25,
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 3.5 -
                      MediaQuery.of(context).size.height / 25),
              size: Size(
                  MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 9.5,
                  MediaQuery.of(context).size.height / 3.5 -
                      MediaQuery.of(context).size.height / 40),
              pinLeft: true,
              pinRight: true,
              pinTop: true,
              pinBottom: true,
              child: SvgPicture.string(
                _svg_8fdebu,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),
            Transform.translate(
                offset: Offset(-MediaQuery.of(context).size.width / 15,
                    MediaQuery.of(context).size.height / 50),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xffa6dcea),
                    inactiveTrackColor: const Color(0xffbdceca),
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 10.0,
                    thumbColor: const Color(0xffa6dcea),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 10,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  furnitureController.text =
                                      (int.parse(furnitureController.text) + 1)
                                          .toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffa6dcea),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.add),
                                // shape: CircleBorder(),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            // Container(
                            //     width: 50,
                            //     child: TextField(
                            //       controller: furnitureController,
                            //       keyboardType: TextInputType.number,
                            //
                            //     )),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  furnitureController.text =
                                      (int.parse(furnitureController.text) - 1)
                                          .toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xffa6dcea),
                                ),
                                child: Icon(Icons.remove),
                                // shape: CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                      )

                      // Slider(
                      //   min: 0,
                      //   max: 100,
                      //   divisions: 100,
                      //   value: fValue,
                      //   onChanged: (value){
                      //     setState(() {
                      //       fValue = value;
                      //     });
                      //   },
                      // ),
                      ),
                )),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 3.4,
                  MediaQuery.of(context).size.height / 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 12,
                child: Text(
                  NumberFormat("##.##")
                          .format(fValue * 100 / widget.capValue)
                          .toString() +
                      '%',
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
              offset: Offset(-MediaQuery.of(context).size.width / 100,
                  -MediaQuery.of(context).size.height / 120),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: TextField(
                    onChanged: (value) {
                      fValue = double.parse(furnitureController.text);
                    },
                    controller: furnitureController,
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff1b5070),
                    ),
                    textAlign: TextAlign.center,
                  )
                  // Text(
                  //   (widget.capValue * fValue / 100).round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SR',
                  //   style: TextStyle(
                  //     fontFamily: 'STC',
                  //     fontSize: 17,
                  //     color: const Color(0xff1b5070),
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 2.6,
                  MediaQuery.of(context).size.height / 1000),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  'تكاليف الأثاث',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 20,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'كراسي',
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
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 6),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'طاولات',
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
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 4.8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'ديكورات',
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
                offset: Offset(0, MediaQuery.of(context).size.height / 3.8),
                child: Container(
                    width: 50,
                    height: 30,
                    child: OutlineButton(
                      onPressed: () {
                        // Use the second argument of Navigator.pop(...) to pass
                        // back a result to the page that opened the dialog

                        setState(() {
                          if (furnitureController.text.isNotEmpty) {
                            fValue = double.parse(furnitureController.text);
                          }
                        });

                        Navigator.pop(context, fValue);
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text('تم'),
                    ))),
          ],
        ),
      ),
      elevation: 5,
    );
  }
}

class EqCostDialog extends StatefulWidget {
  /// initial selection for the slider
  final double eqValue, capValue;

  const EqCostDialog({Key key, this.eqValue, this.capValue}) : super(key: key);

  @override
  _EqCostDialogState createState() => _EqCostDialogState();
}

class _EqCostDialogState extends State<EqCostDialog> {
  /// current selection of the slider
  double eqValue;
  TextEditingController eqController = TextEditingController();

  @override
  void initState() {
    super.initState();
    eqValue = widget.eqValue;
    eqController.text = eqValue.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.5,
        child: Stack(
          children: <Widget>[
            Pinned.fromSize(
              bounds: Rect.fromLTWH(
                  -MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 25,
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 3.5 -
                      MediaQuery.of(context).size.height / 25),
              size: Size(
                  MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 9.5,
                  MediaQuery.of(context).size.height / 3.5 -
                      MediaQuery.of(context).size.height / 40),
              pinLeft: true,
              pinRight: true,
              pinTop: true,
              pinBottom: true,
              child: SvgPicture.string(
                _svg_8fdebu,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),
            Transform.translate(
                offset: Offset(-MediaQuery.of(context).size.width / 15,
                    MediaQuery.of(context).size.height / 50),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xffa6dcea),
                    inactiveTrackColor: const Color(0xffbdceca),
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 10.0,
                    thumbColor: const Color(0xffa6dcea),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 10,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  eqController.text =
                                      (int.parse(eqController.text) + 1)
                                          .toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffa6dcea),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.add),
                                // shape: CircleBorder(),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            // Container(
                            //     width: 50,
                            //     child: TextField(
                            //       controller: eqController,
                            //       keyboardType: TextInputType.number,
                            //
                            //     )),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  eqController.text =
                                      (int.parse(eqController.text) - 1)
                                          .toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xffa6dcea),
                                ),
                                child: Icon(Icons.remove),
                                // shape: CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                      )

                      // Slider(
                      //   min: 0,
                      //   max: 100,
                      //   divisions: 100,
                      //   value: eqValue,
                      //   onChanged: (value){
                      //     setState(() {
                      //       eqValue = value;
                      //     });
                      //   },
                      // ),
                      ),
                )),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 3.4,
                  MediaQuery.of(context).size.height / 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 12,
                child: Text(
                  NumberFormat("##.##")
                          .format(eqValue * 100 / widget.capValue)
                          .toString() +
                      '%',
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
              offset: Offset(-MediaQuery.of(context).size.width / 100,
                  -MediaQuery.of(context).size.height / 120),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: TextField(
                    onChanged: (value) {
                      eqValue = double.parse(eqController.text);
                    },
                    controller: eqController,
                    style: TextStyle(
                      fontFamily: 'STC',
                      fontSize: 17,
                      color: const Color(0xff1b5070),
                    ),
                    textAlign: TextAlign.center,
                  )

                  // Text(
                  //   (widget.capValue * eqValue / 100).round().toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + ' SR',
                  //   style: TextStyle(
                  //     fontFamily: 'STC',
                  //     fontSize: 17,
                  //     color: const Color(0xff1b5070),
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 2.6,
                  MediaQuery.of(context).size.height / 1000),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  'تكاليف المعدات',
                  style: TextStyle(
                    fontFamily: 'STC',
                    fontSize: 20,
                    color: const Color(0xff1b5070),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'أجهزة الحاسب',
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
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 6),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'تكييف',
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
              offset: Offset(MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height / 4.8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'معدات القهوة',
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
                offset: Offset(0, MediaQuery.of(context).size.height / 3.8),
                child: Container(
                    width: 50,
                    height: 30,
                    child: OutlineButton(
                      onPressed: () {
                        // Use the second argument of Navigator.pop(...) to pass
                        // back a result to the page that opened the dialog

                        setState(() {
                          if (eqController.text.isNotEmpty) {
                            eqValue = double.parse(eqController.text);
                          }
                        });

                        Navigator.pop(context, eqValue);
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text('تم'),
                    ))),
          ],
        ),
      ),
      elevation: 5,
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
const String _svg_8fdebu =
    '<svg viewBox="0.0 0.0 406.6 269.5" ><path transform="translate(31.63, 88.47)" d="M 0 15.68878173828125 C 31.32668876647949 -5.523738861083984 172.0140075683594 87.88491058349609 225.9282684326172 -7.964862823486328 C 279.842529296875 -103.8146362304688 375 -87.39944458007812 375 -87.39944458007812 L 375 0 L 375 181 L 0 181 C 0 181 -71.171142578125 63.88153076171875 0 15.68878173828125 Z" fill="#b7e0ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
