import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/type_of_patrimony_dao.dart';
import 'package:portal_eclb/transferency/dto/patrimony/type_of_patrimony_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

class TypeOfPatimonyEntityObjectImpl extends AbstractEntityObject implements TypeOfPatrimonyEntityObject {

  TypeOfPatrimony _dto;

  TypeOfPatimonyEntityObjectImpl._(super.environmentConfiguration, this._dto);

  factory TypeOfPatimonyEntityObjectImpl(EnvironmentConfiguration environmentConfiguration, String description, {int? id}) {

    TypeOfPatrimonyDTO dto = new TypeOfPatrimonyDTO(id: id, description: description);
    TypeOfPatimonyEntityObjectImpl instance = new TypeOfPatimonyEntityObjectImpl._(environmentConfiguration, dto);

    return instance;
  }

  factory TypeOfPatimonyEntityObjectImpl._createFromDTO(EnvironmentConfiguration environmentConfiguration, TypeOfPatrimony dto) {
    TypeOfPatimonyEntityObjectImpl instance = new TypeOfPatimonyEntityObjectImpl._(environmentConfiguration, dto);
    return instance;
  }

  @override
  Future<bool> delete() async {
    throwIf(this._dto.id == null, new Exception("It is not possible to delete the entity. Id is null"));
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfPatrimonyDAO dao = factory.createTypeOfPatrimonyDAO();
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
    TypeOfPatrimonyDAO dao = factory.createTypeOfPatrimonyDAO();
    try {
      return await dao.insert(this._dto as Object);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> update() async {
    DAOFactory factory = AbstractDAOFactory.getInstance(this.environmentConfiguration);
    TypeOfPatrimonyDAO dao = factory.createTypeOfPatrimonyDAO();
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

  static Future<TypeOfPatrimonyEntityObject> getById(EnvironmentConfiguration environmentConfiguration, int id) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfPatrimonyDAO dao = factory.createTypeOfPatrimonyDAO();

    try {
      TypeOfPatrimony dto = await dao.findById(id) as TypeOfPatrimony;
      TypeOfPatrimonyEntityObject entity = TypeOfPatimonyEntityObjectImpl._createFromDTO(environmentConfiguration, dto);
      return entity;
    } catch (e) {
      throw e;
    }
  }

  static Future<TypeOfPatrimonyEntityObject> getByDescription(EnvironmentConfiguration environmentConfiguration, String description) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfPatrimonyDAO dao = factory.createTypeOfPatrimonyDAO();

    try {
       TypeOfPatrimony dto = await dao.findByDescription(description);
       TypeOfPatrimonyEntityObject entity = TypeOfPatimonyEntityObjectImpl._createFromDTO(environmentConfiguration, dto);
       return entity;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<TypeOfPatrimonyEntityObject>> getAll(EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    TypeOfPatrimonyDAO dao = factory.createTypeOfPatrimonyDAO();

    try {
      List dtos = await dao.findAll(limit, offset);

      List<TypeOfPatrimonyEntityObject> entities = [];

      for (TypeOfPatrimony dto in dtos) {
        TypeOfPatimonyEntityObjectImpl entity = TypeOfPatimonyEntityObjectImpl._createFromDTO(environmentConfiguration, dto);

        entities.add(entity);
      }

      return entities;
    } catch (e) {
      throw e;
    }
  }
}