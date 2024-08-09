import 'package:portal_eclb/model/patrimony/historic/type_of_patrimony_historic.dart';

final class TypeOfPatrimonyHistoricDTO implements TypeOfPatrimonyHistoric{

  String? _description;

  int? _id;

  TypeOfPatrimonyHistoricDTO({int? id, String? description});

  int? get id => _id;

  void set id(int? value) {
    this._id = value;
  }

  String? get description => _description;

 void set description(String? value) {
    _description = value;
  }
}