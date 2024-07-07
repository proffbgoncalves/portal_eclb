import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/event/type_of_event_dto.dart';

void main() {
  ///Cria um grupo de teste.
  group('TypeOfEventDTOTest', () {

    // Teste para verificar a criação do objeto com valores iniciais nulos.
    test('testCreateTypeOfEventDTOWithNullValues', () {
      // Criação do objeto sem parâmetros.
      final evento = TypeOfEventDTO();

      // Verificação se os valores iniciais são nulos.
      expect(evento.id, isNull);
      expect(evento.description, isNull);
    });

    // Teste para verificar a criação do objeto com valores iniciais definidos.
    test('testCreateTypeOfEventDTOWithValue', () {
      // Criação do objeto com valores iniciais.
      final evento = TypeOfEventDTO(id: 1, description: 'Festa');

      // Verificação se os valores iniciais foram definidos corretamente.
      expect(evento.id, 1);
      expect(evento.description, 'Festa');
    });

    // Teste para verificar a definição do atributo id.
    test('testGetterAndSetterForIDAtribute', () {
      // Criação do objeto.
      final evento = TypeOfEventDTO();

      // Definição do valor do atributo id.
      evento.id = 10;

      // Verificação se o valor foi definido corretamente.
      expect(evento.id, 10);
    });

    // Teste para verificar a definição do atributo description.
    test('testGetterAndSetterForDescriptionAtribute', () {
      // Criação do objeto.
      final evento = TypeOfEventDTO();

      // Definição do valor do atributo description.
      evento.description = 'Reunião';

      // Verificação se o valor foi definido corretamente.
      expect(evento.description, 'Reunião');
    });
  });
}
