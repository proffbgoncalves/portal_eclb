import 'package:portal_eclb/model/person/visitor/visitor.dart';

abstract class AbstractVisitorDTO implements Visitor{
  //mesmo código do visitorDTO
  int? _personId;
  String? _address;
  int? _number;
  String? _complemento;
  String? _district;
  String? _city;
  String? _state;
  String? _postalCode;
  String? _phone;
  String? _email;
  int? _memoryId;

  AbstractVisitorDTO({int? personId,
    String? address,
    int? number,
    String? complemento,
    String? district,
    String? city,
    String? state,
    String? postalCode,
    String? phone,
    String? email,
    int? memoryId,

  }):
        _personId = personId,
        _address = address,
        _number = number,
        _complemento = complemento,
        _district = district,
        _city = city,
        _state = state,
        _postalCode = postalCode,
        _phone = phone,
        _email = email,
        _memoryId = memoryId;



  int? get memoryId => _memoryId;
  set memoryId(int? value) {
    _memoryId = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
  }

  String? get postalCode => _postalCode;

  set postalCode(String? value) {
    _postalCode = value;
  }

  String? get state => _state;

  set state(String? value) {
    _state = value;
  }

  String? get city => _city;

  set city(String? value) {
    _city = value;
  }

  String? get district => _district;

  set district(String? value) {
    _district = value;
  }

  String? get complemento => _complemento;

  set complemento(String? value) {
    _complemento = value;
  }

  int? get number => _number;

  set number(int? value) {
    _number = value;
  }

  String? get address => _address;

  set address(String? value) {
    _address = value;
  }

  int? get personId => _personId;

  set personId(int? value) {
    _personId = value;
  }
}