import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/composite/mariadb_visitation_stage_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/person/mariadb_notable_persons_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/notable_person_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/visitation_stage_dto.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/notable_person_dto.dart';

void main(){
  group("MariadbDataMapperNotablePersonTests", (){

    test("GenerateInsertTest", (){
      VisitationStageDTO dto = new VisitationStageDTO();

      MariadbVisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper();

      try{
        dataMapper.generateInsertStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        expect(e.toString().contains(
            "Não é possível gerar statement SQL. Atributo visitationItineraryId não é válido."), isTrue);

      }
      dto = new VisitationStageDTO(visitationItineraryId: 0, name: "m");

      List statement = dataMapper.generateInsertStatement(dto);
      expect(statement.length, equals(2));
      expect(statement[0],
          "INSERT INTO `eclb_dev`.VISITATIONSTAGES (name, visitationitineraryid) VALUES ( ?, ?)");
      expect(statement[1][0], equals("m"));
      expect(statement[1][1], equals(0));
    });

    test("GenerateDeleteTest", (){
      VisitationStageDTO dto = new VisitationStageDTO();

      MariadbVisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper();

      try{
        dataMapper.generateDeleteStatement(" ");
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        print(e);
        expect(e.toString().contains(
            "Id parameter is not an instance of int."), isTrue);

      }

      dto = new VisitationStageDTO( id: 0);

      List statement = dataMapper.generateDeleteStatement(dto.id as Object);
      expect(statement.length, equals(2));
      expect(statement[0], "DELETE FROM `eclb_dev`.VISITATIONSTAGES WHERE id = ?");
      expect(statement[1][0], equals(0));
    });

    test("GenerateUpdateTest", (){
      VisitationStageDTO dto = new VisitationStageDTO();

      MariadbVisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper();

      try{
        dataMapper.generateUpdateStatement(dto);
        fail("Falha ao testar DTO com atributo nulo.");
      }catch(e){
        expect(e.toString().contains(
            "Não é possível gerar statement SQL. Atributo id não é válido."), isTrue);

      }
      dto = new VisitationStageDTO(name: "m", visitationItineraryId: 0, id: 0);

      List statement = dataMapper.generateUpdateStatement(dto);
      expect(statement.length, equals(2));
      expect(statement[0],
          "UPDATE `eclb_dev`.VISITATIONSTAGES SET name = ?, visitationitineraryid = ? WHERE id = ?");
      expect(statement[1][0], equals("m"));
      expect(statement[1][1], equals(0));
      expect(statement[1][2], equals(0));

    });

    test("GenerateFindAllTest", (){

      MariadbVisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper();

      try{
        dataMapper.generateFindAllStatement(-10, 0);
        fail("Falha ao testar com parametro negativo.");
      }catch(e){
        expect(e.toString().contains(
            "Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos"), isTrue);

      }

      List statement = dataMapper.generateFindAllStatement(10, 0);
      expect(statement.length, equals(2));
      expect(statement[0], "SELECT * FROM `eclb_dev`.VISITATIONSTAGES LIMIT ? OFFSET ?");
      expect(statement[1][0], equals(10));
      expect(statement[1][1], equals(0));
    });

    test("GenerateFindByIdTest", (){

      MariadbVisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper();

      try{
        dataMapper.generateFindByIdStatement("10");
        fail("Falha ao testar com parametro string.");
      }catch(e){
        expect(e.toString().contains(
            "Id parameter is not an instance of int."), isTrue);

      }

      List statement = dataMapper.generateFindByIdStatement(0);
      expect(statement.length, equals(2));
      expect(statement[0],"SELECT * FROM `eclb_dev`.VISITATIONSTAGES WHERE id = ?");
      expect(statement[1][0], equals(0));
    });
    test("GenerateCountTest", (){

      MariadbVisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper();


      List statement = dataMapper.generateCountStatement();
      expect(statement[0], "SELECT COUNT(id) FROM `eclb_dev`.VISITATIONSTAGES");

    });
  });
}