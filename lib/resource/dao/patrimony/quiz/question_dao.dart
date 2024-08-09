import 'package:portal_eclb/resource/dao/dao.dart';
import 'package:portal_eclb/model/patrimony/quiz/question.dart';

abstract interface class QuestionDAO implements DAO{
  Future<Question?> QuestionId(int QuestionId);

  Future<List> findAllByEnunciation(String enunciation);

  Future<List> findAllQuizId(String quizid);

   findByEnunciation(String enunciation);
}
