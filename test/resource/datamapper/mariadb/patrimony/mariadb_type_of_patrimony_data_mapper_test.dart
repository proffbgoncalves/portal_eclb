import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/type_of_patrimony_dto.dart';

void main() {

  group("MariaDBTypeOfPatrimimonyDataMapper", () {

    test("testGenerateInsertStatement", () {
      TypeOfPatrimony dto = new TypeOfPatrimonyDTO(description: "Intangível");

      TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();

      List statement = dataMapper.generateInsertStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)"));
      expect(statement[1][0], equals("Intangível"));
    });

    test("testGenerateDeleteStatement", () {
      TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();

      List statement = dataMapper.generateDeleteStatement(1);

      expect(statement.length, equals(2));
      expect(statement[0], equals("DELETE FROM TYPESOFPATRIMONIES WHERE ID = ?"));
      expect(statement[1][0], equals(1));
    });

    test("testGenerateUpdateStatement", () {
      TypeOfPatrimony dto = new TypeOfPatrimonyDTO(id: 10, description: "Histórico");

      TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();

      List statement = dataMapper.generateUpdateStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("UPDATE TYPESOFPATRIMONIES SET DESCRIPTION = ? WHERE ID = ?"));
      expect(statement[1][0], equals("Histórico"));
      expect(statement[1][1], equals(10));
    });

    test("testGenerateFindAllStatement", () {

      TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();

      List statement = dataMapper.generateFindAllStatement();

      expect(statement.length, equals(1));
      expect(statement[0], equals("SELECT * FROM TYPESOFPATRIMONIES"));

      statement = dataMapper.generateFindAllStatement(10, 2);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM TYPESOFPATRIMONIES LIMIT ? OFFSET ?"));
      expect(statement[1][0], equals(10));
      expect(statement[1][1], equals(2));

    });

    test("testGenerateFindByIdStatement", () {

      TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();

      List statement = dataMapper.generateFindByIdStatement(100);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM TYPESOFPATRIMONIES WHERE ID = ?"));
      expect(statement[1][0], equals(100));

    });

    test("testGenerateFindByDescriptionStatement", () {

      TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();

      List statement = dataMapper.generateFindByDescriptionStatement("Natural");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM TYPESOFPATRIMONIES WHERE DESCRIPTION = ?"));
      expect(statement[1][0], equals("Natural"));

    });

  });
}