import 'package:portal_eclb/utils/environment_configuration.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart'; // igual
import 'package:portal_eclb/resource/dao/dao_factory.dart'; // igual
import 'package:get_it/get_it.dart'; // igual
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/historic/patrimony_historic_entity_object.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart'; // igual
import '../../../../resource/dao/patrimony/historic/patrimony_historic_dao.dart';
import '../../../../transferency/dto/patrimony/historic/patrimony_historic_dto.dart';
import '../../../patrimony/historic/patrimony_historic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';



class PatrimonyHistoricEntityObjectImpl extends AbstractEntityObject implements PatrimonyHistoricEntityObject {
  PatrimonyHistoric _dto;

  PatrimonyHistoricEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));
    PatrimonyHistoricDAO dao = factory.createPatrimonyHistoricDAO(databaseSessionManager);

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
    PatrimonyHistoricDAO dao = daoFactory.createPatrimonyHistoricDAO(databaseSessionManager);
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
    PatrimonyHistoricDAO dao = daoFactory.createPatrimonyHistoricDAO(databaseSessionManager);

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

  String? get name {
    return this._dto.name;
  }

  void set name(String? name) {
    this._dto.name = name;
  }

  DateTime? get date {
    return this._dto.date;
  }

  void set date(DateTime? date) {
    this._dto.date = date;
  }

  String? get narrative {
    return this._dto.narrative;
  }

  void set narrative(String? narrative) {
    this._dto.narrative = narrative;
  }

  int? get patrimonyID {
    return this._dto.patrimonyID;
  }

  void set patrimonyID(int? patrimonyID) {
    this._dto.patrimonyID = patrimonyID;
  }

  int? get typeOfPatrimonyHistoricID {
    return this._dto.typeOfPatrimonyHistoricID;
  }

  void set typeOfPatrimonyHistoricID(int? typeOfPatrimonyHistoricID) {
    this._dto.typeOfPatrimonyHistoricID = typeOfPatrimonyHistoricID;
  }

  static Future<PatrimonyHistoric> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    PatrimonyHistoricDAO dao = daoFactory.createPatrimonyHistoricDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as PatrimonyHistoric;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List>? getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    PatrimonyHistoricDAO dao = daoFactory.createPatrimonyHistoricDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }
}
