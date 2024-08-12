import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/person/user/user_entity_object.dart';
import 'package:portal_eclb/model/person/user/user.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/person/user/user_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

final class UserEntityObjectImpl extends AbstractEntityObject implements UserEntityObject {
  User _dto;

  UserEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));
    UserDAO dao = factory.createUserDAO(databaseSessionManager);

    try {
      return await dao.delete(this._dto.personId as Object);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> insert() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
    UserDAO dao = daoFactory.createUserDAO(databaseSessionManager);

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
    UserDAO dao = daoFactory.createUserDAO(databaseSessionManager);

    try {
      return await dao.update(this._dto);
    } catch (error) {
      rethrow;
    }
  }

  @override
  int? get id => this._dto.personId;

  @override
  set id(int? id) {
    throw UnimplementedError();
  }

  @override
  int? get personId => this._dto.personId;

  @override
  set personId(int? personId) {
    this._dto.personId = personId;
  }

  @override
  String? get login => this._dto.login;

  @override
  set login(String? login) {
    this._dto.login = login;
  }

  @override
  String? get password => this._dto.password;

  @override
  set password(String? password) {
    this._dto.password = password;
  }

  @override
  String? get function => this._dto.function;

  @override
  set function(String? function) {
    this._dto.function = function;
  }

  static Future<User> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
    UserDAO dao = daoFactory.createUserDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as User;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List> getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
    UserDAO dao = daoFactory.createUserDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }
}
