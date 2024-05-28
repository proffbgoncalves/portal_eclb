import 'package:portal_eclb/model/person/person.dart';

abstract class AbstactPersonDTO implements Person {

  int? _id;
  String? _name;

  AbstactPersonDTO({int? id, String? name}) {
    this._id = id;
    this._name = name;
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