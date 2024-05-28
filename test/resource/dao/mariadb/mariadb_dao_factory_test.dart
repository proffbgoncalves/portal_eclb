import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("MariaDBDAOFactoryTest", () {

    setUp(() async {
      DependencyInjector injector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      if (!injector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))) {
        injector.registerDatabaseSessionManager(
            environmentConfiguration.get("dbms"), databaseSessionManager);
      }

      if (!injector.hasDAOFactory(environmentConfiguration.get("dbms"))) {
        injector.registerDAOFactory(environmentConfiguration.get("dbms"), new MariaDBDAOFactory(environmentConfiguration));
      }
    });

    test("testCreateTypeOfPatrimonyDAO", () async {

      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      MariaDBDAOFactory factory = new MariaDBDAOFactory(environmentConfiguration);

      expect(factory.createTypeOfPatrimonyDAO() is TypeOfPatrimonyDAO, isTrue);

    });

  });

}