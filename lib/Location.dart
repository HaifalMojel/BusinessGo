 import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectLocation{

  String _id;
  double _longitude;
  double _latitude;
  String _city;
  String _country;
  String _district;
  int _population;
  int _competitors;

  ProjectLocation(this._longitude, this._latitude, this._city, this._country,
      this._district, this._population, this._competitors){
    setCurrentID();
  }

  setCurrentID() async{
    var userRef = Firestore.instance.collection('locations');
    await userRef.getDocuments().then((QuerySnapshot snapshot) {
      this.id = "location" + snapshot.documents.length.toString();
    });
  }

  int get competitors => _competitors;

  set competitors(int value) {
    _competitors = value;
  }

  int get population => _population;

  set population(int value) {
    _population = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}