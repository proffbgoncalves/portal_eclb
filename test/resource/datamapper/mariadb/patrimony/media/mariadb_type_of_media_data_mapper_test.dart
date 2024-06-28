import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/patrimony/media/type_of_media.dart';

import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/media/mariadb_type_of_media_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/type_of_media_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/media/type_of_media_dto.dart';
void main() {

  group("MariaDBTypeOfPatrimimonyDataMapper", () {

    test("testGenerateInsertStatement", () {
      TypeOfMedia dto = new TypeOfMediaDTO(description: "Intangível");

      TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();

      List statement = dataMapper.generateInsertStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("INSERT INTO TYPESOFMEDIAS (DESCRIPTION) VALUES (?)"));
      expect(statement[1][0], equals("Intangível"));
    });

    test("testGenerateDeleteStatement", () {
      TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();

      List statement = dataMapper.generateDeleteStatement(1);

      expect(statement.length, equals(2));
      expect(statement[0], equals("DELETE FROM TYPESOFMEDIAS WHERE ID = ?"));
      expect(statement[1][0], equals(1));
    });

    test("testGenerateUpdateStatement", () {
      TypeOfMedia dto = new TypeOfMediaDTO(id: 10, description: "Histórico");

      TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();

      List statement = dataMapper.generateUpdateStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("UPDATE TYPESOFMEDIAS SET DESCRIPTION = ? WHERE ID = ?"));
      expect(statement[1][0], equals("Histórico"));
      expect(statement[1][1], equals(10));
    });

    test("testGenerateFindAllStatement", () {

      TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();

      List statement = dataMapper.generateFindAllStatement();

      expect(statement.length, equals(1));
      expect(statement[0], equals("SELECT * FROM TYPESOFMEDIAS"));

      statement = dataMapper.generateFindAllStatement(10, 2);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM TYPESOFMEDIAS LIMIT ? OFFSET ?"));
      expect(statement[1][0], equals(10));
      expect(statement[1][1], equals(2));

    });

    test("testGenerateFindByIdStatement", () {

      TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();

      List statement = dataMapper.generateFindByIdStatement(100);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM TYPESOFMEDIAS WHERE ID = ?"));
      expect(statement[1][0], equals(100));

    });

    test("testGenerateFindByDescriptionStatement", () {

      TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();

      List statement = dataMapper.generateFindByDescriptionStatement("Natural");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM TYPESOFMEDIAS WHERE DESCRIPTION = ?"));
      expect(statement[1][0], equals("Natural"));

    });

  });
}