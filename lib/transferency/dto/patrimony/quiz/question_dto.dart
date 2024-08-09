import 'package:portal_eclb/model/patrimony/quiz/question.dart';

class QuestionDTO implements Question {
  int? _questionID;
  String? _enunciation;
  int? _quizId;

  QuestionDTO({
    int? questionID,
    String? enunciation,
    int? quizId,
  })  : _questionID = questionID,
        _enunciation = enunciation,
        _quizId = quizId;

  @override
  int? get questionID => _questionID;

  @override
  set questionID(int? questionID) {
    _questionID = questionID;
  }

  @override
  String? get enunciation => _enunciation;

  @override
  set enunciation(String? enunciation) {
    _enunciation = enunciation;
  }

  @override
  int? get quizId => _quizId;

  @override
  set quizId(int? quizId) {
    _quizId = quizId;
  }
}
