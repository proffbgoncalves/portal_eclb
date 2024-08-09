import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/entity/person/visitor/visitor_entity_object.dart';
import 'package:portal_eclb/model/entity/person/visitor/visitor_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';


void main()  {
  group("VisitorEntityObjectImplTest", () {

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

        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.VISITORS");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.MEMORIES");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.PATRIMONIES");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.PERSONS");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.TYPESOFPATRIMONIES");


        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();


        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.persons (name) VALUES (?), (?), (?)",
            ['John Doe', "Jane Smith", "Alice Johnson "]);
        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.typesofpatrimonies (description) VALUES (?), (?), (?)",

            ["Cultural", "Imaterial", "Natural"]);

        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();


        Results? results = (await databaseSessionManager.executeQuery("SELECT id  FROM `eclb_dev`.TYPESOFPATRIMONIES")) as Results;
        print(results);


        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.patrimonies (name, description, "

            "unescoClassification, typeOfPatrimonyId, compositePatrimonyId,"
            " hasLocation, country, state, city, district, address, postalCode, longitude, latitude,"
            " altitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?),"
            "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?), (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            ['Eiffel Tower', 'Temp description', 1, results.elementAt(0)[0], null, 1, 'France', 'Île-de-France', 'Paris', 'Temp district', 'Temp address', 75007, 0, 0, 0,
              'Great Wall of China', 'Temp description', 2, results.elementAt(1)[0], null, 1, 'China', 'Beijing', 'Beijing', 'Temp district', 'Temp address', 100000, 0, 0, 0,
              'Niagara Falls', 'Temp description', 3, results.elementAt(2)[0], null, 1, 'USA', 'New York', 'Niagara Falls', 'Temp district', 'Temp address', 14303, 0, 0, 0]);


        Results? results2 = (await databaseSessionManager.executeQuery("SELECT id  FROM `eclb_dev`.PATRIMONIES")) as Results;
        print(results2);

        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.Memories (date, description, patrimonyId) "

            "VALUES (?, ?, ?), (?, ?, ?),(?, ?, ?) ",
            ['2024-01-01', 'Memory of the Colosseum exhibition', results2.elementAt(0)[0],
              '2024-02-01', 'Memory of the Grand Canyon workshop', results2.elementAt(1)[0],
              '2024-03-01', 'Memory of the Machu Picchu lecture', results2.elementAt(2)[0]]);


        await databaseSessionManager.commit();
      } catch (e){

        print("deu errado em setupall sql");
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

        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.VISITORS");

        Results? results3 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.PERSONS")) as Results;
        print(results3);
        Results? results4 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.MEMORIES")) as Results;
        print(results4);

        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.VISITORS (PERSONID, ADDRESS, NUMBER, COMPLEMENTO, DISTRICT, CITY, STATE, POSTALCODE, PHONE, EMAIL, MEMORYID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            [results3.elementAt(0)[0], "rua", 100, "ali", "centro", "bji","rj",
              "100", "2299", "@gmail.com",results4.elementAt(0)[0]]);
        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.VISITORS (PERSONID, ADDRESS, NUMBER, COMPLEMENTO, DISTRICT, CITY, STATE, POSTALCODE, PHONE, EMAIL, MEMORYID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",

            [results3.elementAt(1)[0], "rua", 100, "ali", "centro", "bji","rj",
              "100", "2299", "@gmail3.com",results4.elementAt(1)[0]]);

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


        await manager.execute("DELETE FROM `eclb_dev`.VISITORS");


        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });



    test("TestInsert", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");

      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);
      await sessionManager.open();
      await sessionManager.startTransaction();

      Results? results3 = (await sessionManager.executeQuery("SELECT id FROM `eclb_dev`.PERSONS")) as Results;
      print(results3);
      Results? results4 = (await sessionManager.executeQuery("SELECT id FROM `eclb_dev`.MEMORIES")) as Results;

      print(results4);

      await sessionManager.close();

      VisitorEntityObject visitor = new VisitorEntityObjectImpl(sessionManager, environmentConfiguration, results3.elementAt(2)[0], "rua", 100, "ali", "centro", "bji","rj",
          "100", "2299", "@gmail2.com",results4.elementAt(2)[0]);


      //expect(visitor.personId, equals(3));

      try{
        await sessionManager.open();
        await sessionManager.startTransaction();

        await visitor.insert();
        //expect(visitor.personId, greaterThan(0));


        await sessionManager.commit();
      } catch(e) {
        print("deu merda $e");
        await sessionManager.rollback();
        rethrow;
      } finally {
        await sessionManager.close();
      }
    });
    test("testDeleteTypeOfPatrimonyEntityObject", () async {
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);


      try {
        await sessionManager.open();
        await sessionManager.startTransaction();

        VisitorEntityObject? entity = await VisitorEntityObjectImpl.getByEmail(sessionManager, environmentConfiguration, "@gmail.com");

        expect(entity?.email, equals("@gmail.com"));
        expect(await entity?.delete(), isTrue);

        await sessionManager.commit();
      } catch(e) {
        await sessionManager.rollback();
        throw e;
      } finally {
        await sessionManager.close();
      }
    });

    test("testUpdateTypeOfPatrimonyEntityObject", () async {

      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

      try {
        await sessionManager.open();
        await sessionManager.startTransaction();

        VisitorEntityObject? entity = await VisitorEntityObjectImpl.getByEmail(sessionManager, environmentConfiguration, "@gmail3.com");

        expect(entity?.email, equals("@gmail3.com"));

        entity?.email = "@gmail+teste.com";

        expect(await entity?.update(), isTrue);

        await sessionManager.commit();

        entity = await VisitorEntityObjectImpl.getByEmail(sessionManager, environmentConfiguration, "@gmail+teste.com");
        expect(entity?.email, equals("@gmail+teste.com"));
      } catch(e) {
        await sessionManager.rollback();
        throw e;
      } finally {
        await sessionManager.close();
      }
    });



    tearDownAll(() async{
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();


        await manager.execute("DELETE FROM `eclb_dev`.VISITORS");
        await manager.execute("DELETE FROM `eclb_dev`.MEMORIES");
        await manager.execute("DELETE FROM `eclb_dev`.PATRIMONIES");
        await manager.execute("DELETE FROM `eclb_dev`.PERSONS");
        await manager.execute("DELETE FROM `eclb_dev`.TYPESOFPATRIMONIES");

        print("deletando tudo -------------------------------------------");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }

    });
  });


}