
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/event/mariadb_type_of_event_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/event/type_of_event_dto.dart';

void main() {
  
  group("MariaDBTypeOfEventDataMapperTest", () {

    test("testGenerateInsertStatement", () {
      MariaDBTypeOfEventDataMapper dataMapper = new MariaDBTypeOfEventDataMapper();

      TypeOfEventDTO dto = new TypeOfEventDTO(description: "Formatura");
      List statement  = dataMapper.generateInsertStatement(dto);

      expect(statement[0], equals("INSERT INTO TYPESOFEVENTS (DESCRIPTION) VALUES (?)"));

      List sqlParams = statement[1];
      expect(sqlParams[0], equals("Formatura"));

      dto = new TypeOfEventDTO();

      try {
        dataMapper.generateInsertStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      } catch (error) {
        expect(error.toString().contains("O atributo description não pode ser nulo."), isTrue);
      }

      dto = new TypeOfEventDTO(description: "");

      try {
        dataMapper.generateInsertStatement(dto);
        fail("Falha ao testar DTO com atributo vazio.");
      } catch (error) {
        expect(error.toString().contains("O atributo description não pode ser vazio."), isTrue);
      }
    });

    test("testDeleteGenerateStatement", () {
      MariaDBTypeOfEventDataMapper dataMapper = new MariaDBTypeOfEventDataMapper();

      int id = 15;

      List statement = dataMapper.generateDeleteStatement(id);

      expect(statement[0], equals("DELETE FROM TYPESOFEVENTS WHERE ID = ?"));

      List sqlParams = statement[1];

      expect(sqlParams[0], equals(15));

      try {
        dataMapper.generateDeleteStatement("10");
        fail("Falhou ao testar id como string");
      } catch (error) {
        expect(error.toString().contains("Parâmetro id não é um int."), isTrue);
      }
    });


  });
  
}