import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/composite/visitation_stage_entity_object.dart';
import 'package:portal_eclb/model/patrimony/composite/visitation_stage.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_stage_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/visitation_stage_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

class VisitationStageEntityObjectImpl extends AbstractEntityObject implements VisitationStageEntityObject{

  VisitationStage _dto;
  VisitationStageEntityObjectImpl._(super.databaseSessionManager, super.environmentConfiguration, this._dto);
  /*
    VisitationItineraryEntityObject? _visitationItinerary;

    @override
  Future<VisitationItineraryEntityObject?> get visitationItinerary async {
    if (this._visitationItinerary == null) {
      this._visitationItinerary = await VisitationItineraryEntityObject.getById(this.databaseSessionManager, this.environmentConfiguration, this.visitationItinerary!);
    }
    return this._visitationItinerary;
  }
  */

  factory VisitationStageEntityObjectImpl(
    DatabaseSessionManager databaseSessionManager,
    EnvironmentConfiguration environmentConfiguration,
    int id,
    String name,
    int visitationItineraryId
  ) {
    
    VisitationStageDTO dto = VisitationStageDTO(
      id:  id,
      name: name,
      visitationItineraryId: visitationItineraryId
    );

    // Retorna uma nova instância da classe
    return VisitationStageEntityObjectImpl._(
      databaseSessionManager,
      environmentConfiguration,
      dto,
    );
  }

  // Construtor de fábrica para criar uma instância a partir de um DTO existente
  factory VisitationStageEntityObjectImpl.createFromDTO(
    DatabaseSessionManager databaseSessionManager,
    EnvironmentConfiguration environmentConfiguration,
    VisitationStage dto,
  ) {
    return VisitationStageEntityObjectImpl._(
      databaseSessionManager,
      environmentConfiguration,
      dto,
    );
  }

  static Future<VisitationStageEntityObject?> getById(
    DatabaseSessionManager databaseSessionManager,
    EnvironmentConfiguration environmentConfiguration,
    int id,
  ) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitationStageDAO visitationStageDAO = factory.createVisitationStageDAO(databaseSessionManager);

    try {
      Object? object = await visitationStageDAO.findById(id);
      if (object == null) {
        print("Deu null no getById");
        return null;
      }

      VisitationStage dto = object as VisitationStage;
      VisitationStageEntityObject entity = VisitationStageEntityObjectImpl.createFromDTO(
        databaseSessionManager,
        environmentConfiguration,
        dto,
      );
      return entity;

    } catch (e) {
      rethrow;
    }
  }

@override
  Future<bool> delete() async {
    
    throwIf(_dto.id == null, Exception("It is not possible to delete the entity. id is null"));
    
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitationStageDAO visitationStageDAO = factory.createVisitationStageDAO(databaseSessionManager);

    try {
      
      return await visitationStageDAO.delete(_dto.id as Object);
    } catch (e) {
      rethrow; 
    }
  }

  @override
  Future<bool> insert() async {
    // Verifica se os campos obrigatórios estão preenchidos
    throwIf(this._dto.name == null || this._dto.name!.isEmpty, Exception("Name attribute is null or empty"));
    throwIf(this._dto.visitationItineraryId == null || !(this.visitationItineraryId is int), Exception("visitationItineraryId attribute is null or invalid"));

    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitationStageDAO visitationStageDAO = factory.createVisitationStageDAO(databaseSessionManager);

    try {
      // Chama o DAO para inserir o objeto
      return await visitationStageDAO.insert(this._dto as Object);
    } catch (e) {
      if (e.toString().contains("Duplicate Entry")) {
        throw Exception("VisitationStage já existe");
      } else {
        print("relançando em VisitationStageEntityObjectInsert $e");
        rethrow;
      }
    }
  }

  @override
  Future<bool> update() async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitationStageDAO visitationStageDAO = factory.createVisitationStageDAO(databaseSessionManager);

    try {
      
      return await visitationStageDAO.update(this._dto as Object);
    } catch (e) {
      rethrow; 
    }
  }
  
  


@override
   set id(int? id){
    throw new Exception("Identity can not be redefined.");
  }
  @override
int? get id => this._dto.id;

@override
 set name(String? name){
  this._dto.name = name;
}
@override
String? get name => this._dto.name;

@override
 set visitationItineraryId(int? visitationItineraryId){
  throw new Exception("Identity can not be redefined.");
}
@override
int? get visitationItineraryId => this._dto.visitationItineraryId;
}