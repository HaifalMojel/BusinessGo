import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_app/Project.dart';
import 'package:flutter_app/user_input.dart';
import 'package:flutter_app/user_nav_costs.dart';
import 'package:flutter_app/user_nav_map.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:intl/intl.dart";

import 'home_page.dart';

class user_nav_revenue extends StatefulWidget {
  var project;

  user_nav_revenue(project) {
    this.project = project;
  }

  _user_nav_revenue_state createState() => _user_nav_revenue_state(project);
}

class _user_nav_revenue_state extends State<user_nav_revenue> {
  List<_SalesData> salesData = [];
  Project project;
  var ages;

  _user_nav_revenue_state(project) {
    this.project = project;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var userRef = Firestore.instance.collection('revenue');
    try {
      userRef.document(project.revenueID).get().then((DocumentSnapshot doc) => {
            setState(() {
              salesData = [
                _SalesData(2022, 0.0),
                _SalesData(2023, doc.data['value1']),
                _SalesData(2024, doc.data['value2']),
                _SalesData(2025, doc.data['value3']),
              ];
              print(
                  'sales data is ${salesData.map((e) => e.months).toList().toString()}');
            })
          });
    } catch (Exception) {}
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
              TabItem(
                  icon: Icon(Icons.home, size: 35, color: Colors.teal),
                  title: ''),
              TabItem(
                  icon: Icon(Icons.map, size: 35, color: Colors.teal),
                  title: ''),
              TabItem(
                  icon:
                      Icon(Icons.monetization_on, size: 35, color: Colors.teal),
                  title: ''),
              TabItem(
                  icon: Icon(Icons.show_chart, size: 35, color: Colors.teal),
                  title: ''),
              TabItem(
                  icon: Icon(Icons.settings, size: 35, color: Colors.teal),
                  title: ''),
            ],
            initialActiveIndex: 3, //optional, default as 0
            onTap: (int i) => {
              if (i == 0)
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              home_page(project.projectOwnerID)))
                }
              else if (i == 1)
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_nav_map(project)))
                }
              else if (i == 2)
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_nav_costs(project)))
                }
              else if (i == 4)
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_input(project)))
                }
            },
            backgroundColor: const Color(0xffeff8f8),
          )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.1,
            child: Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(
                      0.0,
                      0.0,
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height / 1.1),
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height / 1.1),
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
                            MediaQuery.of(context).size.height / 1.1),
                        size: Size(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height / 1.1),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child: Container(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
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
            offset: Offset(MediaQuery.of(context).size.width / 14,
                MediaQuery.of(context).size.height / 6),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.175,
              height: MediaQuery.of(context).size.height / 1.45,
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
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 3.3,
                MediaQuery.of(context).size.height / 5.3),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.7,
              child: Text(
                'الأرباح السنوية المتوقعة',
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
            offset: Offset(MediaQuery.of(context).size.width / 4.5,
                MediaQuery.of(context).size.height / 1.35),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                'توقعات الايراد لكل سنه',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 20,
                  color: const Color(0xff30a59a),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 6.5,
                MediaQuery.of(context).size.height / 4.2),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                'ملاحظة: الإيرادات المتوقعة هي إيرادات تقريبية تعتمد على أكثر فئة عمرية استهلاكاً لكوب القهوة في الحي المُختار',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 10,
                  color: const Color(0xff01756a),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 20,
                MediaQuery.of(context).size.height / 3.3),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.19,
              height: MediaQuery.of(context).size.height / 2.4,
              child: SfCartesianChart(
                  primaryXAxis: NumericAxis(
                      title: AxisTitle(
                          text: 'السنوات',
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300)),
                      interval: 1),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                        text: 'الايراد',
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300)),
                    numberFormat: NumberFormat.compact(),
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, int>>[
                    SplineSeries<_SalesData, int>(
                        dataSource: salesData,
                        xValueMapper: (_SalesData sales, _) => sales.months,
                        yValueMapper: (_SalesData sales, _) => sales.revenue,
                        color: const Color(0xff01756a),
                        markerSettings: MarkerSettings(
                            isVisible: true, color: const Color(0xff01756a)),
                        name: 'توقعات الايرادات'),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.months, this.revenue);

  final int months;
  final double revenue;
}

const String _svg_ihlku9 =
    '<svg viewBox="34.0 256.0 1.0 281.5" ><path  d="M 34 256 L 34 537.5493774414062" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ce180r =
    '<svg viewBox="126.3 256.0 1.0 281.5" ><path transform="translate(-14.74, 0.0)" d="M 141 256 L 141 537.5493774414062" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vdn84n =
    '<svg viewBox="222.1 256.0 1.0 281.5" ><path transform="translate(-25.86, 0.0)" d="M 248 256 L 248 537.5493774414062" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_9mbu6z =
    '<svg viewBox="317.0 256.0 1.0 281.5" ><path transform="translate(-37.96, 0.0)" d="M 355 256 L 355 537.5493774414062" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_htmsaw =
    '<svg viewBox="34.0 537.5 282.0 1.0" ><path transform="translate(0.0, -44.45)" d="M 34.00000381469727 582 L 316.042236328125 582" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qetzyp =
    '<svg viewBox="34.0 492.1 282.0 1.0" ><path transform="translate(0.0, -34.94)" d="M 34.00000381469727 527 L 316.042236328125 527" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xvt9du =
    '<svg viewBox="34.0 444.9 282.0 1.0" ><path transform="translate(0.0, -28.11)" d="M 34.00000381469727 473 L 316.042236328125 473" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_nl1nmb =
    '<svg viewBox="34.0 397.7 282.0 1.0" ><path transform="translate(0.0, -21.27)" d="M 34.00000381469727 419 L 316.042236328125 419" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_x2y4u7 =
    '<svg viewBox="34.0 349.7 282.0 1.0" ><path transform="translate(0.0, -14.31)" d="M 34.00000381469727 364 L 316.042236328125 364" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_l0g0gq =
    '<svg viewBox="34.0 310.0 282.0 1.0" ><path transform="translate(0.0, 0.0)" d="M 34.00000381469727 310 L 316.042236328125 310" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_945a3r =
    '<svg viewBox="34.0 256.0 282.0 1.0" ><path transform="translate(0.0, 0.0)" d="M 34.00000381469727 256 L 316.042236328125 256" fill="none" stroke="#f0f0f0" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_et5g4y =
    '<svg viewBox="35.0 444.2 279.8 62.9" ><path transform="translate(0.0, -31.29)" d="M 34.96117782592773 538.4310302734375 C 34.96117782592773 538.4310302734375 79.73436737060547 508.7276000976562 126.4148483276367 508.7276000976562 C 173.9760894775391 508.7276000976562 181.072509765625 464.2387084960938 225.3211975097656 478.2413330078125 C 260.5873718261719 489.4014282226562 296.4263000488281 482.7723388671875 309.7713317871094 479.5611877441406 C 312.8595886230469 478.818359375 314.7201843261719 478.2413330078125 314.7201843261719 478.2413330078125" fill="none" stroke="#ad0e32" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tzyua2 =
    '<svg viewBox="218.0 442.7 8.0 8.0" ><path transform="translate(218.0, 442.68)" d="M 4 0 C 6.209138870239258 0 8 1.790861129760742 8 4 C 8 6.209138870239258 6.209138870239258 8 4 8 C 1.790861129760742 8 0 6.209138870239258 0 4 C 0 1.790861129760742 1.790861129760742 0 4 0 Z" fill="#ad0e32" stroke="#000000" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xmjq48 =
    '<svg viewBox="35.1 353.0 280.2 33.0" ><path transform="translate(0.0, 0.0)" d="M 35.109375 380.2826843261719 C 35.109375 380.2826843261719 80.74727630615234 353 127.4477462768555 353 C 175.0293884277344 353 175.0293884277344 386 221.7298431396484 386 C 268.4302978515625 386 315.3239440917969 359.7476806640625 315.3239440917969 359.7476806640625" fill="none" stroke="#30a59a" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wgpect =
    '<svg viewBox="329.5 624.3 22.3 14.4" ><path transform="translate(330.98, 621.11)" d="M 9.490972518920898 3.151916265487671 C 14.6539249420166 3.151916265487671 20.88427734375 3.646628618240356 20.88427734375 8.732126235961914 C 20.88427734375 13.81762409210205 14.1651496887207 17.58117485046387 9.490972518920898 17.58117485046387 C 4.816795349121094 17.58117485046387 -1.42895519733429 13.81762409210205 -1.42895519733429 8.732126235961914 C -1.42895519733429 3.646628618240356 4.328019142150879 3.151916265487671 9.490972518920898 3.151916265487671 Z" fill="#30a59a" stroke="#000000" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_r61nub =
    '<svg viewBox="0.0 0.0 15.0 21.8" ><path transform="translate(-7.5, -3.0)" d="M 14.99157524108887 3 C 10.86050701141357 3 7.500000953674316 6.423777103424072 7.500000953674316 10.63262367248535 C 7.500000953674316 16.35709190368652 14.99157524108887 24.8074951171875 14.99157524108887 24.8074951171875 C 14.99157524108887 24.8074951171875 22.483154296875 16.35709190368652 22.483154296875 10.63262367248535 C 22.483154296875 6.423777103424072 19.12264633178711 3 14.99157524108887 3 Z M 19.27247619628906 11.72299766540527 L 16.06180000305176 11.72299766540527 L 16.06180000305176 14.99412250518799 L 13.92135047912598 14.99412250518799 L 13.92135047912598 11.72299766540527 L 10.7106761932373 11.72299766540527 L 10.7106761932373 9.542248725891113 L 13.92135047912598 9.542248725891113 L 13.92135047912598 6.271124839782715 L 16.06180000305176 6.271124839782715 L 16.06180000305176 9.542248725891113 L 19.27247619628906 9.542248725891113 L 19.27247619628906 11.72299766540527 Z" fill="#ad0e32" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_1oeceb =
    '<svg viewBox="329.5 606.7 22.3 82.0" ><path transform="translate(325.52, 603.69)" d="M 14.99157524108887 3 C 10.86050701141357 3 7.500000953674316 6.423777103424072 7.500000953674316 10.63262367248535 C 7.500000953674316 16.35709190368652 14.99157524108887 24.8074951171875 14.99157524108887 24.8074951171875 C 14.99157524108887 24.8074951171875 22.483154296875 16.35709190368652 22.483154296875 10.63262367248535 C 22.483154296875 6.423777103424072 19.12264633178711 3 14.99157524108887 3 Z M 19.27247619628906 11.72299766540527 L 16.06180000305176 11.72299766540527 L 16.06180000305176 14.99412250518799 L 13.92135047912598 14.99412250518799 L 13.92135047912598 11.72299766540527 L 10.7106761932373 11.72299766540527 L 10.7106761932373 9.542248725891113 L 13.92135047912598 9.542248725891113 L 13.92135047912598 6.271124839782715 L 16.06180000305176 6.271124839782715 L 16.06180000305176 9.542248725891113 L 19.27247619628906 9.542248725891113 L 19.27247619628906 11.72299766540527 Z" fill="#30a59a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(330.98, 671.11)" d="M 9.490972518920898 3.151916265487671 C 14.6539249420166 3.151916265487671 20.88427734375 3.646628618240356 20.88427734375 8.732126235961914 C 20.88427734375 13.81762409210205 14.1651496887207 17.58117485046387 9.490972518920898 17.58117485046387 C 4.816795349121094 17.58117485046387 -1.42895519733429 13.81762409210205 -1.42895519733429 8.732126235961914 C -1.42895519733429 3.646628618240356 4.328019142150879 3.151916265487671 9.490972518920898 3.151916265487671 Z" fill="#ad0e32" stroke="#000000" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
