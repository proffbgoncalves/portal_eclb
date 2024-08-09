import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/quiz/question_dto.dart';
 // Altere o caminho conforme necessário

void main() {
  group('QuestionDTOTest', () {
    // Teste para verificar a criação do objeto com valores iniciais nulos.
    test('testCreateQuestionDTOWithNullValues', () {
      // Criação do objeto sem parâmetros.
      final questionDTO = QuestionDTO();

      // Verificação se os valores iniciais são nulos.
      expect(questionDTO.questionID, isNull);
      expect(questionDTO.enunciation, isNull);
      expect(questionDTO.quizId, isNull);
    });

    // Teste para verificar a criação do objeto com valores iniciais definidos.
    test('testCreateQuestionDTOWithValues', () {
      // Criação do objeto com valores iniciais.
      final questionDTO = QuestionDTO(
        questionID: 1,
        enunciation: 'What is the capital of France?',
        quizId: 10,
      );

      // Verificação se os valores iniciais foram definidos corretamente.
      expect(questionDTO.questionID, 1);
      expect(questionDTO.enunciation, 'What is the capital of France?');
      expect(questionDTO.quizId, 10);
    });

    // Teste para verificar a definição do atributo questionID.
    test('testGetterAndSetterForQuestionID', () {
      // Criação do objeto.
      final questionDTO = QuestionDTO();

      // Definição do valor do atributo questionID.
      questionDTO.questionID = 100;

      // Verificação se o valor foi definido corretamente.
      expect(questionDTO.questionID, 100);
    });

    // Teste para verificar a definição do atributo enunciation.
    test('testGetterAndSetterForEnunciation', () {
      // Criação do objeto.
      final questionDTO = QuestionDTO();

      // Definição do valor do atributo enunciation.
      questionDTO.enunciation = 'Explain the theory of relativity.';

      // Verificação se o valor foi definido corretamente.
      expect(questionDTO.enunciation, 'Explain the theory of relativity.');
    });

    // Teste para verificar a definição do atributo quizId.
    test('testGetterAndSetterForQuizId', () {
      // Criação do objeto.
      final questionDTO = QuestionDTO();

      // Definição do valor do atributo quizId.
      questionDTO.quizId = 202;

      // Verificação se o valor foi definido corretamente.
      expect(questionDTO.quizId, 202);
    });
  });
}
