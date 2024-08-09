import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/news/patrimony_news_media_entity_object.dart';
import 'package:portal_eclb/model/patrimony/news/patrimony_news_media.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/news/patrimony_news_media_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/news/patrimony_news_media_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../dependency/dependecy_injector.dart';

class PatrimonyNewsMediaEntityObjectImpl extends AbstractEntityObject implements PatrimonyNewsMediaEntityObject {

  PatrimonyNewsMedia _dto;


  PatrimonyNewsMediaEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));
    PatrimonyNewsMediaDAO dao = factory.createPatrimonyNewsMediaDAO(databaseSessionManager);

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
    PatrimonyNewsMediaDAO dao = daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager);
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

    PatrimonyNewsMediaDAO dao = daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager);

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

  static Future<PatrimonyNewsMedia> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    PatrimonyNewsMediaDAO dao = daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as PatrimonyNewsMedia;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List>? getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    PatrimonyNewsMediaDAO dao = daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }

}