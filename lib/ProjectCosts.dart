import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectCosts{
  String _id;
  double _fixedCost;
  double _variableCost;
  double _fCost;
  double _eqCost;
  double _rCost;

  ProjectCosts(this._fixedCost, this._variableCost, this._fCost, this._eqCost,
      this._rCost){
    setCurrentCosts();
  }

  setCurrentCosts() async{
    var userRef = Firestore.instance.collection('costs');
    await userRef.getDocuments().then((QuerySnapshot snapshot) {
      _id = "costs" + snapshot.documents.length.toString();
    });
  }

  double get rCost => _rCost;

  set rCost(double value) {
    _rCost = value;
  }

  double get eqCost => _eqCost;

  set eqCost(double value) {
    _eqCost = value;
  }

  double get fCost => _fCost;

  set fCost(double value) {
    _fCost = value;
  }

  double get variableCost => _variableCost;

  set variableCost(double value) {
    _variableCost = value;
  }

  double get fixedCost => _fixedCost;

  set fixedCost(double value) {
    _fixedCost = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}