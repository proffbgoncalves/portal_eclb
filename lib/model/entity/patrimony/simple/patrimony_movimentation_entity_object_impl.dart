import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/simple/patrimony_movimentation_entity_object.dart';
import 'package:portal_eclb/model/patrimony/simple/patrimony_movimentation.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/simple/patrimony_movimentation_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

final class PatrimonyMovimentationEntityObjectImpl extends AbstractEntityObject implements PatrimonyMovimentationEntityObject {

  PatrimonyMovimentation _dto;

  PatrimonyMovimentationEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));

    PatrimonyMovimentationDAO dao = factory.createPatrimonyMovimentationDAO(databaseSessionManager);

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

    PatrimonyMovimentationDAO dao = daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager);
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

    PatrimonyMovimentationDAO dao = daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager);

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

  DateTime? get date {
    return this._dto.date;
  }

  void set date(DateTime? date) {
    this._dto.date = date;
  }

  String? get origin {
    return this._dto.origin;
  }

  void set origin(String? origin) {
    this._dto.origin = origin;
  }

  String? get destination {
    return this._dto.destination;
  }

  void set destination(String? destination) {
    this._dto.destination = destination;
  }

  String? get description {
    return this._dto.description;
  }

  void set description(String? description) {
    this._dto.description = description;
  }

  int? get simplePatrimonyId {
    return this._dto.simplePatrimonyId;
  }

  void set simplePatrimonyId(int? simplePatrimonyId) {
    this._dto.simplePatrimonyId = simplePatrimonyId;
  }

  static Future<PatrimonyMovimentation> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    PatrimonyMovimentationDAO dao = daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as PatrimonyMovimentation;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List>? getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    PatrimonyMovimentationDAO dao = daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }
}
