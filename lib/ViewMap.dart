
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/Location.dart';
import 'package:flutter_app/Project.dart';
import 'package:flutter_app/basic_costs.dart';
import 'package:flutter_app/user_input.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:adobe_xd/pinned.dart';








class ViewMap extends StatefulWidget {
  @override
  var c , city , country;
  Project project , proj;
  ViewMap (capital , project , city , country , proj){
    c = capital;
    this.project = project;
    this.city = city;
    this.country = country;
    this.proj = proj;
  }
  _ViewMapState createState() => _ViewMapState(c , project , city , country , proj);
}

class _ViewMapState extends State<ViewMap> {

  var capital , city , country , project;
  bool searchClicked = false;
  Project proj;


  _ViewMapState(capital , project , city , country , proj){
    this.capital = capital;
    this.city = city;
    this.country = country;
    this.project = project;
    this.proj = proj;
  }

  List<Marker> allMarkers = [];
  var _markerIcon;
  int count;


  List<Map<String,dynamic>> data = [];
  Map<String,dynamic> tempData={};
  var competitor,result;

  List<Map<String,dynamic>> districtList=[];
  GoogleMapController mapController;

  String _selectedLocation;




  void _setMarkerIcon() async{
    _markerIcon = await getBytesFromAsset('assets/images/bgo_logo.png', 200);
  }

  loadDistricts()async{
    ByteData data = await rootBundle.load("assets/Districts.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    count=0;
    try{
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table].rows) {

          if(count==1){

            if(!isNumeric(row[2])){
              setState(() {
                districtList.add(
                  {
                    "name":row[2],
                    "population":row[10]
                  }
                );
              });

            }
          }
          count=1;
        }
      }}
    catch(ex){

    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  loadAsset() async {
    final myData = await rootBundle.loadString("assets/cleanAqar.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    List<Map<String,dynamic>> filteredDistricts = [];

    for(int i=1;i<csvTable.length;i++) {

      try {

        tempData = {};

        for(int j = 0; j < districtList.length; j++)
        if(csvTable[i][5].contains(districtList[j]['name']) && csvTable[i][3] >= project.minSpace && csvTable[i][3] <= project.maxSpace){

          tempData["Price"]=csvTable[i][2].toString();
          tempData["Size"]=csvTable[i][3].toString();
          tempData["address"] = csvTable[i][1].toString();
          tempData['Dis'] = districtList[j]['name'];
          tempData['population'] = districtList[j]['population'];
          if(!filteredDistricts.contains(districtList[j]))
            filteredDistricts.add(districtList[j]);

          data.add(tempData);

        }
      } catch (error) {
        print(error.toString());
      }

    }
    setState(() {
      for(int i = 0; i < districtList.length; i++){
        if(!filteredDistricts.contains(districtList[i])){
          districtList.removeAt(i);
          i--;
        }
      }
    });

  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  getLocation() async {
    var rental;
    var userRef = Firestore.instance.collection('costs');
    try{
      await userRef.document(proj.projectCostsID).get().then((DocumentSnapshot doc) => {
        rental = doc.data['rCost']
      });
    }catch(Exception){}

    userRef = Firestore.instance.collection('locations');
    try{
      await userRef.document(proj.locationID).get().then((DocumentSnapshot doc) => {
        setState(() async{
          var lng = doc.data['longitude'];
          var lat = doc.data['latitude'];
          competitor = doc.data['competitors'];
          var population = doc.data['population'];
          var dis = doc.data['district'];
          final request=await http.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=$dis+in+Riyadh&key=AIzaSyBHnJzJUi0H2QCVs3zQxX62gdryoyWfj1w");
          var result = jsonDecode(request.body);
          if(request.statusCode==200){
            final LatLng southwest = LatLng(
              result["results"][0]["geometry"]["viewport"]["southwest"]["lat"],
              result["results"][0]["geometry"]["viewport"]["southwest"]["lng"],
            );

            final LatLng northeast = LatLng(
              result["results"][0]["geometry"]["viewport"]["northeast"]["lat"],
              result["results"][0]["geometry"]["viewport"]["northeast"]["lng"],
            );
            LatLngBounds bounds = LatLngBounds(
              southwest: southwest,
              northeast: northeast,
            );
            mapController.animateCamera(
                CameraUpdate.newLatLngBounds(bounds, 50.0)
            );
          }
          setState(() {
            allMarkers.add(
              Marker(
                  markerId: MarkerId("id"),
                  draggable: false,
                  position: LatLng(lat, lng),
                  onTap: (){
                    competitor = competitor != 0 ? competitor : 3;alertConfirmationDialog(context , rental , population.toString() , competitor.toString() , lng , lat , dis , proj.space);
                  },
                  icon: BitmapDescriptor.fromBytes(_markerIcon)
              ),
            );
          });
        })
      });
    }catch(e){print(e);}
  }


  @override
  void initState(){
    super.initState();
    _setMarkerIcon();
    if(proj != null)
      getLocation();
    loadDistricts();
    loadAsset();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
          Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width/12, 0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/12,
                  height: MediaQuery.of(context).size.height,
                child: Stack(
                  children:[
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/12,
                        height: MediaQuery.of(context).size.height,
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController googleMapController){
                            setState(() {
                              mapController = googleMapController;
                            });
                          },
                          initialCameraPosition: CameraPosition(
                              target: LatLng(24.7311, 46.6701), zoom: 10),
                          markers: Set.from(allMarkers),

                        ),
                      ),
                    ),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: searchClicked,
                      child: Transform.translate(
                          offset: Offset(0, MediaQuery.of(context).size.height/16),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width/1.1,
                            height: MediaQuery.of(context).size.height/9.5,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white , borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(8.0),
                              child: SearchableDropdown(
                                icon: Icon(Icons.search),
                                hint: new Text(
                                  'البحث عن الحي',
                                  style: new TextStyle(fontSize: 18 , color: Colors.blue),
                                  textAlign: TextAlign.right,
                                ),
                                value: _selectedLocation,
                                //displayClearIcon: false,
                                items: districtList.map((location) {
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: new Text(location["name"], style: new TextStyle(fontSize: 14 , color: Colors.blueGrey) , textAlign: TextAlign.right,),
                                      ),
                                    ),
                                    value: location["name"],
                                    onTap: (){

                                      _selectedLocation = location["name"];
                                    },
                                  );
                                }).toList(),
                                isExpanded: true,
                                dialogBox: true,

                                onChanged: (value) async{
                                  setState(() {
                                    _selectedLocation = value;
                                  });
                                  final request=await http.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=$_selectedLocation+in+Riyadh&key=AIzaSyBHnJzJUi0H2QCVs3zQxX62gdryoyWfj1w");
                                  result=jsonDecode(request.body);
                                  if(request.statusCode==200){
                                    final LatLng southwest = LatLng(
                                      result["results"][0]["geometry"]["viewport"]["southwest"]["lat"],
                                      result["results"][0]["geometry"]["viewport"]["southwest"]["lng"],
                                    );

                                    final LatLng northeast = LatLng(
                                      result["results"][0]["geometry"]["viewport"]["northeast"]["lat"],
                                      result["results"][0]["geometry"]["viewport"]["northeast"]["lng"],
                                    );
                                    LatLngBounds bounds = LatLngBounds(
                                      southwest: southwest,
                                      northeast: northeast,
                                    );

                                    mapController.animateCamera(
                                        CameraUpdate.newLatLngBounds(bounds, 50.0)
                                    );
                                  }
                                  allMarkers.clear();
                                  for(int i = 0; i < data.length; i++){
                                    if(data[i]['Dis'] == value){
                                      var locations = await locationFromAddress(data[i]['address']);
                                      final request=await http.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${locations[0].latitude.toString()},${locations[0].longitude.toString()}&radius=500&type=cafe&key=AIzaSyBHnJzJUi0H2QCVs3zQxX62gdryoyWfj1w");
                                      result=jsonDecode(request.body);
                                      if(request.statusCode==200){

                                        competitor=result["results"].length;
                                      }
                                      else{
                                        competitor=0;
                                      }
                                      setState(() {
                                        allMarkers.add(
                                          Marker(
                                              markerId: MarkerId(i.toString()),
                                              draggable: false,
                                              position: LatLng(locations[0].latitude, locations[0].longitude),
                                              /*infoWindow:
                                              InfoWindow(
                                                  title: "Price:${data[i]['Price'].toString()}\n",
                                                  snippet:
                                                  "S:${data[i]['Size'].toString()}\n"
                                                      "C:$competitor\n"
                                                      "Pop:$population"
                                              )*/
                                              onTap: (){
                                                competitor = competitor != 0 ? competitor : 3;
                                                alertConfirmationDialog(context , double.parse(data[i]['Price']) , data[i]['population'].toString() , competitor.toString() , locations[0].longitude , locations[0].latitude , value , double.parse(data[i]['Size']));}
                                              ,
                                              icon: BitmapDescriptor.fromBytes(_markerIcon)),
                                        );
                                        _selectedLocation = '';
                                      });
                                    }

                                  }
                                },

                              ),
                            ),
                          )
                      ),
                    )
                  ],
                ),
              )
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/100, MediaQuery.of(context).size.height/1.3),
            child: SizedBox(
              width: 66.0,
              height: 62.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 66.0, 62.0),
                    size: Size(66.0, 62.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffd3edea),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(10, 7.1, 46.6, 46.6),
                    size: Size(66.0, 62.0),
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.8, 0.8, 45.1, 45.1),
                          size: Size(46.6, 46.6),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child: Transform.rotate(
                            angle: -0.0349,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(0.0, 0.0, 45.1, 45.1),
                                  size: Size(45.1, 45.1),
                                  pinLeft: true,
                                  pinRight: true,
                                  pinTop: true,
                                  pinBottom: true,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(9999.0, 9999.0)),
                                      color: const Color(0xffeff8f8),
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
                ],
              ),
            ),
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: !searchClicked,
              child: Transform.translate(
                offset: Offset(MediaQuery.of(context).size.width/100, MediaQuery.of(context).size.height/15),
                child: SizedBox(
                  width: 66.0,
                  height: 62.0,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 66.0, 62.0),
                        size: Size(66.0, 62.0),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                            color: const Color(0xffd3edea),
                          ),
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(10, 7.1, 46.6, 46.6),
                        size: Size(66.0, 62.0),
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        fixedWidth: true,
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(0.8, 0.8, 45.1, 45.1),
                              size: Size(46.6, 46.6),
                              pinLeft: true,
                              pinRight: true,
                              pinTop: true,
                              pinBottom: true,
                              child: Transform.rotate(
                                angle: -0.0349,
                                child: Stack(
                                  children: <Widget>[
                                    Pinned.fromSize(
                                      bounds: Rect.fromLTWH(0.0, 0.0, 45.1, 45.1),
                                      size: Size(45.1, 45.1),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(9999.0, 9999.0)),
                                          color: const Color(0xffeff8f8),
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
                    ],
                  ),
                ),
              ),
          ),
          Visibility(
              maintainSize: false,
              maintainAnimation: false,
              maintainState: false,
              visible: !searchClicked,
              child: Transform.translate(
                offset: Offset(MediaQuery.of(context).size.width/30, MediaQuery.of(context).size.height/14),
                child: IconButton(icon: Icon(Icons.search , size: 30,),
                    onPressed: (){setState(() {
                    searchClicked = true;
                    });}),
              )
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/15, MediaQuery.of(context).size.height/1.28),
            child: Draggable(
                feedback: Container(),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_forward_rounded , color: const Color(0xff1b5070), size: 20,),
                    Icon(Icons.touch_app , color: const Color(0xff1b5070), size: 20,),
                  ],
                ),
                childWhenDragging: Container(),
                onDragEnd: (details){
                  if(proj == null)
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            user_input(project))
                    );
                  else
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            user_input(proj))
                    );
                }
            ),
          )
        ],
      ),
    );
  }

  alertConfirmationDialog(BuildContext context , double rental , population , comp , lng , lat , district , double space) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                Container(
                  width: 250,
                  height: 40,
                  child: Text('سعر الايجار:     ' + (rental/space).round().toString() + ' ر.س / م² ' , textAlign: TextAlign.center,),
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
                Container(height: 15),
                Container(
                  width: 250,
                  height: 40,
                  child: Text('عدد المنافسين:       ' + comp, textAlign: TextAlign.center,),
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
                Container(height: 15),
                Container(
                  width: 250,
                  height: 40,
                  child: Text('عدد السكان:     ' + population.toString() , textAlign: TextAlign.center,),
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
                Container(height: 15),
                Row(
                  children: <Widget>[
                    Container(
                      height: 30,
                      child: OutlineButton(
                        color: const Color(0xffb7e0ee),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Text(
                          'الغاء' ,
                          style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(50, 0, 0, 50),
                                ),
                              ],
                              color: Colors.blue,
                              fontSize: 18
                          ),
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
                    ),
                    Container(width: 60),
                    Container(
                      height: 30,
                      child: OutlineButton(
                        color: const Color(0xffb7e0ee),
                        onPressed: () async{
                          project.space = space;
                          ProjectLocation loc = ProjectLocation(lng, lat, city, country, district, int.parse(population), int.parse(comp));
                          project.locationID = loc.id;
                          Timer(Duration(seconds: 3),
                                  ()=>Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                                      basic_costs(capital + 0.0, rental, project, loc, proj)
                                  )
                              )
                          );
                          alertFinishedDialog(context);
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Text(
                          'حفظ' ,
                          style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(50, 0, 0, 50),
                                ),
                              ],
                              color: Colors.blue,
                              fontSize: 18
                          ),
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
                    )
                    ]
                )
              ],
            ),
          ),

        );
      },
    );
  }

  alertFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Icon(Icons.done , size: 100, color: const Color(0xffb7e0ee)),
                Text('تم حفظ الموقع بنجاح' , textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)
              ],
            ),
          ),

        );
      },
    );
  }
}


