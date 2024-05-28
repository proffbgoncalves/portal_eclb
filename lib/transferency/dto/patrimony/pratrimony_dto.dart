import 'package:portal_eclb/model/patrimony/patrimony.dart';

final class PatrimonyDTO implements Patrimony {

  int? _id;
  String? _name;
  String? _country;
  String? _description;
  int? _unescoClassification;
  int? _typeOfPatrimonyId;

  PatrimonyDTO({int? id, String? name, String? country, String? description, int? unescoClassification, int? typeOfPatrimonyId}) {
    this._id = id;
    this._name = name;
    this._country = country;
    this._description = description;
    this._unescoClassification = unescoClassification;
    this._typeOfPatrimonyId = typeOfPatrimonyId;
  }

  int? get typeOfPatrimonyId => _typeOfPatrimonyId;

  set typeOfPatrimonyId(int? value) {
    _typeOfPatrimonyId = value;
  }

  int? get unescoClassification => _unescoClassification;

  set unescoClassification(int? value) {
    _unescoClassification = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  String? get country => _country;

  set country(String? value) {
    _country = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}