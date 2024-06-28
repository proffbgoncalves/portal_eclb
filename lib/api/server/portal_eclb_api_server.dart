import 'package:portal_eclb/api/server/abstract_api_server.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

final class PortalECLBAPIServer extends AbstractAPIServer {


  PortalECLBAPIServer(super.ipAddress, super.port);

  @override
  Future<void> configureEnvironment(String filename) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(filename);
    dependencyInjector.registerEnvironmentConfiguration(environmentConfiguration);

    MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);
    dependencyInjector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);

    MariaDBDAOFactory daoFactory = new MariaDBDAOFactory(environmentConfiguration);
    dependencyInjector.registerDAOFactory(environmentConfiguration.get("dbms"), daoFactory);
  }


}