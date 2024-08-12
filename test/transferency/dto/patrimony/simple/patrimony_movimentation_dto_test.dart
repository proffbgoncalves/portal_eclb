import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/simple/patrimony_movimentation_dto.dart';

void main() {

  group('PatrimonyMovimentationDTOTest', () {

    test('testPatrimonyMovimentationDTO verificando atributos null', () {

      final movimentation = PatrimonyMovimentationDTO();

      expect(movimentation.id, isNull);
      expect(movimentation.date, isNull);
      expect(movimentation.origin, isNull);
      expect(movimentation.destination, isNull);
      expect(movimentation.description, isNull);
      expect(movimentation.simplePatrimonyId, isNull);
    });

    test('testPatrimonyMovimentationDTO', () {

      final movimentation = PatrimonyMovimentationDTO(
        id: 1,
        date: DateTime(2023, 7, 27),
        origin: 'Armazém',
        destination: 'Departamento',
        description: 'Movimentação de equipamentos',
        simplePatrimonyId: 1001,
      );

      expect(movimentation.id, 1);
      expect(movimentation.date, DateTime(2023, 7, 27));
      expect(movimentation.origin, 'Armazém');
      expect(movimentation.destination, 'Departamento');
      expect(movimentation.description, 'Movimentação de equipamentos');
      expect(movimentation.simplePatrimonyId, 1001);
    });

    test('testGetterAndSetterForID', () {

      final movimentation = PatrimonyMovimentationDTO();

      movimentation.id = 10;

      expect(movimentation.id, 10);
    });

    test('testGetterAndSetterForDate', () {

      final movimentation = PatrimonyMovimentationDTO();

      movimentation.date = DateTime(2024, 7, 27);

      expect(movimentation.date, DateTime(2024, 7, 27));
    });

    test('testGetterAndSetterForOrigin', () {

      final movimentation = PatrimonyMovimentationDTO();

      movimentation.origin = 'Almoxarifado';

      expect(movimentation.origin, 'Almoxarifado');
    });

    test('testGetterAndSetterForDestination', () {

      final movimentation = PatrimonyMovimentationDTO();

      movimentation.destination = 'Departamento';

      expect(movimentation.destination, 'Departamento');
    });

    test('testGetterAndSetterForDescription', () {

      final movimentation = PatrimonyMovimentationDTO();

      movimentation.description = 'Reunião';

      expect(movimentation.description, 'Reunião');
    });

    test('testGetterAndSetterForSimplePatrimonyId', () {

      final movimentation = PatrimonyMovimentationDTO();

      movimentation.simplePatrimonyId = 2002;

      expect(movimentation.simplePatrimonyId, 2002);
    });
  });
}
