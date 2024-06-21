import 'package:get_it/get_it.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

class DependencyInjector {

  GetIt _getIt = GetIt.instance;
  static DependencyInjector _instance = DependencyInjector._();

  DependencyInjector._();

  factory DependencyInjector.getInstance() {
    return DependencyInjector._instance;
  }

  void registerEnvironmentConfiguration(EnvironmentConfiguration environmentConfiguration) {
    this._getIt.registerSingleton<EnvironmentConfiguration>(environmentConfiguration, instanceName: "configuration");
  }

  EnvironmentConfiguration getEnvironmentConfigurarion() {
    return this._getIt.get<EnvironmentConfiguration>(instanceName: "configuration");
  }

  void registerDAOFactory(String dbms, DAOFactory daoFactory) {

    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    throwIf(daoFactory == null, new Exception("DAO Factory parameter is null."));

    this._getIt.registerSingleton<DAOFactory>(daoFactory, instanceName: dbms);
  }

  DAOFactory getDAOFactory(String dbms) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    throwIfNot(this._getIt.isRegistered<DAOFactory>(instanceName: dbms), new Exception(dbms + " is not a registered instance of DAOFactory."));

    return this._getIt.get<DAOFactory>(instanceName: dbms);
  }

  bool hasDAOFactory(String dbms) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    return this._getIt.isRegistered<DAOFactory>(instanceName: dbms);
  }

  void registerDatabaseSessionManager(String dbms, DatabaseSessionManager databaseSessionManager) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    throwIf(databaseSessionManager == null, new Exception("Database session manager parameter is null"));

    this._getIt.registerSingleton<DatabaseSessionManager>(databaseSessionManager, instanceName: dbms);
  }

  DatabaseSessionManager getDatabaseSessionManager(String dbms) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    throwIfNot(this._getIt.isRegistered<DatabaseSessionManager>(instanceName: dbms), new Exception(dbms + "is not a registered instance of Database Session Manager"));

    return this._getIt.get<DatabaseSessionManager>(instanceName: dbms).clone();
  }

  bool hasDatabaseSessionManager(String dbms) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    return this._getIt.isRegistered<DatabaseSessionManager>(instanceName: dbms);
  }

}