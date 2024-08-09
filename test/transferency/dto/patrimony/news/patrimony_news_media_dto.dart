import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/news/patrimony_news_media_dto.dart';

void main () {

  group("PatrimonyNewsMediaDTOTest", (){

    test("TestCriarNovaMidiaDePatrimonioSemValor", (){
      final patrimonynewsmedia = PatrimonyNewsMediaDTO();
      expect(patrimonynewsmedia.id, isNull);
      expect(patrimonynewsmedia.description, isNull);
    });

    test('testCriarNovaMidiaDePatrimoniocomValor', () {

      final patrimonynewsmedia = PatrimonyNewsMediaDTO();
      patrimonynewsmedia.id = 8;
      expect(patrimonynewsmedia.id, 8);

    });

    test('testGetterAndSetterForIDAtribute', () {

      final patrimonynewsmedia = PatrimonyNewsMediaDTO();
      patrimonynewsmedia.id = 8;
      expect(patrimonynewsmedia.id, 8);
    });

    test('testGetterAndSetterForDescriptionAtribute', () {
      final patrimonynewsmedia = PatrimonyNewsMediaDTO();
      patrimonynewsmedia.description = 'Reunião';
      expect(patrimonynewsmedia.description, 'Reunião');
    });

  });
}