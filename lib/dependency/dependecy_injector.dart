import 'package:get_it/get_it.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Esta classe é um Singleton, pois ela é capaz de produzir uma única instância.
///O injetor de dependência é um objeto que permite gerenciar e fornecer dependências
///(instâncias de classes ou objetos) para outros objetos sem que eles conheçam
///as classes concretas.
///
///Por meio da única instância desta classe, é possível obter:
/// - Configurações do ambiente da aplicação (EnvironmentConfiguration);
/// - Objetos para gerenciamento de sessões com o banco de dados (DatabaseSessionManager);
/// - Fábricas de objetos de acesso a dados (DAOFactory).
///
///O injetor de dependência deve ser configurado antes de ser utilizado, caso contrário
///não será útil.
class DependencyInjector {

  GetIt _getIt = GetIt.instance;

  ///Atributo para armazenar a referência para a única instância do injetor de
  ///dependências.
  static DependencyInjector _instance = DependencyInjector._();

  ///Construtor privado.
  DependencyInjector._();

  ///Método estático para a única instância do injetor de dependência.
  factory DependencyInjector.getInstance() {
    return DependencyInjector._instance;
  }

  ///Registra a instância da configuração de ambiente da aplicação.
  void registerEnvironmentConfiguration(EnvironmentConfiguration environmentConfiguration) {
    this._getIt.registerSingleton<EnvironmentConfiguration>(environmentConfiguration, instanceName: "configuration");
  }

  ///Retorna a dependência da configuração de ambiente da aplicação.
  EnvironmentConfiguration getEnvironmentConfigurarion() {
    return this._getIt.get<EnvironmentConfiguration>(instanceName: "configuration");
  }

  ///Verifica se o injetor de dependência possui um EnvironmentConfiguration.
  bool hasEnvironmentConfiguration() {
    return this._getIt.isRegistered<EnvironmentConfiguration>(instanceName: "configuration");
  }

  ///Registra uma uma dependência do tipo DAOFactory.
  void registerDAOFactory(String dbms, DAOFactory daoFactory) {

    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    throwIf(daoFactory == null, new Exception("DAO Factory parameter is null."));

    this._getIt.registerSingleton<DAOFactory>(daoFactory, instanceName: dbms);
  }

  ///Retorna a dependência do tipo DAOFactory.
  DAOFactory getDAOFactory(String dbms) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    throwIfNot(this._getIt.isRegistered<DAOFactory>(instanceName: dbms), new Exception(dbms + " is not a registered instance of DAOFactory."));

    return this._getIt.get<DAOFactory>(instanceName: dbms);
  }

  ///Verifica se o injetor de dependência possui um DAOFactory registrado.
  bool hasDAOFactory(String dbms) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    return this._getIt.isRegistered<DAOFactory>(instanceName: dbms);
  }

  ///Registra uma dependência do tipo DatabaseSessionManager.
  void registerDatabaseSessionManager(String dbms, DatabaseSessionManager databaseSessionManager) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    throwIf(databaseSessionManager == null, new Exception("Database session manager parameter is null"));

    this._getIt.registerSingleton<DatabaseSessionManager>(databaseSessionManager, instanceName: dbms);
  }

  ///Retorna uma dependência do tipo DatabaseSessionManager.
  DatabaseSessionManager getDatabaseSessionManager(String dbms) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    throwIfNot(this._getIt.isRegistered<DatabaseSessionManager>(instanceName: dbms), new Exception(dbms + "is not a registered instance of Database Session Manager"));

    return this._getIt.get<DatabaseSessionManager>(instanceName: dbms).clone();
  }

  ///Verifica se o injetor de dependência possui um DatabaseSessionManager registrado.
  bool hasDatabaseSessionManager(String dbms) {
    throwIf(dbms == "", new Exception("DBMS parameteter can not be empty."));
    return this._getIt.isRegistered<DatabaseSessionManager>(instanceName: dbms);
  }

}