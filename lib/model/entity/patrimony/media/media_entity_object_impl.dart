import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/media/media_entity_object.dart';
import 'package:portal_eclb/model/patrimony/media/media.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/media/media_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

final class MediaEntityObjectImpl extends AbstractEntityObject implements MediaEntityObject {

  Media _dto;

  MediaEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));

    MediaDAO dao = factory.createMediaDAO(databaseSessionManager);

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

    MediaDAO dao = daoFactory.createMediaDAO(databaseSessionManager);
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

    MediaDAO dao = daoFactory.createMediaDAO(databaseSessionManager);

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

  String? get description {
    return this._dto.description;
  }

  void set description(String? description) {
    this._dto.description = description;
  }

  List<int>? get file {
    return this._dto.file;
  }

  void set file(List<int>? file) {
    this._dto.file = file;
  }

  String? get extension {
    return this._dto.extension;
  }

  void set extension(String? extension) {
    this._dto.extension = extension;
  }

  int? get patrimonyId {
    return this._dto.patrimonyId;
  }

  void set patrimonyId(int? patrimonyId) {
    this._dto.patrimonyId = patrimonyId;
  }

  int? get typesOfMediaId {
    return this._dto.typesOfMediaId;
  }

  void set typesOfMediaId(int? typesOfMediaId) {
    this._dto.typesOfMediaId = typesOfMediaId;
  }

  static Future<Media> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    MediaDAO dao = daoFactory.createMediaDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as Media;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List>? getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    MediaDAO dao = daoFactory.createMediaDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }
}
