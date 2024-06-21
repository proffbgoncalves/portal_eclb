import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("AbstactDatabaseSessionManagerTest", () {

    setUp(() async {
      DependencyInjector injector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      if (!injector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))) {
        injector.registerDatabaseSessionManager(
            environmentConfiguration.get("dbms"), databaseSessionManager);
      }
    });

    // test("testUniqueInstanceOfMariaDBDatabaseSessionManager", () async {
    //
    //   EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env_dev");
    //   DatabaseSessionManager? manager1 = AbstractDatabaseSessionManager.getInstance(configuration);
    //   expect(manager1.getType(), configuration.get("dbms"));
    //
    //   DatabaseSessionManager? manager2 = AbstractDatabaseSessionManager.getInstance(configuration);
    //   expect(manager2.getType(), configuration.get("dbms"));
    //
    //   expect(manager1, equals(manager2));
    // });



  });

}