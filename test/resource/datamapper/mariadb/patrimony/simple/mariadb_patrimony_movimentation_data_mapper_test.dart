import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/patrimony/simple/patrimony_movimentation.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/simple/mariadb_patrimony_movimentation_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/simple/patrimony_movimentation_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/simple/patrimony_movimentation_dto.dart';

void main() {

  group("MariaDBPatrimonyMovimentationDataMapper", () {

    test("testGenerateInsertStatement", () {
      PatrimonyMovimentation dto = new PatrimonyMovimentationDTO(
          date: DateTime.parse("2024-08-10T00:00:00.000Z"),
          origin: "Origem Exemplo",
          destination: "Destino Exemplo",
          description: "Descrição do movimentação",
          simplePatrimonyId: 123
      );

      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateInsertStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("INSERT INTO PATRIMONYMOVIMENTATION (DATE, ORIGIN, DESTINATION, DESCRIPTION, SIMPLEPATRIMONYID) VALUES (?, ?, ?, ?, ?)"));
      expect(statement[1][0], equals("2024-08-10T00:00:00.000Z")); // Ajustado para incluir 'Z'
      expect(statement[1][1], equals("Origem Exemplo"));
      expect(statement[1][2], equals("Destino Exemplo"));
      expect(statement[1][3], equals("Descrição do movimentação"));
      expect(statement[1][4], equals(123));
    });

    test("testGenerateDeleteStatement", () {
      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateDeleteStatement(1);

      expect(statement.length, equals(2));
      expect(statement[0], equals("DELETE FROM PATRIMONYMOVIMENTATION WHERE ID = ?"));
      expect(statement[1][0], equals(1));
    });

    test("testGenerateUpdateStatement", () {
      PatrimonyMovimentation dto = new PatrimonyMovimentationDTO(
          id: 10,
          date: DateTime.parse("2024-08-10T00:00:00.000Z"),
          origin: "Origem Atualizada",
          destination: "Destino Atualizado",
          description: "Descrição atualizada do movimentação",
          simplePatrimonyId: 123
      );

      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateUpdateStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("UPDATE PATRIMONYMOVIMENTATION SET DATE = ?, ORIGIN = ?, DESTINATION = ?, DESCRIPTION = ?, SIMPLEPATRIMONYID = ? WHERE ID = ?"));
      expect(statement[1][0], equals("2024-08-10T00:00:00.000Z")); // Ajustado para incluir 'Z'
      expect(statement[1][1], equals("Origem Atualizada"));
      expect(statement[1][2], equals("Destino Atualizado"));
      expect(statement[1][3], equals("Descrição atualizada do movimentação"));
      expect(statement[1][4], equals(123));
      expect(statement[1][5], equals(10));
    });

    test("testGenerateFindAllStatement", () {
      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateFindAllStatement();

      expect(statement.length, equals(1));
      expect(statement[0], equals("SELECT * FROM PATRIMONYMOVIMENTATION"));

      statement = dataMapper.generateFindAllStatement(10, 2);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYMOVIMENTATION LIMIT ? OFFSET ?"));
      expect(statement[1][0], equals(10));
      expect(statement[1][1], equals(2));
    });

    test("testGenerateFindByIdStatement", () {
      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateFindByIdStatement(100);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYMOVIMENTATION WHERE ID = ?"));
      expect(statement[1][0], equals(100));
    });

    test("testGenerateFindAllByDateStatement", () {
      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateFindAllByDateStatement(DateTime.parse("2024-08-10T00:00:00.000Z"));

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYMOVIMENTATION WHERE DATE = ?"));
      expect(statement[1][0], equals("2024-08-10T00:00:00.000Z")); // Ajustado para incluir 'Z'
    });

    test("testGenerateFindAllByOriginStatement", () {
      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateFindAllByOriginStatement("Origem Exemplo");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYMOVIMENTATION WHERE ORIGIN = ?"));
      expect(statement[1][0], equals("Origem Exemplo"));
    });

    test("testGenerateFindAllByDestinationStatement", () {
      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateFindAllByDestinationStatement("Destino Exemplo");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYMOVIMENTATION WHERE DESTINATION = ?"));
      expect(statement[1][0], equals("Destino Exemplo"));
    });

    test("testGenerateFindAllByDescriptionStatement", () {
      PatrimonyMovimentationDataMapper dataMapper = new MariaDBPatrimonyMovimentationDataMapper();

      List statement = dataMapper.generateFindAllByDescriptionStatement("Descrição do movimentação");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYMOVIMENTATION WHERE DESCRIPTION = ?"));
      expect(statement[1][0], equals("Descrição do movimentação"));
    });

  });
}