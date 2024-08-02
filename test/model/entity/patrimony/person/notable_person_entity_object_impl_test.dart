import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/person/notable_person_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/person/notable_person_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main(){

  group("NotablePersonEntityObjectTest", (){

    setUpAll(() async {
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

      try {
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        await databaseSessionManager.execute("DELETE FROM NOTABLEPERSONS");
        await databaseSessionManager.execute("DELETE FROM PATRIMONYPERSONS");
        await databaseSessionManager.execute("DELETE FROM PERSONS");

        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();

        await databaseSessionManager.execute("INSERT INTO persons (name) VALUES (?), (?), (?)",
            ['John Doe', "Jane Smith", "Alice Johnson "]);

        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();

        Results? results = (await databaseSessionManager.executeQuery("SELECT id FROM PERSONS")) as Results;
        print(results);

        await databaseSessionManager.execute("INSERT INTO patrimonypersons (personId, birthday, biography, deathDate, photo) "
            "VALUES (?, ?, ?, ?, ?), (?, ?, ?, ?, ?),(?, ?, ?, ?, ?) ",
            [ results.elementAt(0)[0],'2024-01-01', 'Famous for contributions to art.', null, null,
               results.elementAt(1)[0],'2024-02-01', 'Notable historian and author.', null, null,
               results.elementAt(2)[0], '2024-03-01', 'Renowned environmental scientist.', null, null]);


        await databaseSessionManager.commit();
      } catch (e){
        await databaseSessionManager.rollback();
        rethrow;
      } finally{
        await databaseSessionManager.close();
      }
    });

    setUp(() async{
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

      try {
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        await databaseSessionManager.execute("DELETE FROM NOTABLEPERSONS");

        Results? results2 = (await databaseSessionManager.executeQuery("SELECT personId FROM patrimonypersons")) as Results;


        await databaseSessionManager.execute("INSERT INTO notablepersons (patrimonyPersonId) VALUES (?)",
            [results2.elementAt(0)[0]]);
        await databaseSessionManager.execute("INSERT INTO notablepersons (patrimonyPersonId) VALUES (?)",
            [results2.elementAt(1)[0]]);


        await databaseSessionManager.commit();
      } catch (e){

        await databaseSessionManager.rollback();
        rethrow;
      } finally{

        await databaseSessionManager.close();
      }


    });

    tearDown(() async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();

        await manager.execute("DELETE FROM NOTABLEPERSONS");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });

    tearDownAll(() async{
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();

        await manager.execute("DELETE FROM NOTABLEPERSONS");
        await manager.execute("DELETE FROM PATRIMONYPERSONS");
        await manager.execute("DELETE FROM PERSONS");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }

    });
    test("TestInsert", () async {
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");

      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);
      await sessionManager.open();
      await sessionManager.startTransaction();

      Results? results3 = (await sessionManager.executeQuery("SELECT personId FROM PATRIMONYPERSONS")) as Results;
      print(results3);

      NotablePersonEntityObject notablePerson = new NotablePersonEntityObjectImpl(
          sessionManager,
          environmentConfiguration,
          results3.elementAt(2)[0]);

      expect(notablePerson.patrimonyPersonId, results3.elementAt(2)[0]);
      try {
        await sessionManager.open();
        await sessionManager.startTransaction();


        await notablePerson.insert();


        await sessionManager.commit();
      } catch (e) {
        print("deu merda $e");
        await sessionManager.rollback();
        rethrow;
      } finally {
        await sessionManager.close();
      }
    });

    test("testDeleteNotablePersonEntityObject", () async {
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);
      print("Printando em delete impl 1");
      try {
        await sessionManager.open();
        await sessionManager.startTransaction();
        print("Printando em delete impl 2");
        Results? results3 = (await sessionManager.executeQuery("SELECT personId FROM PATRIMONYPERSONS")) as Results;
        print("Printando em delete impl 3");
        NotablePersonEntityObject? entity = await NotablePersonEntityObjectImpl.getById(sessionManager, environmentConfiguration, results3.elementAt(0)[0]);
        print("Printando em delete impl 4");


        expect(await entity?.delete(), isTrue);

        await sessionManager.commit();
      } catch (e) {
        await sessionManager.rollback();
        throw e;
      } finally {
        await sessionManager.close();
      }
    });

    // test("testUpdateNotablePersonEntityObject", () async {
    //   EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    //   DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);
    //
    //   try {
    //     await sessionManager.open();
    //     await sessionManager.startTransaction();
    //     Results? results3 = (await sessionManager.executeQuery("SELECT id FROM PATRIMONYPERSONS")) as Results;
    //
    //     NotablePersonEntityObject? entity = await NotablePersonEntityObjectImpl.getById(sessionManager, environmentConfiguration, results3.elementAt(1)[0]);
    //
    //     expect(entity?.patrimonyPersonId, equals(results3.elementAt(1)[0]));
    //
    //     entity?.patrimonyPersonId = results3.elementAt(3)[0];
    //
    //     expect(await entity?.update(), isTrue);
    //
    //     await sessionManager.commit();
    //
    //     entity = await NotablePersonEntityObjectImpl.getById(sessionManager, environmentConfiguration, results3.elementAt(3)[0]);
    //     expect(entity?.patrimonyPersonId, equals(results3.elementAt(3)[0]));
    //   } catch (e) {
    //     await sessionManager.rollback();
    //     throw e;
    //   } finally {
    //     await sessionManager.close();
    //   }
    // });

  });
}