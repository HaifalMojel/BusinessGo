
import 'package:cloud_firestore/cloud_firestore.dart';

class Project{
  String _projectID;
  String _projectName;
  double _capital;
  String _industry;
  String _projectOwnerID;
  bool _isFavourite;
  String _locationID;
  String _revenueID;
  String _projectCostsID;
  double _minSpace;
  double _maxSpace;
  double _space;
  static int currentProjectID = 0;

  Project(String name, double capital, String industry, String owner_id){
    _projectName = name;
    this._capital = capital;
    this._industry = industry;
    this._projectOwnerID = owner_id;
    setCurrentProjectID();
    _isFavourite = false;
    _locationID = '';
    _revenueID = '';
  }

  setCurrentProjectID() async{
    var userRef = Firestore.instance.collection('project');
    await userRef.getDocuments().then((QuerySnapshot snapshot) {
      projectID = "project" + snapshot.documents.length.toString();
    });
  }


  double get space => _space;

  set space(double value) {
    _space = value;
  }

  double get minSpace => _minSpace;

  set minSpace(double value) {
    _minSpace = value;
  }

  String get revenueID => _revenueID;

  set revenueID(String value) {
    _revenueID = value;
  }

  String get locationID => _locationID;

  set locationID(String value) {
    _locationID = value;
  }

  bool get isFavourite => _isFavourite;

  set isFavourite(bool value) {
    _isFavourite = value;
  }

  String get projectOwnerID => _projectOwnerID;

  set projectOwnerID(String value) {
    _projectOwnerID = value;
  }

  String get industry => _industry;

  set industry(String value) {
    _industry = value;
  }

  double get capital => _capital;

  set capital(double value) {
    _capital = value;
  }

  String get projectName => _projectName;

  set projectName(String value) {
    _projectName = value;
  }

  String get projectID => _projectID;

  set projectID(String value) {
    _projectID = value;
  }

  String get projectCostsID => _projectCostsID;

  set projectCostsID(String value) {
    _projectCostsID = value;
  }

  double get maxSpace => _maxSpace;

  set maxSpace(double value) {
    _maxSpace = value;
  }
}

