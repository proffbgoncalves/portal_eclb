import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/media/media_dto.dart';

void main() {
  group('MediaDTOTests', () {
    test('Testando criar MediaDTO com os parâmetros', () {
      final mediaDto = MediaDTO(
        id: 1,
        name: 'Imagem de um patrimônio',
        description: 'aqui é a descricao da media de exemplo.',
        file: [0, 1, 2, 3, 4],
        extension: 'jpg',
        patrimonyId: 101,
        typesOfMediaId: 202,
      );

      expect(mediaDto.id, 1);
      expect(mediaDto.name, 'Imagem de um patrimônio');
      expect(mediaDto.description, 'aqui é a descricao da media de exemplo.');
      expect(mediaDto.file, [0, 1, 2, 3, 4]);
      expect(mediaDto.extension, 'jpg');
      expect(mediaDto.patrimonyId, 101);
      expect(mediaDto.typesOfMediaId, 202);
    });

    test('Testando criar MediaDTO com os atributos', () {
      final mediaDto = MediaDTO();

      mediaDto.id = 2;
      mediaDto.name = 'Nome da Media atulizado';
      mediaDto.description = 'atualizei a descricao da imagem nesse texto.';
      mediaDto.file = [5, 6, 7, 8, 9];
      mediaDto.extension = 'png';
      mediaDto.patrimonyId = 202;
      mediaDto.typesOfMediaId = 303;

      expect(mediaDto.id, 2);
      expect(mediaDto.name, 'Nome da Media atulizado');
      expect(mediaDto.description, 'atualizei a descricao da imagem nesse texto.');
      expect(mediaDto.file, [5, 6, 7, 8, 9]);
      expect(mediaDto.extension, 'png');
      expect(mediaDto.patrimonyId, 202);
      expect(mediaDto.typesOfMediaId, 303);
    });

    test('Testando os valores nulls', () {
      final mediaDto = MediaDTO();

      expect(mediaDto.id, isNull);
      expect(mediaDto.name, isNull);
      expect(mediaDto.description, isNull);
      expect(mediaDto.file, isNull);
      expect(mediaDto.extension, isNull);
      expect(mediaDto.patrimonyId, isNull);
      expect(mediaDto.typesOfMediaId, isNull);
    });
  });
}
