import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_app/project_list.dart';
import 'package:flutter_app/user_nav_costs.dart';
import 'package:flutter_app/user_nav_map.dart';
import 'package:flutter_app/user_nav_revenue.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Project.dart';

class user_nav extends StatelessWidget {
  Project project;
  user_nav(project){
    this.project = project;
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
              offset: Offset(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.height/50),
              child: IconButton(
                onPressed: () async {

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                          (context) =>  project_list()));
                },
                icon: Icon(
                  Icons.backspace,
                  color: const Color(0xff1b5070),
                ),
                iconSize: 30.0,
              )
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/3.5, MediaQuery.of(context).size.height/10),
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
                            (context) => user_nav_map(project)
                        )
                    );
                  },
                  child: Stack(
                    children : <Widget> [
                      Transform.translate(
                        offset: Offset(0.0, -MediaQuery.of(context).size.height/30),
                        child: Text(
                          'الموقع',
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
                      ),
                      Transform.translate(
                        offset: Offset(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.height/30),
                        child: SizedBox(
                          width: 48.0,
                          height: 42.0,
                          child: Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 47.5, 41.6),
                                size: Size(47.5, 41.6),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                // Adobe XD layer: 'Icon awesome-map-ma…' (shape)
                                SvgPicture.string(
                                  _svg_hwdm5,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
                  backgroundColor: Colors.white70,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/3.5, MediaQuery.of(context).size.height/3.1),
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
                            (context) => user_nav_costs(project)
                        )
                    );
                  },
                  child: Stack(
                      children : <Widget> [
                        Transform.translate(
                          offset: Offset(0.0, -MediaQuery.of(context).size.height/30),
                          child: Text(
                            'التكاليف',
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
                        ),
                        Transform.translate(
                          offset: Offset(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.height/30),
                          child: SizedBox(
                            width: 48.0,
                            height: 42.0,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(0.0, 0.0, 47.5, 41.6),
                                  size: Size(47.5, 41.6),
                                  pinLeft: true,
                                  pinRight: true,
                                  pinTop: true,
                                  pinBottom: true,
                                  child:
                                  // Adobe XD layer: 'Icon awesome-map-ma…' (shape)
                                  SvgPicture.string(
                                    _svg_i78z9k,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                  backgroundColor: Colors.white70,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/3.5, MediaQuery.of(context).size.height/1.83),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/2.3,
              child: Container(
                width: MediaQuery.of(context).size.width/2.3,
                height: MediaQuery.of(context).size.width/2.3,
                child: FloatingActionButton(
                  heroTag: 'btn3',
                  onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) => user_nav_revenue(project)
                        )
                    );
                  },
                  child: Stack(
                      children : <Widget> [
                        Transform.translate(
                          offset: Offset(0.0, -MediaQuery.of(context).size.height/30),
                          child: Text(
                            'الإيرادات',
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
                        ),
                        Transform.translate(
                          offset: Offset(MediaQuery.of(context).size.width/30, MediaQuery.of(context).size.height/30),
                          child: SizedBox(
                            width: 48.0,
                            height: 42.0,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(0.0, 0.0, 47.5, 41.6),
                                  size: Size(47.5, 41.6),
                                  pinLeft: true,
                                  pinRight: true,
                                  pinTop: true,
                                  pinBottom: true,
                                  child:
                                  // Adobe XD layer: 'Icon awesome-map-ma…' (shape)
                                  SvgPicture.string(
                                    _svg_eesr1r,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
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
    /*return Scaffold(
      backgroundColor: const Color(0xffeff8f8),
      body: Stack(
        children: <Widget>[
          Container(),
          Container(),
          Container(),
          Transform.translate(
            offset: Offset(110.0, 157.0),
            child: SvgPicture.string(
              _svg_gxjnhp,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(107.2, 229.0),
            child: SizedBox(
              width: 166.0,
              child: Text(
                'الخريطة',
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
            ),
          ),
          Transform.translate(
            offset: Offset(109.0, 325.0),
            child: SvgPicture.string(
              _svg_4555pr,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(98.9, 397.0),
            child: SizedBox(
              width: 169.0,
              child: Text(
                'التكاليف',
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
            ),
          ),
          Transform.translate(
            offset: Offset(164.0, 190.3),
            child: SizedBox(
              width: 48.0,
              height: 42.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 47.5, 41.6),
                    size: Size(47.5, 41.6),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Icon awesome-map-ma…' (shape)
                        SvgPicture.string(
                      _svg_hwdm5,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(165.0, 354.5),
            child:
                // Adobe XD layer: '1611343' (group)
                SizedBox(
              width: 47.0,
              height: 46.0,
              child: Stack(
                children: <Widget>[
                  SvgPicture.string(
                    _svg_i78z9k,
                    allowDrawingOutsideViewBox: true,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(109.0, 493.0),
            child: SvgPicture.string(
              _svg_omd3dt,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(98.9, 565.0),
            child: SizedBox(
              width: 169.0,
              child: Text(
                'الربح',
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
            ),
          ),
          Transform.translate(
            offset: Offset(166.0, 524.0),
            child: SvgPicture.string(
              _svg_eesr1r,
              allowDrawingOutsideViewBox: true,
            ),
          ),
        ],
      ),
    );*/
  }
}

const String _svg_gxjnhp =
    '<svg viewBox="110.0 157.0 154.9 500.8" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(115.0, 171.0)" d="M 72.953369140625 0 C 113.2444000244141 0 145.90673828125 32.96068572998047 145.90673828125 73.6197509765625 C 145.90673828125 114.27880859375 113.2444000244141 147.239501953125 72.953369140625 147.239501953125 C 32.66233825683594 147.239501953125 0 114.27880859375 0 73.6197509765625 C 0 32.96068572998047 32.66233825683594 0 72.953369140625 0 Z" fill="#1b5070" fill-opacity="0.55" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(114.0, 339.0)" d="M 74.28369140625 0 C 115.3094329833984 0 148.5673828125 33.7638053894043 148.5673828125 75.41357421875 C 148.5673828125 117.0633316040039 115.3094329833984 150.8271484375 74.28369140625 150.8271484375 C 33.25794219970703 150.8271484375 0 117.0633316040039 0 75.41357421875 C 0 33.7638053894043 33.25794219970703 0 74.28369140625 0 Z" fill="#1b5070" fill-opacity="0.55" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(114.0, 507.0)" d="M 74.28369140625 0 C 115.3094329833984 0 148.5673828125 33.7638053894043 148.5673828125 75.41357421875 C 148.5673828125 117.0633316040039 115.3094329833984 150.8271484375 74.28369140625 150.8271484375 C 33.25794219970703 150.8271484375 0 117.0633316040039 0 75.41357421875 C 0 33.7638053894043 33.25794219970703 0 74.28369140625 0 Z" fill="#1b5070" fill-opacity="0.55" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(110.0, 157.0)" d="M 77.453369140625 0 C 120.2296829223633 0 154.90673828125 33.69580078125 154.90673828125 75.26167297363281 C 154.90673828125 116.8275527954102 120.2296829223633 150.5233459472656 77.453369140625 150.5233459472656 C 34.67705917358398 150.5233459472656 0 116.8275527954102 0 75.26167297363281 C 0 33.69580078125 34.67705917358398 0 77.453369140625 0 Z" fill="#f6f9f8" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_4555pr =
    '<svg viewBox="109.0 325.0 157.6 154.1" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(109.0, 325.0)" d="M 78.78369140625 0 C 122.2947235107422 0 157.5673828125 34.49892425537109 157.5673828125 77.05549621582031 C 157.5673828125 119.6120681762695 122.2947235107422 154.1109924316406 78.78369140625 154.1109924316406 C 35.27266311645508 154.1109924316406 0 119.6120681762695 0 77.05549621582031 C 0 34.49892425537109 35.27266311645508 0 78.78369140625 0 Z" fill="#f6f9f8" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_hwdm5 =
    '<svg viewBox="0.0 0.0 47.5 41.6" ><path  d="M 23.7608642578125 0 C 18.01947975158691 0 13.36548519134521 4.586564540863037 13.36548519134521 10.24476432800293 C 13.36548519134521 14.81913280487061 20.15960502624512 23.15641593933105 22.76257705688477 26.18268966674805 C 23.28977203369141 26.79574775695801 24.23277854919434 26.79574775695801 24.7591495513916 26.18268966674805 C 27.36212158203125 23.15641593933105 34.1562385559082 14.81913280487061 34.1562385559082 10.24476432800293 C 34.1562385559082 4.586564540863037 29.50224685668945 0 23.7608642578125 0 Z M 23.7608642578125 13.65968418121338 C 21.84679222106934 13.65968418121338 20.29573822021484 12.13110065460205 20.29573822021484 10.24476432800293 C 20.29573822021484 8.358426094055176 21.84679222106934 6.829842090606689 23.7608642578125 6.829842090606689 C 25.67493438720703 6.829842090606689 27.22598838806152 8.358426094055176 27.22598838806152 10.24476432800293 C 27.22598838806152 12.13110065460205 25.67493438720703 13.65968418121338 23.7608642578125 13.65968418121338 Z M 1.659960269927979 17.55838584899902 C 0.6576058864593506 17.9534912109375 0.0002408687287243083 18.91011810302734 0 19.97403717041016 L 0 40.32696914672852 C 0 41.24736404418945 0.9430092573165894 41.87668609619141 1.810115814208984 41.53519821166992 L 13.20047950744629 36.42582702636719 L 13.20047950744629 17.47463798522949 C 12.47115230560303 16.17534255981445 11.87465572357178 14.91019630432129 11.44728946685791 13.70033931732178 L 1.659960269927979 17.55838584899902 Z M 23.7608642578125 29.24392318725586 C 22.60004425048828 29.24392318725586 21.50193214416504 28.7414379119873 20.74867630004883 27.86494445800781 C 19.12666893005371 25.97860717773438 17.40153121948242 23.83045959472656 15.84057521820068 21.62702178955078 L 15.84057521820068 36.42501449584961 L 31.68115043640137 41.62870788574219 L 31.68115043640137 21.62783432006836 C 30.12019157409668 23.83045959472656 28.39588356018066 25.97942161560059 26.77304840087891 27.86575317382812 C 26.01979446411133 28.7414379119873 24.92168235778809 29.24392318725586 23.7608642578125 29.24392318725586 Z M 45.71160888671875 13.10354042053223 L 34.32124710083008 18.21291351318359 L 34.32124710083008 41.6295166015625 L 45.86176300048828 37.08035659790039 C 46.8642692565918 36.68543243408203 47.5217170715332 35.72869110107422 47.521728515625 34.66470336914062 L 47.521728515625 14.31177139282227 C 47.521728515625 13.39136981964111 46.57871627807617 12.76204776763916 45.71160888671875 13.10354042053223 Z" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_i78z9k =
    '<svg viewBox="0.0 0.0 46.9 46.2" ><path transform="translate(-91.76, -109.69)" d="M 104.0078201293945 131.4839477539062 C 104.0078201293945 137.5545501708984 109.3528823852539 142.4756927490234 115.9463729858398 142.4756927490234 C 122.5398635864258 142.4756927490234 127.8849411010742 137.5545501708984 127.8849411010742 131.4839477539062 C 127.8849411010742 125.4133605957031 122.5398635864258 120.4921798706055 115.9463729858398 120.4921798706055 C 109.3561172485352 120.4989852905273 104.0152053833008 125.4163208007812 104.0078201293945 131.4839477539062 Z M 115.9463729858398 132.1785430908203 C 113.9652252197266 132.1887664794922 112.286506652832 130.8378295898438 112.0330200195312 129.0286865234375 C 111.7795562744141 127.2199478149414 113.03076171875 125.5204849243164 114.9500350952148 125.067756652832 L 114.9500350952148 124.1385345458984 C 114.9500350952148 123.7177047729492 115.3203125 123.3767929077148 115.7774047851562 123.3767929077148 C 116.2344665527344 123.3767929077148 116.6047515869141 123.7177047729492 116.6047515869141 124.1385345458984 L 116.6047515869141 125.0214385986328 C 118.4820175170898 125.3138961791992 119.8523254394531 126.8165512084961 119.8403167724609 128.5700225830078 C 119.8403167724609 128.9857482910156 119.4741973876953 129.3228302001953 119.0226669311523 129.3228302001953 C 118.5711212158203 129.3228302001953 118.2049865722656 128.9857482910156 118.2049865722656 128.5700225830078 C 118.2036056518555 127.4193344116211 117.1897277832031 126.4875335693359 115.9399108886719 126.4888153076172 C 114.6901016235352 126.4900970458984 113.6780548095703 127.4239959716797 113.6799011230469 128.5746917724609 C 113.6812973022461 129.7249755859375 114.6956405639648 130.6567230224609 115.9454498291016 130.6550445556641 C 117.9718475341797 130.6656646728516 119.6547317504883 132.0973358154297 119.8260116577148 133.9566497802734 C 119.9973068237305 135.8155212402344 118.6002197265625 137.48779296875 116.6047515869141 137.8125610351562 L 116.6047515869141 138.7205352783203 C 116.6047515869141 139.141357421875 116.2344665527344 139.4822540283203 115.7774047851562 139.4822540283203 C 115.3203125 139.4822540283203 114.9500350952148 139.141357421875 114.9500350952148 138.7205352783203 L 114.9500350952148 137.7657928466797 C 113.2209854125977 137.3453979492188 112.0127105712891 135.9103240966797 112.0011749267578 134.2639923095703 C 112.0011749267578 133.8384704589844 112.3760681152344 133.4933166503906 112.8382415771484 133.4933166503906 C 113.3003921508789 133.4933166503906 113.67529296875 133.8384704589844 113.67529296875 134.2639923095703 C 113.6780548095703 135.3279724121094 114.5488128662109 136.2201995849609 115.6975250244141 136.3362426757812 C 115.7399826049805 136.3298797607422 115.7833938598633 136.326904296875 115.8267974853516 136.3264617919922 C 115.8891296386719 136.3264617919922 115.9509963989258 136.3332824707031 116.0119323730469 136.3460083007812 C 117.2529754638672 136.3179626464844 118.2377853393555 135.3751373291016 118.2197647094727 134.2325286865234 C 118.2017669677734 133.0894775390625 117.1874160766602 132.1734313964844 115.9463729858398 132.1785430908203 Z M 115.9463729858398 132.1785430908203" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-56.7, -318.69)" d="M 100.0476684570312 353.8637390136719 C 100.0416717529297 353.86669921875 100.0352096557617 353.8696899414062 100.0282745361328 353.8726501464844 L 92.34796142578125 357.21337890625 C 92.43059539794922 357.6048889160156 92.46661376953125 358.0032348632812 92.45506286621094 358.4019165039062 C 92.44306182861328 358.814208984375 92.07646942138672 359.142822265625 91.62862396240234 359.142822265625 C 91.62077331542969 359.142822265625 91.61293029785156 359.142822265625 91.60507202148438 359.142822265625 L 80.36460876464844 358.8580322265625 C 79.90753173828125 358.8465270996094 79.54740905761719 358.4962768554688 79.55987548828125 358.0754699707031 C 79.57233428955078 357.6546325683594 79.95323944091797 357.3230590820312 80.40986633300781 357.3345642089844 L 90.74217987060547 357.5963745117188 C 90.39958953857422 355.7528076171875 88.69224548339844 354.387451171875 86.66169738769531 354.3330383300781 L 79.82395935058594 354.1600341796875 C 78.47350311279297 354.1242980957031 77.14935302734375 353.809326171875 75.94940185546875 353.2384338378906 L 75.25362396240234 352.9068603515625 C 71.83661651611328 351.2677917480469 67.71918487548828 351.4811401367188 64.52379608154297 353.4633483886719 L 64.25 362.6216735839844 L 65.42502593994141 362.0423278808594 C 66.5926513671875 361.4642028808594 67.95881652832031 361.3264465332031 69.23494720458984 361.658447265625 L 80.8392333984375 364.6573791503906 C 83.07569885253906 365.0790710449219 85.39987945556641 364.8401794433594 87.48028564453125 363.973876953125 L 103.5570373535156 354.3993225097656 C 102.6396331787109 353.5346984863281 101.218994140625 353.3175048828125 100.0476684570312 353.8637390136719 Z M 100.0476684570312 353.8637390136719" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-0.36, -308.65)" d="M 0.3593750298023224 354.1767578125 L 0.7670533657073975 340.55078125 L 6.61121129989624 340.6991577148438 L 6.203532695770264 354.3251342773438 L 0.3593750298023224 354.1767578125 Z M 0.3593750298023224 354.1767578125" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-174.27, 0.0)" d="M 199.2406768798828 9.032129287719727 L 199.2406768798828 0.7617459297180176 C 199.2406768798828 0.3409152030944824 198.8703918457031 0 198.4133148193359 0 C 197.9562377929688 0 197.5859375 0.3409152030944824 197.5859375 0.7617459297180176 L 197.5859375 9.032129287719727 C 197.5859375 9.452960014343262 197.9562377929688 9.793874740600586 198.4133148193359 9.793874740600586 C 198.8703918457031 9.793874740600586 199.2406768798828 9.452960014343262 199.2406768798828 9.032129287719727 Z M 199.2406768798828 9.032129287719727" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-227.18, -35.65)" d="M 259.2406616210938 44.67929840087891 L 259.2406616210938 40.76174926757812 C 259.2406616210938 40.34091567993164 258.8703918457031 40 258.413330078125 40 C 257.9562072753906 40 257.5859375 40.34091567993164 257.5859375 40.76174926757812 L 257.5859375 44.67929840087891 C 257.5859375 45.10013198852539 257.9562072753906 45.44104385375977 258.413330078125 45.44104385375977 C 258.8703918457031 45.44104385375977 259.2406616210938 45.10013198852539 259.2406616210938 44.67929840087891 Z M 259.2406616210938 44.67929840087891" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-121.37, -35.65)" d="M 139.2406616210938 44.67929840087891 L 139.2406616210938 40.76174926757812 C 139.2406616210938 40.34091567993164 138.870361328125 40 138.4132995605469 40 C 137.9562072753906 40 137.5859375 40.34091567993164 137.5859375 40.76174926757812 L 137.5859375 44.67929840087891 C 137.5859375 45.10013198852539 137.9562072753906 45.44104385375977 138.4132995605469 45.44104385375977 C 138.870361328125 45.44104385375977 139.2406616210938 45.10013198852539 139.2406616210938 44.67929840087891 Z M 139.2406616210938 44.67929840087891" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_omd3dt =
    '<svg viewBox="109.0 493.0 157.6 154.1" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(109.0, 493.0)" d="M 78.78369140625 0 C 122.2947235107422 0 157.5673828125 34.49892425537109 157.5673828125 77.05549621582031 C 157.5673828125 119.6120681762695 122.2947235107422 154.1109924316406 78.78369140625 154.1109924316406 C 35.27266311645508 154.1109924316406 0 119.6120681762695 0 77.05549621582031 C 0 34.49892425537109 35.27266311645508 0 78.78369140625 0 Z" fill="#f6f9f8" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_eesr1r =
    '<svg viewBox="166.0 524.0 42.5 41.1" ><path transform="translate(165.99, 524.0)" d="M 41.08250427246094 15.3971061706543 L 38.17765045166016 12.63092136383057 L 26.39403533935547 24.05870056152344 C 26.25542640686035 24.43315887451172 26.06169128417969 24.74063873291016 25.81282615661621 24.98114204406738 C 25.25997161865234 25.51542854309082 24.58229064941406 25.72929382324219 23.77978324890137 25.62274360656738 C 23.06075477600098 25.64937973022461 22.45237922668457 25.42219543457031 21.95465087890625 24.94118499755859 C 21.70578765869141 24.72731781005859 21.52583312988281 24.44647598266602 21.4147891998291 24.09865760803223 L 19.87908172607422 22.61453056335449 C 19.82395172119141 22.69444465637207 19.07027435302734 23.50310516357422 17.61804389953613 25.04050827026367 C 16.16581535339355 26.57791137695312 15.37039566040039 27.4132080078125 15.23178768157959 27.5463981628418 C 14.67893314361572 28.08068466186523 13.98746967315674 28.2945499420166 13.15739822387695 28.1879997253418 C 12.4383716583252 28.21463584899902 11.82999420166016 27.98745155334473 11.33226680755615 27.50644111633301 C 11.08340263366699 27.29257392883301 10.90344905853271 27.01173210144043 10.79240608215332 26.66391372680664 L 10.58449459075928 26.46298408508301 L 5.522560596466064 31.35489463806152 C 5.494997024536133 31.38153266906738 5.460344791412354 31.40817260742188 5.418605327606201 31.4348087310791 C 5.376865386962891 31.46144676208496 5.342213153839111 31.48808670043945 5.31464958190918 31.51472473144531 L 5.31464958190918 35.92486190795898 L 39.83385467529297 35.92486190795898 C 40.55287933349609 35.92486190795898 41.17504119873047 36.17868804931641 41.70033645629883 36.68633270263672 C 42.22562789916992 37.1939811706543 42.48827743530273 37.80209350585938 42.48827362060547 38.51066970825195 C 42.48826599121094 39.21924209594727 42.22562408447266 39.82050704956055 41.70033645629883 40.31445693969727 C 41.175048828125 40.80840301513672 40.55288696289062 41.05575942993164 39.83385467529297 41.05652236938477 L 2.659055471420288 41.05652236938477 C 1.912464499473572 41.05652236938477 1.283217430114746 40.80916595458984 0.7713141441345215 40.31445693969727 C 0.259410947561264 39.81974411010742 0.004640384111553431 39.21239471435547 0.007002491503953934 38.49240493774414 L 0.007002491503953934 2.566256284713745 C 0.007002491503953934 1.87138044834137 0.26295405626297 1.270118832588196 0.774857223033905 0.7624711394309998 C 1.286760330200195 0.2548235654830933 1.9089195728302 0.0009998226305469871 2.641334772109985 0.0009998679161071777 C 3.373749971389771 0.0009999133180826902 4.002997398376465 0.2548236846923828 4.52907657623291 0.7624711394309998 C 5.055155277252197 1.270118594169617 5.317801475524902 1.87138032913208 5.317013263702393 2.566256284713745 L 5.317013263702393 24.82016944885254 L 8.137992858886719 22.09394073486328 C 8.248249053955078 21.77352333068848 8.428202629089355 21.49267959594727 8.677853584289551 21.25141334533691 C 9.175580978393555 20.7704029083252 9.783958435058594 20.5432186126709 10.50298500061035 20.56985664367676 C 11.30549240112305 20.48994255065918 11.98317337036133 20.70380973815918 12.5360279083252 21.21145629882812 C 12.78489112854004 21.45196151733398 12.9786262512207 21.77276039123535 13.1172342300415 22.17385482788086 L 13.24127197265625 22.29372787475586 L 17.431396484375 18.24434280395508 C 17.54165267944336 17.92392349243164 17.72160530090332 17.64308166503906 17.97125625610352 17.40181541442871 C 18.46898460388184 16.92080688476562 19.07736206054688 16.6936206817627 19.79638671875 16.72025871276855 C 20.6264591217041 16.64034461975098 21.30414009094238 16.85421180725098 21.82943153381348 17.36185836791992 C 22.07829475402832 17.60236358642578 22.27202987670898 17.92316436767578 22.4106388092041 18.32425880432129 L 23.86247444152832 19.72732925415039 L 34.69158935546875 9.261951446533203 L 31.87060737609863 6.53572416305542 C 31.84304428100586 5.573705196380615 32.14743041992188 5.106015205383301 32.78376388549805 5.13265323638916 L 41.16519546508789 5.13265323638916 C 41.55266571044922 5.159290790557861 41.86375045776367 5.286393165588379 42.09843444824219 5.513959884643555 C 42.33312225341797 5.741526126861572 42.46464538574219 6.042157173156738 42.49299621582031 6.415852069854736 L 42.49299621582031 14.51576042175293 C 42.52056121826172 15.1573600769043 42.05039215087891 15.45152187347412 41.08250427246094 15.39824485778809 Z" fill="#01756a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
