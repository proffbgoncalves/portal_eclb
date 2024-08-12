import 'package:portal_eclb/model/patrimony/media/media.dart';

final class MediaDTO implements Media {

  int? _id;
  String? _name;
  String? _description;
  List<int>? _file;
  String? _extension;
  int? _patrimonyId;
  int? _typesOfMediaId;

  MediaDTO({
    int? id,
    String? name,
    String? description,
    List<int>? file,
    String? extension,
    int? patrimonyId,
    int? typesOfMediaId,
  }) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._file = file;
    this._extension = extension;
    this._patrimonyId = patrimonyId;
    this._typesOfMediaId = typesOfMediaId;
  }

  @override
  int? get id => this._id;

  @override
  set id(int? value) {
    this._id = value;
  }

  @override
  String? get name => this._name;

  @override
  set name(String? value) {
    this._name = value;
  }

  @override
  String? get description => this._description;

  @override
  set description(String? value) {
    this._description = value;
  }

  @override
  List<int>? get file => this._file;

  @override
  set file(List<int>? value) {
    this._file = value;
  }

  @override
  String? get extension => this._extension;

  @override
  set extension(String? value) {
    this._extension = value;
  }

  @override
  int? get patrimonyId => this._patrimonyId;

  @override
  set patrimonyId(int? value) {
    this._patrimonyId = value;
  }

  @override
  int? get typesOfMediaId => this._typesOfMediaId;

  @override
  set typesOfMediaId(int? value) {
    this._typesOfMediaId = value;
  }
}
