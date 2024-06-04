import 'package:portal_eclb/model/patrimony/patrimony.dart';

final class PatrimonyDTO implements Patrimony {

  int? _id;
  String? _name;
  String? _country;
  String? _description;
  int? _unescoClassification;
  int? _typeOfPatrimonyId;
  int? _compositePatrimonyId;
  int? _hasLocation;
  String? _state;
  String? _city;
  String? _district;
  String? _address;
  int? _postalCode;
  double? _longitude;
  double? _latitude;
  double? _altitude;

  PatrimonyDTO({int? id, String? name, String? country, String? description,
    int? unescoClassification, int? typeOfPatrimonyId, int? compositePatrimonyId,
    int? hasLocation, String? state, String? city, String? district,
    String? address, int? postalCode, double? longitude, double? latitude,
    double? altitude}) {

    this._id = id;
    this._name = name;
    this._country = country;
    this._description = description;
    this._unescoClassification = unescoClassification;
    this._typeOfPatrimonyId = typeOfPatrimonyId;
    this._compositePatrimonyId = compositePatrimonyId;
    this._hasLocation = hasLocation;
    this._state = state;
    this._city = city;
    this._district = district;
    this._address = address;
    this._postalCode = postalCode;
    this._longitude = longitude;
    this._latitude = latitude;
    this._altitude = altitude;
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

  double? get altitude => _altitude;

  set altitude(double? value) {
    _altitude = value;
  }

  double? get latitude => _latitude;

  set latitude(double? value) {
    _latitude = value;
  }

  double? get longitude => _longitude;

  set longitude(double? value) {
    _longitude = value;
  }

  int? get postalCode => _postalCode;

  set postalCode(int? value) {
    _postalCode = value;
  }

  String? get address => _address;

  set address(String? value) {
    _address = value;
  }

  String? get district => _district;

  set district(String? value) {
    _district = value;
  }

  String? get city => _city;

  set city(String? value) {
    _city = value;
  }

  String? get state => _state;

  set state(String? value) {
    _state = value;
  }

  int? get hasLocation => _hasLocation;

  set hasLocation(int? value) {
    _hasLocation = value;
  }

  int? get compositePatrimonyId => _compositePatrimonyId;

  set compositePatrimonyId(int? value) {
    _compositePatrimonyId = value;
  }
}