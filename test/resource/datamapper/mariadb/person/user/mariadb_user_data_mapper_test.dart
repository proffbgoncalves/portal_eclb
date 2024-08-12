import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/person/user/mariadb_user_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/person/user/user_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/person/user/user_dto.dart';

void main() {

  group("MariaDBUserDataMapper", () {

    test("testGenerateInsertStatement", () {
      UserDTO dto = new UserDTO(
          personId: 1,
          login: "user1",
          password: "pass1",
          function: "admin"
      );

      UserDataMapper dataMapper = new MariaDBUserDataMapper();

      List statement = dataMapper.generateInsertStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("INSERT INTO USERS (PERSONID, LOGIN, PASSWORD, FUNCTION) VALUES (?, ?, ?, ?)"));
      expect(statement[1], equals([1, "user1", "pass1", "admin"]));
    });

    test("testGenerateDeleteStatement", () {
      UserDataMapper dataMapper = new MariaDBUserDataMapper();

      List statement = dataMapper.generateDeleteStatement(1);

      expect(statement.length, equals(2));
      expect(statement[0], equals("DELETE FROM USERS WHERE PERSONID = ?"));
      expect(statement[1][0], equals(1));
    });

    test("testGenerateUpdateStatement", () {
      UserDTO dto = new UserDTO(
          personId: 10,
          login: "user10",
          password: "pass10",
          function: "manager"
      );

      UserDataMapper dataMapper = new MariaDBUserDataMapper();

      List statement = dataMapper.generateUpdateStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("UPDATE USERS SET LOGIN = ?, PASSWORD = ?, FUNCTION = ? WHERE PERSONID = ?"));
      expect(statement[1], equals(["user10", "pass10", "manager", 10]));
    });

    test("testGenerateFindAllStatement", () {
      UserDataMapper dataMapper = new MariaDBUserDataMapper();

      List statement = dataMapper.generateFindAllStatement();

      expect(statement.length, equals(1));
      expect(statement[0], equals("SELECT * FROM USERS"));

      statement = dataMapper.generateFindAllStatement(10, 2);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM USERS LIMIT ? OFFSET ?"));
      expect(statement[1], equals([10, 2]));
    });

    test("testGenerateFindByIdStatement", () {
      UserDataMapper dataMapper = new MariaDBUserDataMapper();

      List statement = dataMapper.generateFindByIdStatement(100);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM USERS WHERE PERSONID = ?"));
      expect(statement[1][0], equals(100));
    });

    test("testGenerateFindByLoginStatement", () {
      UserDataMapper dataMapper = new MariaDBUserDataMapper();

      List statement = dataMapper.generateFindByLoginStatement("user1");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM USERS WHERE LOGIN LIKE ?"));
      expect(statement[1][0], equals("%user1%"));
    });

    test("testGenerateFindByFunctionStatement", () {
      UserDataMapper dataMapper = new MariaDBUserDataMapper();

      List statement = dataMapper.generateFindByFunctionStatement("admin");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM USERS WHERE FUNCTION LIKE ?"));
      expect(statement[1][0], equals("%admin%"));
    });

    test("testGenerateCountStatement", () {
      UserDataMapper dataMapper = new MariaDBUserDataMapper();

      List statement = dataMapper.generateCountStatement();

      expect(statement.length, equals(1));
      expect(statement[0], equals("SELECT COUNT(*) FROM USERS"));
    });

  });
}
