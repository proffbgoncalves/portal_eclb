import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/person/type_of_acting_entity_object.dart';
import 'package:portal_eclb/model/patrimony/person/type_of_acting.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/type_of_acting_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/type_of_acting_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

class TypeOfActingEntityObjectImpl extends AbstractEntityObject implements TypeOfActingEntityObject{

  TypeOfActing _dto;
  TypeOfActingEntityObjectImpl._(super._databaseSessionManager, super.environmentConfiguration, this._dto);

  factory TypeOfActingEntityObjectImpl(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration enviromentConfiguration, String description, {int? id}){
    TypeOfActingDTO dto = new TypeOfActingDTO(id: id,description: description);
    TypeOfActingEntityObjectImpl instance = new TypeOfActingEntityObjectImpl._(databaseSessionManager, enviromentConfiguration, dto);
    return instance;
  }

  factory TypeOfActingEntityObjectImpl._createFromDTO(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, TypeOfActing dto){
    TypeOfActingEntityObjectImpl instance = new TypeOfActingEntityObjectImpl._(databaseSessionManager, environmentConfiguration, dto);
    return instance;
  }

  @override
  Future<bool> delete() async{
   throwIf(this._dto.id == null, new Exception("It is not possible to delete the entity. Id is null"));
   DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
   TypeOfActingDAO dao = factory.createTypeOfActingDAO(databaseSessionManager);
   try {
     return await dao.delete(this._dto.id as Object);
   } catch (e){
     throw e;
   }
  }
  @override
  set id(int? int) {
    throw new Exception("Identity can not be defined.");
  }

  Future<bool> insert() async {
    throwIf(this._dto.description == null, new Exception("Description attribute is null"));
    throwIf(this._dto.description == "", new Exception("Description attribute is empty"));
    DAOFactory factory = AbstractDAOFactory.getInstance(this.environmentConfiguration);
    TypeOfActingDAO dao = factory.createTypeOfActingDAO(databaseSessionManager);
    try {
      return await dao.insert(this._dto as Object);
    } catch (e) {
      throw e;
    }
  }
  @override
  Future<bool> update() async {
    DAOFactory factory = AbstractDAOFactory.getInstance(this.environmentConfiguration);
    TypeOfActingDAO dao = factory.createTypeOfActingDAO(databaseSessionManager);
    try {
      return await dao.update(this._dto as Object);
    } catch (e) {
      throw e;
    }
  }
  @override
  int? get id {
    throwIf(this._dto.id == null, new Exception("Entity object identity is null."));
    return this._dto.id;
  }

  @override
  void set description(String? description) {
    this._dto?.description = description;
  }

  @override
  String? get description => this._dto?.description;

  static Future<TypeOfActingEntityObjectImpl> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfActingDAO dao = factory.createTypeOfActingDAO(databaseSessionManager);

    try {
      TypeOfActing dto = await dao.findById(id) as TypeOfActing;
      TypeOfActingEntityObjectImpl entity = TypeOfActingEntityObjectImpl._createFromDTO(databaseSessionManager, environmentConfiguration, dto);
      return entity;
    } catch (e) {
      throw e;
    }
  }

  static Future<TypeOfActingEntityObjectImpl> getByDescription(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, String description) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfActingDAO dao = factory.createTypeOfActingDAO(databaseSessionManager);

    try {
      TypeOfActing dto = await dao.findByDescription(description);
      TypeOfActingEntityObjectImpl entity = TypeOfActingEntityObjectImpl._createFromDTO(databaseSessionManager, environmentConfiguration, dto);
      return entity;
    } catch (e) {
      throw e;
    }
  }
  static Future<List<TypeOfActingEntityObject>> getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfActingDAO dao = factory.createTypeOfActingDAO(databaseSessionManager);

    try {
      List dtos = await dao.findAll(limit, offset);

      List<TypeOfActingEntityObject> entities = [];

      for (TypeOfActing dto in dtos) {
        TypeOfActingEntityObjectImpl entity = TypeOfActingEntityObjectImpl._createFromDTO(databaseSessionManager, environmentConfiguration, dto);

        entities.add(entity as TypeOfActingEntityObject);
      }

      return entities;
    } catch (e) {
      throw e;
    }
  }

}

