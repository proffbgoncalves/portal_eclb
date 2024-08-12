import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/patrimony/news/patrimony_news.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/news/mariadb_patrimony_news_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/news/patrimony_news_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/news/patrimony_news_dto.dart';

void main() {

  group("MariaDBPatrimonyNewsDataMapper", () {

    test("testGenerateInsertStatement", () {
      PatrimonyNews dto = new PatrimonyNewsDTO(
          title: "Breaking News",
          description: "Description of the news",
          patrimonyId: 1,
          typeOfPatrimonyNewsId: 2
      );

      PatrimonyNewsDataMapper dataMapper = new MariaDBPatrimonyNewsDataMapper();

      List statement = dataMapper.generateInsertStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("INSERT INTO PATRIMONYNEWS (TITLE, DESCRIPTION, PATRIMONYID, TYPEOFPATRIMONYNEWSID) VALUES (?, ?, ?, ?)"));
      expect(statement[1], equals(["Breaking News", "Description of the news", 1, 2]));
    });

    test("testGenerateDeleteStatement", () {
      PatrimonyNewsDataMapper dataMapper = new MariaDBPatrimonyNewsDataMapper();

      List statement = dataMapper.generateDeleteStatement(1);

      expect(statement.length, equals(2));
      expect(statement[0], equals("DELETE FROM PATRIMONYNEWS WHERE ID = ?"));
      expect(statement[1][0], equals(1));
    });

    test("testGenerateUpdateStatement", () {
      PatrimonyNews dto = new PatrimonyNewsDTO(
          id: 10,
          title: "Updated News",
          description: "Updated description",
          patrimonyId: 3,
          typeOfPatrimonyNewsId: 4
      );

      PatrimonyNewsDataMapper dataMapper = new MariaDBPatrimonyNewsDataMapper();

      List statement = dataMapper.generateUpdateStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("UPDATE PATRIMONYNEWS SET TITLE = ?, DESCRIPTION = ?, PATRIMONYID = ?, TYPEOFPATRIMONYNEWSID = ? WHERE ID = ?"));
      expect(statement[1], equals(["Updated News", "Updated description", 3, 4, 10]));
    });

    test("testGenerateFindAllStatement", () {

      PatrimonyNewsDataMapper dataMapper = new MariaDBPatrimonyNewsDataMapper();

      List statement = dataMapper.generateFindAllStatement();

      expect(statement.length, equals(1));
      expect(statement[0], equals("SELECT * FROM PATRIMONYNEWS"));

      statement = dataMapper.generateFindAllStatement(10, 2);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYNEWS LIMIT ? OFFSET ?"));
      expect(statement[1][0], equals(10));
      expect(statement[1][1], equals(2));
    });

    test("testGenerateFindByIdStatement", () {

      PatrimonyNewsDataMapper dataMapper = new MariaDBPatrimonyNewsDataMapper();

      List statement = dataMapper.generateFindByIdStatement(100);

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYNEWS WHERE ID = ?"));
      expect(statement[1][0], equals(100));
    });

    test("testGenerateFindByTitleStatement", () {

      PatrimonyNewsDataMapper dataMapper = new MariaDBPatrimonyNewsDataMapper();

      List statement = dataMapper.generateFindByTitleStatement("Important");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYNEWS WHERE TITLE LIKE ?"));
      expect(statement[1][0], equals("%Important%"));
    });

    test("testGenerateFindByDescriptionStatement", () {

      PatrimonyNewsDataMapper dataMapper = new MariaDBPatrimonyNewsDataMapper();

      List statement = dataMapper.generateFindByDescriptionStatement("News");

      expect(statement.length, equals(2));
      expect(statement[0], equals("SELECT * FROM PATRIMONYNEWS WHERE DESCRIPTION LIKE ?"));
      expect(statement[1][0], equals("%News%"));
    });

    test("testGenerateCountStatement", () {

      PatrimonyNewsDataMapper dataMapper = new MariaDBPatrimonyNewsDataMapper();

      List statement = dataMapper.generateCountStatement();

      expect(statement.length, equals(1));
      expect(statement[0], equals("SELECT COUNT(*) FROM PATRIMONYNEWS"));
    });
  });
}
