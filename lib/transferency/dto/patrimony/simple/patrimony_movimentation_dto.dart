import 'package:portal_eclb/model/patrimony/simple/patrimony_movimentation.dart';

final class PatrimonyMovimentationDTO implements PatrimonyMovimentation {

  int? _id;
  DateTime? _date;
  String? _origin;
  String? _destination;
  String? _description;
  int? _simplePatrimonyId;

  PatrimonyMovimentationDTO({
    int? id,
    DateTime? date,
    String? origin,
    String? destination,
    String? description,
    int? simplePatrimonyId,
  }) {
    this._id = id;
    this._date = date;
    this._origin = origin;
    this._destination = destination;
    this._description = description;
    this._simplePatrimonyId = simplePatrimonyId;
  }

  @override
  int? get id => this._id;

  @override
  set id(int? value) {
    this._id = value;
  }

  @override
  DateTime? get date => this._date;

  @override
  set date(DateTime? value) {
    this._date = value;
  }

  @override
  String? get origin => this._origin;

  @override
  set origin(String? value) {
    this._origin = value;
  }

  @override
  String? get destination => this._destination;

  @override
  set destination(String? value) {
    this._destination = value;
  }

  @override
  String? get description => this._description;

  @override
  set description(String? value) {
    this._description = value;
  }

  @override
  int? get simplePatrimonyId => this._simplePatrimonyId;

  @override
  set simplePatrimonyId(int? value) {
    this._simplePatrimonyId = value;
  }
}
