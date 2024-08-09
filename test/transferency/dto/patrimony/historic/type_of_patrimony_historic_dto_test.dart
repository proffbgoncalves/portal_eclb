import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/historic/type_of_patrimony_historic_dto.dart';

void main (){
  
  group("TypeOfPatrimonyHistoricDTOTest", (){

    test("TestCriandoUmPatrimonioHistoricoSemValor", (){
      final patrimoniohistorico = TypeOfPatrimonyHistoricDTO();
      expect(patrimoniohistorico.id, isNull);
      expect(patrimoniohistorico.description, isNull);
    });

    test('testCriarNovoPatrimonioHistoricocomValor', () {
      final patrimoniohistorico = TypeOfPatrimonyHistoricDTO();
      patrimoniohistorico.id = 2;
      expect(patrimoniohistorico.id, 2);

    });

    test('testGetterAndSetterForIDAtribute', () {
      final patrimoniohistorico = TypeOfPatrimonyHistoricDTO();
      patrimoniohistorico.id = 2;
      expect(patrimoniohistorico.id, 2);
    });

    test('testGetterAndSetterForDescriptionAtribute', () {
      final patrimoniohistorico = TypeOfPatrimonyHistoricDTO();
      patrimoniohistorico.description = 'Mapa';
      expect(patrimoniohistorico.description, 'Mapa');
    });
  });
}