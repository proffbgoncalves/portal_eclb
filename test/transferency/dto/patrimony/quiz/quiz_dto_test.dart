import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/quiz/quiz_dto.dart';

void main (){

  group('QuizDTOTest', (){

    test("TestCriarUmQuizSemValor", (){
      final quiz = QuizDTO();
      expect(quiz.id, isNull);
      expect(quiz.description, isNull);
    });

    test('testCriarUmQuizcomValor', () {

      final quiz = QuizDTO();
      quiz.id = 8;
      expect(quiz.id, 8);

    });

    test('testGetterAndSetterForIDAtribute', () {

      final quiz = QuizDTO();
      quiz.id = 8;
      expect(quiz.id, 8);
    });

    test('testGetterAndSetterForDescriptionAtribute', () {
      final quiz = QuizDTO();
      quiz.description = 'Pergunta numero 1';
      expect(quiz.description, 'Pergunta numero 1');
    });

  });

}