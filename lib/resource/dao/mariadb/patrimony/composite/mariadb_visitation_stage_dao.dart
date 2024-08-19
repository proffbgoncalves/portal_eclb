import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/composite/visitation_stage.dart';
import 'package:portal_eclb/resource/dao/abstract_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_stage_dao.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/composite/visitation_stage_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/visitation_stage_dto.dart';

final class MariadbVisitationStageDao extends AbstractDAO implements VisitationStageDAO {
  MariadbVisitationStageDao(super.sessionManager, super.dataMapper);

  @override
  Future<int> count() async {
    throwIf(!this.sessionManager.isOpened, new Exception("Database session is not opened."));

    List statement = this.dataMapper!.generateCountStatement();
    Results results = (await super.sessionManager.executeQuery(statement[0])) as Results;

    return results.first[0];
  }
  /*
  @override
  Future<bool> insert(Object dto) async {
    bool result = await super.insert(dto);
    Results? results = (await super.sessionManager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;
    dto as VisitationStage;
    dto.id = results.first[0];

    return result;
  }
  */
  @override
  Future<VisitationStage> findByName(String name) async{
    if (!this.sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }

    List statement = (this.dataMapper as VisitationStageDataMapper).generateFindAllByName(name);
    Results results = (await this.sessionManager.executeQuery(statement[0], statement[1])) as Results;
    VisitationStage dto = new VisitationStageDTO(
      id: results.first[0],
      name: results.first[1],
      visitationItineraryId: results.first[2],
    );

    return dto;
  }


  @override
  Future<VisitationStage?> findByVisitationItineraryId(int visitationItineraryId) {
    // TODO: implement findByVisitationItineraryId
    throw UnimplementedError();
  }

  @override
  Future<VisitationStage?> findByid(int id) async{
    if (!this.sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }

    List statement = (this.dataMapper as VisitationStageDataMapper).generateFindById(id);
    Results results = (await this.sessionManager.executeQuery(statement[0], statement[1])) as Results;
    if (results.isEmpty) {
    return null;
    }

    VisitationStage dto = new VisitationStageDTO(
    id: results.first[0],
    name: results.first[1],
    visitationItineraryId: results.first[2],
    );

    return dto;
  }



}
