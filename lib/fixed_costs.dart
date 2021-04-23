import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class fixed_costs extends StatelessWidget {
  fixed_costs({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff8f8),
      body: Stack(
        children: <Widget>[
          Container(
            width: 375.0,
            height: 812.0,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: const Color(0xff707070)),
            ),
          ),
          SizedBox(
            width: 375.0,
            height: 812.0,
            child: Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 812.0),
                  size: Size(375.0, 812.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 812.0),
                        size: Size(375.0, 812.0),
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
            width: 375.0,
            height: 210.0,
            decoration: BoxDecoration(
              color: const Color(0xffb7e0ee),
            ),
          ),
          Transform.translate(
            offset: Offset(-77.0, 57.0),
            child:
                // Adobe XD layer: 'Picture2' (group)
                SizedBox(
              width: 483.0,
              height: 123.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 483.0, 123.0),
                    size: Size(483.0, 123.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Picture2' (shape)
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(''),
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
            offset: Offset(26.0, 135.0),
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
            offset: Offset(158.6, 151.0),
            child: SizedBox(
              width: 185.0,
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
            offset: Offset(196.0, 192.0),
            child: SizedBox(
              width: 144.0,
              child: Text(
                '350,000 SR',
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
            offset: Offset(10.0, 277.0),
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 0,
                runSpacing: 0,
                children: [{}, {}, {}, {}, {}].map((map) {
                  return Transform.translate(
                    offset: Offset(4.0, 6.0),
                    child: SizedBox(
                      width: 352.0,
                      height: 71.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 352.0,
                            height: 71.0,
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
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(13.0, 277.0),
            child: Container(
              width: 352.0,
              height: 263.0,
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
            offset: Offset(239.4, 286.0),
            child: SizedBox(
              width: 115.0,
              child: Text(
                'التكاليف الثابتة',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 17,
                  color: const Color(0xff01756a),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(219.0, 756.0),
            child: SizedBox(
              width: 78.0,
              height: 36.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 78.0, 36.0),
                    size: Size(78.0, 36.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
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
                        border: Border.all(
                            width: 2.0, color: const Color(0x95168dd5)),
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(17.0, 6.0, 44.0, 25.0),
                    size: Size(78.0, 36.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: Text(
                      'حفظ',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 15,
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
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(76.0, 756.0),
            child: SizedBox(
              width: 110.0,
              height: 35.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(16.0, 0.0, 78.0, 35.0),
                    size: Size(110.0, 35.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
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
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 8.0, 110.0, 20.0),
                    size: Size(110.0, 35.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: Text(
                      'إلغاء',
                      style: TextStyle(
                        fontFamily: 'STC',
                        fontSize: 12,
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
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(33.8, 283.0),
            child: SizedBox(
              width: 86.0,
              child: Text(
                '70,000 SR',
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
            offset: Offset(44.0, 321.0),
            child: SizedBox(
              width: 166.0,
              height: 6.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 166.0, 6.0),
                    size: Size(166.0, 6.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xffaed6d2)),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 51.5, 6.0),
                    size: Size(166.0, 6.0),
                    pinLeft: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child: SvgPicture.string(
                      _svg_eudj0g,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(90.0, 318.0),
            child: SizedBox(
              width: 12.0,
              height: 12.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 12.0, 12.0),
                    size: Size(12.0, 12.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xff1b5070),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(2.6, 2.6, 6.9, 6.9),
                    size: Size(12.0, 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xff1b5070),
                        border: Border.all(
                            width: 1.0, color: const Color(0xffeff8f8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(183.0, 305.0),
            child: SizedBox(
              width: 26.0,
              child: Text(
                '20%',
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
            offset: Offset(17.3, 329.6),
            child: SvgPicture.string(
              _svg_gd4s55,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(273.6, 367.0),
            child: SizedBox(
              width: 65.0,
              child: Text(
                'الرواتب',
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
            offset: Offset(173.2, 410.0),
            child: SizedBox(
              width: 178.0,
              child: Text(
                'صيانة الآلات الدورية',
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
            offset: Offset(221.6, 450.0),
            child: SizedBox(
              width: 125.0,
              child: Text(
                'مصاريف اخرى',
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
            offset: Offset(233.6, 577.0),
            child: SizedBox(
              width: 125.0,
              child: Text(
                'تكاليف المعدات',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 17,
                  color: const Color(0xff01756a),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(268.8, 669.0),
            child: SizedBox(
              width: 86.0,
              child: Text(
                'سعر الإيجار',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 17,
                  color: const Color(0xff01756a),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(33.2, 683.0),
            child: SizedBox(
              width: 94.0,
              child: Text(
                '130,000 SR',
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
            offset: Offset(32.6, 591.0),
            child: SizedBox(
              width: 89.0,
              child: Text(
                '50,000 SR',
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
            offset: Offset(41.0, 622.0),
            child: Container(
              width: 166.0,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: const Color(0xffaed6d2)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(41.0, 622.0),
            child: SvgPicture.string(
              _svg_l3y7m8,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(77.0, 619.0),
            child: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xff1b5070),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(79.6, 621.6),
            child: Container(
              width: 6.9,
              height: 6.9,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xff1b5070),
                border: Border.all(width: 1.0, color: const Color(0xffeff8f8)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(40.0, 721.0),
            child: SvgPicture.string(
              _svg_5b48p9,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(103.0, 718.0),
            child: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xff1b5070),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(105.6, 720.6),
            child: Container(
              width: 6.9,
              height: 6.9,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xff1b5070),
                border: Border.all(width: 1.0, color: const Color(0xffeff8f8)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(185.0, 605.0),
            child: SizedBox(
              width: 22.0,
              child: Text(
                '15%',
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
            offset: Offset(184.0, 704.0),
            child: SizedBox(
              width: 24.0,
              child: Text(
                '35%',
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
            offset: Offset(45.0, 507.0),
            child: SizedBox(
              width: 60.0,
              height: 29.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 60.0, 29.0),
                    size: Size(60.0, 29.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
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
                        border: Border.all(
                            width: 2.0, color: const Color(0x95168dd5)),
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
          ),
          Transform.translate(
            offset: Offset(48.6, 509.0),
            child: SizedBox(
              width: 53.0,
              child: Text(
                'تم',
                style: TextStyle(
                  fontFamily: 'STC',
                  fontSize: 15,
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
            ),
          ),
          Transform.translate(
            offset: Offset(50.2, 193.0),
            child: SizedBox(
              width: 70.0,
              child: Text(
                'الممتازة',
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
            offset: Offset(47.0, 169.0),
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
        ],
      ),
    );
  }
}

const String _svg_eudj0g =
    '<svg viewBox="0.0 0.0 51.5 6.0" ><path  d="M 1.3558030128479 0 L 50.16471099853516 0 C 50.91350173950195 0 51.5205078125 1.343145728111267 51.5205078125 3 C 51.5205078125 4.656854629516602 50.91350173950195 6 50.16471099853516 6 L 1.3558030128479 6 C 0.6070137023925781 6 0 4.656854629516602 0 3 C 0 1.343145728111267 0.6070137023925781 0 1.3558030128479 0 Z" fill="#b7e0ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_gd4s55 =
    '<svg viewBox="17.3 329.6 347.7 210.4" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(43.25, 432.47)" d="M -4.168464660644531 -12.09971714019775 C 11.62292575836182 -39.09617614746094 125.2196350097656 -6.590426445007324 172.8293304443359 -69.65972900390625 C 220.4390258789062 -132.7290802001953 321.7533874511719 -86.7021484375 321.7533874511719 -86.7021484375 L 321.7533874511719 -23.45330810546875 L 321.7533874511719 107.5319976806641 L -4.168464660644531 107.5319976806641 C -4.168464660644531 107.5319976806641 -53.23191452026367 37.52860641479492 -4.168464660644531 -12.09971714019775 Z" fill="#b7e0ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_l3y7m8 =
    '<svg viewBox="41.0 622.0 40.0 6.0" ><path transform="translate(41.0, 622.0)" d="M 1.051674365997314 0 L 38.91195297241211 0 C 39.49277496337891 0 39.963623046875 1.343145728111267 39.963623046875 3 C 39.963623046875 4.656854629516602 39.49277496337891 6 38.91195297241211 6 L 1.051674365997314 6 C 0.4708506762981415 6 0 4.656854629516602 0 3 C 0 1.343145728111267 0.4708506762981415 0 1.051674365997314 0 Z" fill="#b7e0ee" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_5b48p9 =
    '<svg viewBox="40.0 721.0 69.0 6.0" ><path transform="translate(40.0, 721.0)" d="M 1.81616222858429 0 L 67.19800567626953 0 C 68.20104217529297 0 69.01416015625 1.343145728111267 69.01416015625 3 C 69.01416015625 4.656854629516602 68.20104217529297 6 67.19800567626953 6 L 1.81616222858429 6 C 0.8131235241889954 6 0 4.656854629516602 0 3 C 0 1.343145728111267 0.8131235241889954 0 1.81616222858429 0 Z" fill="#1b5070" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
