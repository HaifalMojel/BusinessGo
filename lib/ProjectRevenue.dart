import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectRevenue{

  String _id;
  double _value1;
  double _value2;
  double _value3;

  ProjectRevenue(this._value1, this._value2, this._value3){
    setCurrentRevenue();
  }

  setCurrentRevenue() async{
    var userRef = Firestore.instance.collection('revenue');
    await userRef.getDocuments().then((QuerySnapshot snapshot) {
      _id = "revenue" + snapshot.documents.length.toString();
    });
  }

  double get value3 => _value3;

  set value3(double value) {
    _value3 = value;
  }

  double get value2 => _value2;

  set value2(double value) {
    _value2 = value;
  }

  double get value1 => _value1;

  set value1(double value) {
    _value1 = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}