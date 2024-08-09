import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/historic/type_of_patrimony_historic_entity_object.dart';
import 'package:portal_eclb/model/patrimony/historic/type_of_patrimony_historic.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/historic/type_of_patrimony_historic_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/historic/type_of_patrimony_historic_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../dependency/dependecy_injector.dart';


class TypeOfPatrimonyHistoricEntityObjectImpl extends AbstractEntityObject implements TypeOfPatrimonyHistoricEntityObject{

  TypeOfPatrimonyHistoric _dto;


  TypeOfPatrimonyHistoricEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);


  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));
    TypeOfPatrimonyHistoricDAO dao = factory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager);

    try {
      return await dao.delete(this._dto.id as Object);
    } catch (error){
      rethrow;
    }
  }

  @override
  Future<bool> insert() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
    TypeOfPatrimonyHistoricDAO dao = daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager);
    try {
      return await dao.insert(this._dto);
    } catch(error) {

      rethrow;
    }
  }

  @override
  Future<bool> update() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    TypeOfPatrimonyHistoricDAO dao = daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager);

    try {
      return await dao.update(this._dto);
    } catch (error) {
      rethrow;
    }
  }

  int? get id {
    return this._dto.id;
  }

  void set id(int? id) {
    throw UnimplementedError();
  }

  String? get description {
    return this._dto.description;
  }

  void set description(String? description) {
    this._dto.description = description;
  }

  static Future<TypeOfPatrimonyHistoric> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    TypeOfPatrimonyHistoricDAO dao = daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as TypeOfPatrimonyHistoric;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List>? getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    TypeOfPatrimonyHistoricDAO dao = daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }

}


