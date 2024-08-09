import 'package:get_it/get_it.dart'; // igual
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/exposition/exposition_entity_object.dart';
import 'package:portal_eclb/model/patrimony/exposition/exposed_patrimony.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart'; // igual
import 'package:portal_eclb/resource/dao/dao_factory.dart'; // igual
import 'package:portal_eclb/resource/dao/patrimony/exposition/exposition_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart'; // igual
import 'package:portal_eclb/transferency/dto/patrimony/exposition/exposition_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../dependency/dependecy_injector.dart';
import '../../../patrimony/exposition/exposition.dart'; // igual



class ExpositionEntityObjectImpl extends AbstractEntityObject implements ExpositionEntityObject {

  Exposition _dto;

  ExpositionEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));
    ExpositionDAO dao = factory.createExpositionDAO(databaseSessionManager);

    try {
      return await dao.delete(this._dto.id as Object);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> insert() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
    ExpositionDAO dao = daoFactory.createExpositionDAO(databaseSessionManager);
    try {
      return await dao.insert(this._dto);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> update() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    ExpositionDAO dao = daoFactory.createExpositionDAO(databaseSessionManager);

    try {
      return await dao.update(this._dto);
    } catch (error) {
      rethrow;
    }
  }

  @override
  int? get id {
    return this._dto.id;
  }

  @override
  void set id(int? id) {
    this._dto.id = id;
  }

  @override
  String? get name {
    return this._dto.name;
  }

  @override
  void set name(String? name) {
    this._dto.name = name;
  }

  @override
  String? get description {
    return this._dto.description;
  }

  @override
  void set description(String? description) {
    this._dto.description = description;
  }

  static Future<Exposition> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    ExpositionDAO dao = daoFactory.createExpositionDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as Exposition;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List> getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    ExpositionDAO dao = daoFactory.createExpositionDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }
}
