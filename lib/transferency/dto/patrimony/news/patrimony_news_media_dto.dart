import 'package:portal_eclb/model/patrimony/news/patrimony_news_media.dart';

final class PatrimonyNewsMediaDTO implements PatrimonyNewsMedia{

  String? _description;

  int? _id;

  PatrimonyNewsMediaDTO({int? id, String? description}){
    this._id;
    this._description;
  }

  int? get id => this._id;

  void set id(int? value) {
    this._id = value;
  }

  String? get description => this._description;

  void set description(String? value) {
    this._description = value;
  }

}