import 'package:portal_eclb/model/patrimony/media/type_of_media.dart';

final class TypeOfMediaDTO implements TypeOfMedia {

  int? _id;

  String? _description;

  TypeOfMediaDTO({int? id, String? description}) {
    this._id = id;
    this._description = description!;
  }

  String? get description => this._description;

  void set description(String? value) {
    this._description = value;
  }

  int? get id => this._id;


  void set id(int? id) {
    this._id = id;
  }
}