import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/news/patrimony_news_dto.dart';

void main() {
  group('PatrimonyNewsDTO', () {
    test('testando os valores dos parametros', () {
      final dto = PatrimonyNewsDTO(
        id: 1,
        title: 'Titulo 1',
        description: 'descricao exemplo',
        patrimonyId: 100,
        typeOfPatrimonyNewsId: 200,
      );

      expect(dto.id, 1);
      expect(dto.title, 'Titulo 1');
      expect(dto.description, 'descricao exemplo');
      expect(dto.patrimonyId, 100);
      expect(dto.typeOfPatrimonyNewsId, 200);
    });

    test('teste atualizando propriedades com setters', () {
      final dto = PatrimonyNewsDTO();

      dto.id = 1;
      dto.title = 'Titulo 2';
      dto.description = 'descricao aqui';
      dto.patrimonyId = 100;
      dto.typeOfPatrimonyNewsId = 200;

      expect(dto.id, 1);
      expect(dto.title, 'Titulo 2');
      expect(dto.description, 'descricao aqui');
      expect(dto.patrimonyId, 100);
      expect(dto.typeOfPatrimonyNewsId, 200);
    });

    test('teste com valores null', () {
      final dto = PatrimonyNewsDTO();

      dto.id = null;
      dto.title = null;
      dto.description = null;
      dto.patrimonyId = null;
      dto.typeOfPatrimonyNewsId = null;

      expect(dto.id, isNull);
      expect(dto.title, isNull);
      expect(dto.description, isNull);
      expect(dto.patrimonyId, isNull);
      expect(dto.typeOfPatrimonyNewsId, isNull);
    });
  });
}
