import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/person/visitor/mariadb_visitor_data_mapper.dart';

import 'package:portal_eclb/transferency/dto/person/visitor/visitor_dto.dart';

void main(){
  group("MariadbDataMapperVisitorTests", (){

    test("GenerateInsertTest", (){
      VisitorDTO dto = new VisitorDTO();

      MariadbVisitorDataMapper dataMapper = new MariadbVisitorDataMapper();

      try{
        dataMapper.generateInsertStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        expect(e.toString().contains(
            "Não é possível gerar statement SQL. Atributo personId não é valido."), isTrue);
      }

      dto = new VisitorDTO(
          personId: 1,
          address: 'Via Roma',
          number: 10,
          complemento: null,
          district: 'Downtown',
          city: 'Florence',
          state: 'mg',
          postalCode: '50123',
          phone: '1234567890',
          email: 'leonardo@example.com',
          memoryId: 1
      );

      List statement = dataMapper.generateInsertStatement(dto);
      expect(statement.length, equals(2));
      expect(statement[0], "INSERT INTO `eclb_dev`.VISITORS (PERSONID, ADDRESS, NUMBER, COMPLEMENTO, DISTRICT, CITY, STATE, POSTALCODE, PHONE, EMAIL, MEMORYID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
      expect(statement[1][0], equals(1));
      expect(statement[1][1], equals('Via Roma'));
      expect(statement[1][2], equals(10));
      expect(statement[1][3], equals(null));
      expect(statement[1][4], equals('Downtown'));
      expect(statement[1][5], equals('Florence'));
      expect(statement[1][6], equals('mg'));
      expect(statement[1][7], equals('50123'));
      expect(statement[1][8], equals('1234567890'));
      expect(statement[1][9], equals('leonardo@example.com'));
      expect(statement[1][10], equals(1));
    });

    test("GenerateDeleteTest", (){
      VisitorDTO dto = new VisitorDTO();

      MariadbVisitorDataMapper dataMapper = new MariadbVisitorDataMapper();

      try{
        dataMapper.generateDeleteStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        print(e);
        expect(e.toString().contains("Id parameter is not an instance of int."), isTrue);
      }

      dto = new VisitorDTO(personId: 1);

      List statement = dataMapper.generateDeleteStatement(dto.personId as Object);
      expect(statement.length, equals(2));
      expect(statement[0], "DELETE FROM `eclb_dev`.VISITORS WHERE PERSONID = ?");
      expect(statement[1][0], equals(1));
    });

    test("GenerateUpdateTest", (){
      VisitorDTO dto = new VisitorDTO();

      MariadbVisitorDataMapper dataMapper = new MariadbVisitorDataMapper();

      try{
        dataMapper.generateUpdateStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        expect(e.toString().contains(
            "Não é possível gerar statement SQL. Atributo personId não é valido."), isTrue);
      }

      dto = new VisitorDTO(
          personId: 1,
          address: 'Via Roma',
          number: 10,
          complemento: null,
          district: 'Downtown',
          city: 'Florence',
          state: 'mg',
          postalCode: '50123',
          phone: '1234567890',
          email: 'leonardo@example.com',
          memoryId: 1
      );

      List statement = dataMapper.generateUpdateStatement(dto);
      expect(statement.length, equals(2));
      expect(statement[0], "UPDATE `eclb_dev`.VISITORS SET "
          "ADDRESS = ?, NUMBER = ?, COMPLEMENTO = ?, DISTRICT = ?, CITY = ?, STATE = ?,"
          "POSTALCODE = ?, PHONE = ?, EMAIL = ? WHERE PERSONID = ?");
      expect(statement[1][0], equals('Via Roma'));
      expect(statement[1][1], equals(10));
      expect(statement[1][2], equals(null));
      expect(statement[1][3], equals('Downtown'));
      expect(statement[1][4], equals('Florence'));
      expect(statement[1][5], equals('mg'));
      expect(statement[1][6], equals('50123'));
      expect(statement[1][7], equals('1234567890'));
      expect(statement[1][8], equals('leonardo@example.com'));
      expect(statement[1][9], equals(1));
    });

    test("GenerateFindAllTest", (){

      MariadbVisitorDataMapper dataMapper = new MariadbVisitorDataMapper();

      try{
        dataMapper.generateFindAllStatement(-10, 0);
        fail("Falha ao testar com parametro negativo.");
      }catch(e){
        expect(e.toString().contains(
            "Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos"), isTrue);
      }

      List statement = dataMapper.generateFindAllStatement(10, 0);
      expect(statement.length, equals(2));
      expect(statement[0], "SELECT * FROM `eclb_dev`.VISITORS LIMIT = ? OFFSET = ?");
      expect(statement[1][0], equals(10));
      expect(statement[1][1], equals(0));
    });

    test("GenerateFindByIdTest", (){

      MariadbVisitorDataMapper dataMapper = new MariadbVisitorDataMapper();

      try{
        dataMapper.generateFindByIdStatement("1");
        fail("Falha ao testar com parametro string.");
      }catch(e){
        expect(e.toString().contains(
            "Id parameter is not an instance of int."), isTrue);
      }

      List statement = dataMapper.generateFindByIdStatement(1);
      expect(statement.length, equals(2));
      expect(statement[0], "SELECT * FROM `eclb_dev`.VISITORS WHERE PERSONID = ?");
      expect(statement[1][0], equals(1));
    });

    test("GenerateCountTest", (){

      MariadbVisitorDataMapper dataMapper = new MariadbVisitorDataMapper();

      List statement = dataMapper.generateCountStatement();
      expect(statement[0], "SELECT COUNT(personId) FROM `eclb_dev`.VISITORS");
    });
  });
}
