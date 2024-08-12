import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/patrimony/media/media.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/media/mariadb_media_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/media_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/media/media_dto.dart';

void main() {

  group("MariaDBMediaDataMapper", () {

    test("testGenerateInsertStatement", () {
      Media dto = new MediaDTO(
          name: "Arquivo de Imagem",
          description: "Descrição do arquivo de imagem",
          file: null,  // Supondo que o arquivo seja gerenciado de outra forma
          extension: "jpg",
          patrimonyId: 1,
          typesOfMediaId: 2
      );

      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateInsertStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("INSERT INTO MEDIA (NAME, EXTENSION, DESCRIPTION, PATRIMONYID, TYPESOFMEDIAID) VALUES (?, ?, ?, ?, ?)"));
      expect(statement[1][0], equals("Arquivo de Imagem"));
      expect(statement[1][1], equals("jpg"));
      expect(statement[1][2], equals("Descrição do arquivo de imagem"));
      expect(statement[1][3], equals(1));
      expect(statement[1][4], equals(2));
    });

    test("testGenerateDeleteStatement", () {
      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateDeleteStatement(1);

      expect(statement.length, equals(2));
      expect(statement[0], equals("DELETE FROM MEDIA WHERE ID = ?"));
      expect(statement[1][0], equals(1));
    });

    test("testGenerateUpdateStatement", () {
      Media dto = new MediaDTO(
          id: 10,
          name: "Arquivo Atualizado",
          description: "Descrição atualizada do arquivo",
          file: null,
          extension: "png",
          patrimonyId: 1,
          typesOfMediaId: 2
      );

      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateUpdateStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("UPDATE MEDIA SET NAME = ?, EXTENSION = ?, DESCRIPTION = ?, PATRIMONYID = ?, TYPESOFMEDIAID = ? WHERE ID = ?"));
      expect(statement[1][0], equals("Arquivo Atualizado"));
      expect(statement[1][1], equals("png"));
      expect(statement[1][2], equals("Descrição atualizada do arquivo"));
      expect(statement[1][3], equals(1));
      expect(statement[1][4], equals(2));
      expect(statement[1][5], equals(10));
    });

    test("testGenerateFindAllStatement", () {
      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateFindAllStatement();

      expect(statement.length, equals(1));
      expect(statement[0], equals("SELECT * FROM MEDIA"));

      statement = dataMapper.generateFindAllStatement(10, 2);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM MEDIA LIMIT ? OFFSET ?"));
      expect(statement[1][0], equals(10));
      expect(statement[1][1], equals(2));
    });

    test("testGenerateFindByIdStatement", () {
      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateFindByIdStatement(100);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM MEDIA WHERE ID = ?"));
      expect(statement[1][0], equals(100));
    });

    test("testGenerateFindAllByNameStatement", () {
      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateFindAllByNameStatement("Arquivo de Imagem");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM MEDIA WHERE NAME = ?"));
      expect(statement[1][0], equals("Arquivo de Imagem"));
    });

    test("testGenerateFindAllByExtensionStatement", () {
      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateFindAllByExtensionStatement("jpg");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM MEDIA WHERE EXTENSION = ?"));
      expect(statement[1][0], equals("jpg"));
    });

    test("testGenerateFindAllByDescriptionStatement", () {
      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateFindAllByDescriptionStatement("Descrição do arquivo de imagem");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM MEDIA WHERE DESCRIPTION = ?"));
      expect(statement[1][0], equals("Descrição do arquivo de imagem"));
    });

    test("testGenerateFindAllByPatrimonyId", () {
      MediaDataMapper dataMapper = new MariaDBMediaDataMapper();

      List statement = dataMapper.generateFindAllByPatrimonyId(1);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM MEDIA WHERE PATRIMONYID = ?"));
      expect(statement[1][0], equals(1));
    });

  });
}
