import 'package:portal_eclb/model/patrimony/news/patrimony_news.dart';

final class PatrimonyNewsDTO implements PatrimonyNews {

  int? _id;

  String? _title;

  String? _description;

  int? _patrimonyId;

  int? _typeOfPatrimonyNewsId;

  PatrimonyNewsDTO({
    int? id,
    String? title,
    String? description,
    int? patrimonyId,
    int? typeOfPatrimonyNewsId,
  }) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._patrimonyId = patrimonyId;
    this._typeOfPatrimonyNewsId = typeOfPatrimonyNewsId;
  }

  int? get id => this._id;

  set id(int? value) {
    this._id = value;
  }

  String? get title => this._title;

  set title(String? value) {
    this._title = value;
  }

  String? get description => this._description;

  set description(String? value) {
    this._description = value;
  }

  int? get patrimonyId => this._patrimonyId;

  set patrimonyId(int? value) {
    this._patrimonyId = value;
  }

  int? get typeOfPatrimonyNewsId => this._typeOfPatrimonyNewsId;

  set typeOfPatrimonyNewsId(int? value) {
    this._typeOfPatrimonyNewsId = value;
  }
}
