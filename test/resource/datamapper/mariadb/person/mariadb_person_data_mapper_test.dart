import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/person/person.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/person/mariadb_person_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/person/abstract_person_dto.dart';
import 'package:portal_eclb/transferency/dto/person/default_person_dto.dart';

void main() {

  group("MariaDBPersonDataMapperTest",() {

    test("testGenerateInsertStatement", () {
      Person dto = new DefaultPersonDTO(name: "Pessoa Teste");

      MariaDBPersonDataMapper dataMapper = new MariaDBPersonDataMapper();

      List statement = dataMapper.generateInsertStatement(dto);

      expect(statement.length, equals(2));
      expect(statement[0], equals("INSERT INTO PERSONS (NAME) VALUES (?)"));
      expect(statement[1][0], equals("Pessoa Teste"));

    });

  });

}