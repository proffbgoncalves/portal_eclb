import 'package:portal_eclb/model/patrimony/composite/visitation_stage.dart';
import 'package:portal_eclb/resource/dao/dao.dart';

 abstract interface class VisitationStageDAO implements DAO{

  Future<VisitationStage?> findByid(int id);

  Future<VisitationStage> findByName(String name);
  
  Future<VisitationStage?> findByVisitationItineraryId(int visitationItineraryId);

}