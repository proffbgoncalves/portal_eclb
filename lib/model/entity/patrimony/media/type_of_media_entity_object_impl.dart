import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/media/type_of_media_entity_object.dart';
import 'package:portal_eclb/model/patrimony/media/type_of_media.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/media/type_of_media_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/media/type_of_media_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

class TypeOfMediaEntityObjectImpl extends AbstractEntityObject implements TypeOfMediaEntityObject {

  TypeOfMedia _dto;

  TypeOfMediaEntityObjectImpl._(super._databaseSessionManager, super.environmentConfiguration, this._dto);

  factory TypeOfMediaEntityObjectImpl(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, String description, {int? id}) {

    TypeOfMediaDTO dto = new TypeOfMediaDTO(id: id, description: description);
    TypeOfMediaEntityObjectImpl instance = new TypeOfMediaEntityObjectImpl._(databaseSessionManager, environmentConfiguration, dto);

    return instance;
  }

  factory TypeOfMediaEntityObjectImpl._createFromDTO(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, TypeOfMedia dto) {
    TypeOfMediaEntityObjectImpl instance = new TypeOfMediaEntityObjectImpl._(databaseSessionManager, environmentConfiguration, dto);
    return instance;
  }

  @override
  Future<bool> delete() async {
    throwIf(this._dto.id == null, new Exception("It is not possible to delete the entity. Id is null"));
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfMediaDAO dao = factory.createTypeOfMediaDAO(databaseSessionManager);
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

  @override
  Future<bool> insert() async {
    throwIf(this._dto.description == null, new Exception("Description attribute is null"));
    throwIf(this._dto.description == "", new Exception("Description attribute is empty"));
    DAOFactory factory = AbstractDAOFactory.getInstance(this.environmentConfiguration);
    TypeOfMediaDAO dao = factory.createTypeOfMediaDAO(databaseSessionManager);
    try {
      return await dao.insert(this._dto as Object);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> update() async {
    DAOFactory factory = AbstractDAOFactory.getInstance(this.environmentConfiguration);
    TypeOfMediaDAO dao = factory.createTypeOfMediaDAO(databaseSessionManager);
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

  static Future<TypeOfMediaEntityObject> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfMediaDAO dao = factory.createTypeOfMediaDAO(databaseSessionManager);

    try {
      TypeOfMedia dto = await dao.findById(id) as TypeOfMedia;
      TypeOfMediaEntityObject entity = TypeOfMediaEntityObjectImpl._createFromDTO(databaseSessionManager, environmentConfiguration, dto);
      return entity;
    } catch (e) {
      throw e;
    }
  }

  static Future<TypeOfMediaEntityObject> getByDescription(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, String description) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfMediaDAO dao = factory.createTypeOfMediaDAO(databaseSessionManager);

    try {
      TypeOfMedia dto = await dao.findByDescription(description);
      TypeOfMediaEntityObject entity = TypeOfMediaEntityObjectImpl._createFromDTO(databaseSessionManager, environmentConfiguration, dto);
      return entity;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<TypeOfMediaEntityObject>> getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfMediaDAO dao = factory.createTypeOfMediaDAO(databaseSessionManager);

    try {
      List dtos = await dao.findAll(limit, offset);

      List<TypeOfMediaEntityObject> entities = [];

      for (TypeOfMedia dto in dtos) {
        TypeOfMediaEntityObjectImpl entity = TypeOfMediaEntityObjectImpl._createFromDTO(databaseSessionManager, environmentConfiguration, dto);

        entities.add(entity);
      }

      return entities;
    } catch (e) {
      throw e;
    }
  }
}