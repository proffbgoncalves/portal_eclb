import 'package:get_it/get_it.dart'; // throwIf
import 'package:portal_eclb/model/patrimony/composite/visitation_stage.dart';
import 'package:portal_eclb/resource/datamapper/data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/composite/visitation_stage_data_mapper.dart';

 abstract class AbstractVisitationStageDataMapper implements VisitationStageDataMapper {
  @override
  List generateCountStatement() {
    // Não pode passar por parâmetro pois queremos que o SQL puxe genericamente todos id
    List statement = ["SELECT COUNT(id) FROM VISITATIONSTAGES"];
    return statement;
  }

  @override
  List generateDeleteStatement(Object id) {
    throwIf(!(id is int), Exception("Id parameter is not an instance of int."));
    List statement = ["DELETE FROM VISITATIONSTAGES WHERE id = ?", [id]];
    return statement;
  }

  @override
  List generateFindByIdStatement(Object id) {
    throwIf(!(id is int), Exception("Id parameter is not an instance of int."));
    List statement = ["SELECT * FROM VISITATIONSTAGES WHERE id = ?", [id]];
    return statement;
  }

  @override
  List generateInsertStatement(Object dto) {
    throwIf(!(dto is VisitationStage), Exception("DTO parameter is not an instance of VisitationStage"));

    dto = dto as VisitationStage;

    List statement = ["INSERT INTO VISITATIONSTAGES (name, visitationitineraryid) VALUES ( ?, ?)",
      [ dto.name, dto.visitationItineraryId]];

    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    throwIf(!(dto is VisitationStage), Exception("DTO parameter is not an instance of VisitationStage"));

    dto = dto as VisitationStage;

    if (dto.id == null || !(dto.id is int) || dto.id! < 0) {
      throw Exception("Não é possível gerar statement SQL. Atributo id não é válido.");
    }

    List statement = ["UPDATE VISITATIONSTAGES SET name = ?, visitationitineraryid = ? WHERE id = ?",
      [dto.name, dto.visitationItineraryId, dto.id]];
    return statement;
  }

  @override
  List generateFindAllStatement([int limit = 0, int offset = 0]) {
    if (limit > 0 && offset >= 0) {
      return ["SELECT * FROM VISITATIONSTAGES LIMIT ? OFFSET ?", [limit, offset]];
    } else if (limit == 0 && offset == 0) {
      return ["SELECT * FROM VISITATIONSTAGES"];
    } else {
      throw Exception("Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos");
    }
  }

  @override
  List generateFindAllByName(String name) {
    // TODO: implement generateFindAllByName
    throw UnimplementedError();
  }

  @override
  List generateFindAllByVisitationItineraryId(int visitationItineraryId) {
    // TODO: implement generateFindAllByVisitationItineraryId
    throw UnimplementedError();
  }

  @override
  List generateFindById(int id) {
    // TODO: implement generateFindById
    throw UnimplementedError();
  }

  @override
  List generateList(Iterable resultSet) {
    // TODO: implement generateList
    throw UnimplementedError();
  }

  @override
  Object? generateObject(Iterable resultSet) {
    // TODO: implement generateObject
    throw UnimplementedError();
  }

  }