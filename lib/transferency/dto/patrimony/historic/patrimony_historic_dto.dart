import 'package:portal_eclb/model/patrimony/historic/patrimony_historic.dart';

class PatrimonyHistoricDTO implements PatrimonyHistoric {
  int? _id;
  String? _name;
  DateTime? _date;
  String? _narrative;
  int? _patrimonyID;
  int? _typeOfPatrimonyHistoricID;

  PatrimonyHistoricDTO({
    int? id,
    String? name,
    DateTime? date,
    String? narrative,
    int? patrimonyID,
    int? typeOfPatrimonyHistoricID,
  })  : _id = id,
        _name = name,
        _date = date,
        _narrative = narrative,
        _patrimonyID = patrimonyID,
        _typeOfPatrimonyHistoricID = typeOfPatrimonyHistoricID;

  @override
  void set id(int? id) {
    _id = id;
  }

  @override
  int? get id => _id;

  @override
  void set name(String? name) {
    _name = name;
  }

  @override
  String? get name => _name;

  @override
  void set date(DateTime? date) {
    _date = date;
  }

  @override
  DateTime? get date => _date;

  @override
  void set narrative(String? narrative) {
    _narrative = narrative;
  }

  @override
  String? get narrative => _narrative;

  @override
  void set patrimonyID(int? patrimonyID) {
    _patrimonyID = patrimonyID;
  }

  @override
  int? get patrimonyID => _patrimonyID;

  @override
  void set typeOfPatrimonyHistoricID(int? typeOfPatrimonyHistoricID) {
    _typeOfPatrimonyHistoricID = typeOfPatrimonyHistoricID;
  }

  @override
  int? get typeOfPatrimonyHistoricID => _typeOfPatrimonyHistoricID;
}
