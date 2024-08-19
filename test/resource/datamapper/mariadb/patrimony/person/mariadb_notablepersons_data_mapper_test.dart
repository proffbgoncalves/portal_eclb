import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/person/mariadb_notable_persons_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/notable_person_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/notable_person_dto.dart';

void main(){
  group("MariadbDataMapperNotablePersonTests", (){

    test("GenerateInsertTest", (){
      NotablePersonDTO dto = new NotablePersonDTO();

      MariadbNotablePersonsDataMapper dataMapper = new MariadbNotablePersonsDataMapper();

      try{
        dataMapper.generateInsertStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        expect(e.toString().contains("Não é possível gerar statement SQL. Atributo patrimonyPersonId não é válido."), isTrue);

      }
      dto = new NotablePersonDTO(patrimonyPersonId: 0);

      List statement = dataMapper.generateInsertStatement(dto);
      expect(statement.length, equals(2));
      expect(statement[0], "INSERT INTO `eclb_dev`.NOTABLEPERSONS (PATRIMONYPERSONID) VALUES (?)");
      expect(statement[1][0], equals(0));
    });

    test("GenerateDeleteTest", (){
      NotablePersonDTO dto = new NotablePersonDTO();

      MariadbNotablePersonsDataMapper dataMapper = new MariadbNotablePersonsDataMapper();

      try{
        dataMapper.generateDeleteStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        print(e);
        expect(e.toString().contains("Id parameter is not an instance of int."), isTrue);

      }

      dto = new NotablePersonDTO(patrimonyPersonId: 0);

      List statement = dataMapper.generateDeleteStatement(dto.patrimonyPersonId as Object);
      expect(statement.length, equals(2));
      expect(statement[0], "DELETE FROM `eclb_dev`.NOTABLEPERSONS WHERE PATRIMONYPERSONID = ?");
      expect(statement[1][0], equals(0));
    });

    test("GenerateUpdateTest", (){
      NotablePersonDTO dto = new NotablePersonDTO();

      MariadbNotablePersonsDataMapper dataMapper = new MariadbNotablePersonsDataMapper();

      try{
        dataMapper.generateUpdateStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        expect(e.toString().contains("Não é possível gerar statement SQL. Atributo patrimonyPersonId não é válido."), isTrue);

      }
      dto = new NotablePersonDTO(patrimonyPersonId: 0);

      List statement = dataMapper.generateUpdateStatement(dto);
      expect(statement.length, equals(2));
      expect(statement[0], "UPDATE `eclb_dev`.NOTABLEPERSONS SET "
          " patrimonypersonid = ? WHERE PATRIMONYPERSONID = ?");
      expect(statement[1][0], equals(0));
    });

    test("GenerateFindAllTest", (){

      MariadbNotablePersonsDataMapper dataMapper = new MariadbNotablePersonsDataMapper();

      try{
        dataMapper.generateFindAllStatement(-10, 0);
        fail("Falha ao testar com parametro negativo.");
      }catch(e){
        expect(e.toString().contains(
            "Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos"), isTrue);

      }

      List statement = dataMapper.generateFindAllStatement(10, 0);
      expect(statement.length, equals(2));
      expect(statement[0], "SELECT * FROM `eclb_dev`.NOTABLEPERSONS LIMIT ? OFFSET ?");
      expect(statement[1][0], equals(10));
      expect(statement[1][1], equals(0));
    });

    test("GenerateFindByIdTest", (){

      MariadbNotablePersonsDataMapper dataMapper = new MariadbNotablePersonsDataMapper();

      try{
        dataMapper.generateFindByIdStatement("10");
        fail("Falha ao testar com parametro string.");
      }catch(e){
        expect(e.toString().contains(
            "Id parameter is not an instance of int."), isTrue);

      }

      List statement = dataMapper.generateFindByIdStatement(0);
      expect(statement.length, equals(2));
      expect(statement[0], "SELECT * FROM `eclb_dev`.NOTABLEPERSONS WHERE PATRIMONYPERSONID = ?");
      expect(statement[1][0], equals(0));
    });
    test("GenerateCountTest", (){

      MariadbNotablePersonsDataMapper dataMapper = new MariadbNotablePersonsDataMapper();


      List statement = dataMapper.generateCountStatement();
      expect(statement[0], "SELECT COUNT(patrimonyPersonId) FROM `eclb_dev`.NOTABLEPERSONS");

    });
  });
}