import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/news/patrimony_news_entity_object.dart';
import 'package:portal_eclb/model/patrimony/news/patrimony_news.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/news/patrimony_news_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

final class PatrimonyNewsEntityObjectImpl extends AbstractEntityObject implements PatrimonyNewsEntityObject {

  PatrimonyNews _dto;

  PatrimonyNewsEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));

    PatrimonyNewsDAO dao = factory.createPatrimonyNewsDAO(databaseSessionManager);

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

    PatrimonyNewsDAO dao = daoFactory.createPatrimonyNewsDAO(databaseSessionManager);

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

    PatrimonyNewsDAO dao = daoFactory.createPatrimonyNewsDAO(databaseSessionManager);

    try {
      return await dao.update(this._dto);
    } catch (error) {
      rethrow;
    }
  }

  @override
  int? get id => this._dto.id;

  @override
  set id(int? id) {
    throw UnimplementedError();
  }

  @override
  String? get title => this._dto.title;

  @override
  set title(String? title) {
    this._dto.title = title;
  }

  @override
  String? get description => this._dto.description;

  @override
  set description(String? description) {
    this._dto.description = description;
  }

  @override
  int? get patrimonyId => this._dto.patrimonyId;

  @override
  set patrimonyId(int? patrimonyId) {
    this._dto.patrimonyId = patrimonyId;
  }

  @override
  int? get typeOfPatrimonyNewsId => this._dto.typeOfPatrimonyNewsId;

  @override
  set typeOfPatrimonyNewsId(int? typeOfPatrimonyNewsId) {
    this._dto.typeOfPatrimonyNewsId = typeOfPatrimonyNewsId;
  }

  static Future<PatrimonyNews> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    PatrimonyNewsDAO dao = daoFactory.createPatrimonyNewsDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as PatrimonyNews;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List> getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    PatrimonyNewsDAO dao = daoFactory.createPatrimonyNewsDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }
}
