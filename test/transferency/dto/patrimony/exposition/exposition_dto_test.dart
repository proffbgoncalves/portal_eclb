import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/exposition/exposition_dto.dart';



void main() {
  group('ExpositionDTOTest', () {
    // Teste para verificar a criação do objeto com valores iniciais nulos.
    test('testCreateExpositionDTOWithNullValues', () {
      // Criação do objeto sem parâmetros.
      final expositionDTO = ExpositionDTO();

      // Verificação se os valores iniciais são nulos.
      expect(expositionDTO.id, isNull);
      expect(expositionDTO.name, isNull);
      expect(expositionDTO.description, isNull);
    });

    // Teste para verificar a criação do objeto com valores iniciais definidos.
    test('testCreateExpositionDTOWithValues', () {
      // Criação do objeto com valores iniciais.
      final expositionDTO = ExpositionDTO(id: 1, name: 'Art Exhibit', description: 'An exhibition of modern art');

      // Verificação se os valores iniciais foram definidos corretamente.
      expect(expositionDTO.id, 1);
      expect(expositionDTO.name, 'Art Exhibit');
      expect(expositionDTO.description, 'An exhibition of modern art');
    });

    // Teste para verificar a definição do atributo id.
    test('testGetterAndSetterForId', () {
      // Criação do objeto.
      final expositionDTO = ExpositionDTO();

      // Definição do valor do atributo id.
      expositionDTO.id = 10;

      // Verificação se o valor foi definido corretamente.
      expect(expositionDTO.id, 10);
    });

    // Teste para verificar a definição do atributo name.
    test('testGetterAndSetterForName', () {
      // Criação do objeto.
      final expositionDTO = ExpositionDTO();

      // Definição do valor do atributo name.
      expositionDTO.name = 'Art Exhibit';

      // Verificação se o valor foi definido corretamente.
      expect(expositionDTO.name, 'Art Exhibit');
    });

    // Teste para verificar a definição do atributo description.
    test('testGetterAndSetterForDescription', () {
      // Criação do objeto.
      final expositionDTO = ExpositionDTO();

      // Definição do valor do atributo description.
      expositionDTO.description = 'An exhibition of modern art';

      // Verificação se o valor foi definido corretamente.
      expect(expositionDTO.description, 'An exhibition of modern art');
    });
  });
}
