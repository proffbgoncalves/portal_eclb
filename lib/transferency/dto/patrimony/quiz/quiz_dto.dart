import 'package:portal_eclb/model/patrimony/quiz/quiz_patrimony.dart';

final class QuizDTO implements QuizPatrimony{


  String? _description;


  int? _id;


  QuizDTO({int? id, String? description}) {
    this._id = id;
    this._description = description;
  }

  int? get id => this._id;

   set id(int? value) {
    this._id = value;
  }

  String? get description => this._description;

  set description(String? value) {
    this._description = value;
  }
}