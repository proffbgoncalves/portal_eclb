import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/historic/patrimony_historic_dto.dart';
 // Altere o caminho conforme necessário

void main() {
  group('PatrimonyHistoricDTOTest', () {
    // Teste para verificar a criação do objeto com valores iniciais nulos.
    test('testCreatePatrimonyHistoricDTOWithNullValues', () {
      // Criação do objeto sem parâmetros.
      final patrimonyHistoricDTO = PatrimonyHistoricDTO();

      // Verificação se os valores iniciais são nulos.
      expect(patrimonyHistoricDTO.id, isNull);
      expect(patrimonyHistoricDTO.name, isNull);
      expect(patrimonyHistoricDTO.date, isNull);
      expect(patrimonyHistoricDTO.narrative, isNull);
      expect(patrimonyHistoricDTO.patrimonyID, isNull);
      expect(patrimonyHistoricDTO.typeOfPatrimonyHistoricID, isNull);
    });

    // Teste para verificar a criação do objeto com valores iniciais definidos.
    test('testCreatePatrimonyHistoricDTOWithValues', () {
      // Criação do objeto com valores iniciais.
      final patrimonyHistoricDTO = PatrimonyHistoricDTO(
          id: 1,
          name: 'Historical Event',
          date: DateTime(2023, 7, 31),
          narrative: 'Detailed narrative of the event.',
          patrimonyID: 101,
          typeOfPatrimonyHistoricID: 202
      );

      // Verificação se os valores iniciais foram definidos corretamente.
      expect(patrimonyHistoricDTO.id, 1);
      expect(patrimonyHistoricDTO.name, 'Historical Event');
      expect(patrimonyHistoricDTO.date, DateTime(2023, 7, 31));
      expect(patrimonyHistoricDTO.narrative, 'Detailed narrative of the event.');
      expect(patrimonyHistoricDTO.patrimonyID, 101);
      expect(patrimonyHistoricDTO.typeOfPatrimonyHistoricID, 202);
    });

    // Teste para verificar a definição do atributo id.
    test('testGetterAndSetterForId', () {
      // Criação do objeto.
      final patrimonyHistoricDTO = PatrimonyHistoricDTO();

      // Definição do valor do atributo id.
      patrimonyHistoricDTO.id = 10;

      // Verificação se o valor foi definido corretamente.
      expect(patrimonyHistoricDTO.id, 10);
    });

    // Teste para verificar a definição do atributo name.
    test('testGetterAndSetterForName', () {
      // Criação do objeto.
      final patrimonyHistoricDTO = PatrimonyHistoricDTO();

      // Definição do valor do atributo name.
      patrimonyHistoricDTO.name = 'Historical Event';

      // Verificação se o valor foi definido corretamente.
      expect(patrimonyHistoricDTO.name, 'Historical Event');
    });

    // Teste para verificar a definição do atributo date.
    test('testGetterAndSetterForDate', () {
      // Criação do objeto.
      final patrimonyHistoricDTO = PatrimonyHistoricDTO();

      // Definição do valor do atributo date.
      patrimonyHistoricDTO.date = DateTime(2023, 7, 31);

      // Verificação se o valor foi definido corretamente.
      expect(patrimonyHistoricDTO.date, DateTime(2023, 7, 31));
    });

    // Teste para verificar a definição do atributo narrative.
    test('testGetterAndSetterForNarrative', () {
      // Criação do objeto.
      final patrimonyHistoricDTO = PatrimonyHistoricDTO();

      // Definição do valor do atributo narrative.
      patrimonyHistoricDTO.narrative = 'Detailed narrative of the event.';

      // Verificação se o valor foi definido corretamente.
      expect(patrimonyHistoricDTO.narrative, 'Detailed narrative of the event.');
    });

    // Teste para verificar a definição do atributo patrimonyID.
    test('testGetterAndSetterForPatrimonyID', () {
      // Criação do objeto.
      final patrimonyHistoricDTO = PatrimonyHistoricDTO();

      // Definição do valor do atributo patrimonyID.
      patrimonyHistoricDTO.patrimonyID = 101;

      // Verificação se o valor foi definido corretamente.
      expect(patrimonyHistoricDTO.patrimonyID, 101);
    });

    // Teste para verificar a definição do atributo typeOfPatrimonyHistoricID.
    test('testGetterAndSetterForTypeOfPatrimonyHistoricID', () {
      // Criação do objeto.
      final patrimonyHistoricDTO = PatrimonyHistoricDTO();

      // Definição do valor do atributo typeOfPatrimonyHistoricID.
      patrimonyHistoricDTO.typeOfPatrimonyHistoricID = 202;

      // Verificação se o valor foi definido corretamente.
      expect(patrimonyHistoricDTO.typeOfPatrimonyHistoricID, 202);
    });
  });
}
