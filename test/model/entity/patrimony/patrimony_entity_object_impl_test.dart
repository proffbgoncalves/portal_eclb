import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/patrimony_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("PatrimonyEntityObjectImplTest", () {

    int typeOfPatrimonyId = 0;

    setUp(() async {

      DependencyInjector injector = DependencyInjector.getInstance();
      EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      if (!injector.hasDatabaseSessionManager(configuration.get("dbms"))) {

        injector.registerDatabaseSessionManager(configuration.get("dbms"), manager);
      }

      if (!injector.hasDAOFactory(configuration.get("dbms"))) {
        MariaDBDAOFactory factory = new MariaDBDAOFactory(configuration);
        injector.registerDAOFactory(configuration.get("dbms"), factory);
      }

      try {
        await manager.open();
        await manager.startTransaction();

        await manager.execute("DELETE FROM TYPESOFPATRIMONIES");
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Natural"]);
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Imaterial"]);
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Cultural"]);
        await manager.commit();

        Results? results = (await manager.executeQuery("SELECT * FROM TYPESOFPATRIMONIES WHERE DESCRIPTION = ?", ["Natural"])) as Results;

        typeOfPatrimonyId = results.first[0];

        // await manager.startTransaction();
        //
        // await manager.execute(
        //     "INSERT INTO PATRIMONIES (NAME, DESCRIPTION, UNESCOCLASSIFICATION, TYPEOFPATRIMONYID, HASLOCATION) VALUES (?, ?, ?, ?, ?)",
        //     ["Rio Itabapoana", "Rio de Bom Jesus", 1, typeOfPatrimonyId, 1]
        // );
        //
        // results = (await manager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;
        //
        // patrimonyId = results.first[0];
        //
        // await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }

    });

    tearDown(() async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();

        await manager.execute("DELETE FROM PATRIMONIES");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });


    test("testInsertPatrimonyEntityObject", ()  async {

      EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      DatabaseSessionManager manager = AbstractDatabaseSessionManager.getInstance(configuration);

      PatrimonyEntityObjectImpl patrimony = new PatrimonyEntityObjectImpl(configuration, "Teste", "Descrição", 0, typeOfPatrimonyId, 0);

      try {
        await manager.open();
        await manager.startTransaction();

        await patrimony.insert();
        expect(patrimony.id, greaterThan(0));

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        rethrow;
      } finally {
        await manager.close();
      }

    });

  });

}