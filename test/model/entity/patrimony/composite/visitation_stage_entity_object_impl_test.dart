import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/composite/visitation_stage_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';
import 'package:portal_eclb/model/entity/patrimony/composite/visitation_stage_entity_object.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';


void main(){

  group("TestVisitationStageEntityObjectImpl", (){

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
        await databaseSessionManager.execute("DELETE FROM VISITATIONSTAGES");
        await databaseSessionManager.execute("DELETE FROM VISITATIONITINERARY");
        await databaseSessionManager.execute("DELETE FROM COMPOSITEPATRIMONIES");
        await databaseSessionManager.execute("DELETE FROM PATRIMONIES");
        await databaseSessionManager.execute("DELETE FROM TYPESOFCOMPOSITEPATRIMONIES");
        await databaseSessionManager.execute("DELETE FROM TYPESOFPATRIMONIES");

        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();

        await databaseSessionManager.execute("INSERT INTO typesofcompositepatrimonies (id, description) VALUES (?, ?), (?, ?), (?, ?)",
            [1, "Architectural Complex", 2, 'Historic District', 3, 'Natural Landmark']);
        await databaseSessionManager.execute("INSERT INTO typesofpatrimonies (description) VALUES (?), (?), (?)",
            ["Cultural", "Imaterial", "Natural"]);

        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();

        Results? results = (await databaseSessionManager.executeQuery("SELECT id  FROM TYPESOFPATRIMONIES")) as Results;
        print(results);


        await databaseSessionManager.execute("INSERT INTO patrimonies (name, description, "
            "unescoClassification, typeOfPatrimonyId, compositePatrimonyId,"
            " hasLocation, country, state, city, district, address, postalCode, longitude, latitude,"
            " altitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?),"
            "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?), (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            ['Eiffel Tower', 'Temp description', 1, results.elementAt(0)[0], null, 1, 'France', 'Île-de-France', 'Paris', 'Temp district', 'Temp address', 75007, 0, 0, 0,
              'Great Wall of China', 'Temp description', 2, results.elementAt(1)[0], null, 1, 'China', 'Beijing', 'Beijing', 'Temp district', 'Temp address', 100000, 0, 0, 0,
              'Niagara Falls', 'Temp description', 3, results.elementAt(2)[0], null, 1, 'USA', 'New York', 'Niagara Falls', 'Temp district', 'Temp address', 14303, 0, 0, 0]);

        Results? results2 = (await databaseSessionManager.executeQuery("SELECT id  FROM PATRIMONIES")) as Results;
        Results? results22 = (await databaseSessionManager.executeQuery("SELECT id  FROM typesofcompositepatrimonies")) as Results;


        await databaseSessionManager.execute("INSERT INTO compositepatrimonies ( patrimonyId, typeofcompositepatrimonyId) "
            "VALUES (?, ?), (?, ?),(?, ?) ",
            [ results2.elementAt(0)[0], results22.elementAt(0)[0],
              results2.elementAt(1)[0], results22.elementAt(1)[0],
               results2.elementAt(2)[0], results22.elementAt(2)[0]]);

        Results? results3 = (await databaseSessionManager.executeQuery("SELECT patrimonyid  FROM compositepatrimonies")) as Results;
        await databaseSessionManager.execute("INSERT INTO visitationitinerary ( description, compositypatrimonyId, durattion) "
            "VALUES (?, ?, ?), (?, ?, ?),(?, ?, ?) ",
            [ 'Colosseum Tour', results3.elementAt(0)[0], '02:00:00',
              'Grand Canyon Visit', results3.elementAt(1)[0], '03:00:00',
              'Machu Picchu Exploration', results3.elementAt(2)[0], '04:00:00']);
        await databaseSessionManager.commit();
      } catch (e){
        print("deu merda em setupall");
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
        await databaseSessionManager.execute("DELETE FROM visitationStages");


        Results? results4 = (await databaseSessionManager.executeQuery("SELECT id FROM visitationitinerary")) as Results;

        await databaseSessionManager.execute("INSERT INTO visitationstages ( name, visitationitineraryId) "
            "VALUES (?, ?), (?, ?) ",
            [ 'Stage 1', results4.elementAt(0)[0],
              'Stage 2', results4.elementAt(1)[0],]);


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

        await manager.execute("DELETE FROM VISITATIONSTAGES");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        rethrow;
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

         await manager.execute("DELETE FROM VISITATIONSTAGES");
        await manager.execute("DELETE FROM VISITATIONITINERARY");
        await manager.execute("DELETE FROM COMPOSITEPATRIMONIES");
        await manager.execute("DELETE FROM PATRIMONIES");
        await manager.execute("DELETE FROM TYPESOFCOMPOSITEPATRIMONIES");
        await manager.execute("DELETE FROM TYPESOFPATRIMONIES");
        print("deletando tudo -------------------------------------------");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        rethrow;
      } finally {
        await manager.close();
      }

    });




  test("TestInsert", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");

    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);
    await sessionManager.open();
    await sessionManager.startTransaction();
    Results? results4 = (await sessionManager.executeQuery("SELECT id FROM visitationitinerary")) as Results;

    await sessionManager.close();

    // Cria um novo VisitationStage
    VisitationStageEntityObject visitationStage = VisitationStageEntityObjectImpl(
      sessionManager,
      environmentConfiguration,
      1,
      'Stage 3',
      results4.elementAt(2)[0]
    );

    try {
      await sessionManager.open();
      await sessionManager.startTransaction();

      await visitationStage.insert();

      await sessionManager.commit();
    } catch (e) {
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

    Results? results5 = (await sessionManager.executeQuery("SELECT id FROM visitationstages")) as Results;


      // Obter um VisitationStage pelo ID
      VisitationStageEntityObject? entity = await VisitationStageEntityObjectImpl.getById(sessionManager, environmentConfiguration, results5.elementAt(0)[0]);

      expect(entity?.id, equals(results5.elementAt(0)[0]));
      expect(await entity?.delete(), isTrue);

      await sessionManager.commit();
    } catch (e) {
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
      Results? results5 = (await sessionManager.executeQuery("SELECT id FROM visitationstages")) as Results;

      // Obter um VisitationStage pelo ID
      VisitationStageEntityObject? entity = await VisitationStageEntityObjectImpl.getById(sessionManager, environmentConfiguration, results5.elementAt(1)[0]);

      expect(entity?.name, equals("Stage 2"));

      // Atualiza o nome
      entity?.name = "Updated Stage";

      expect(await entity?.update(), isTrue);

      await sessionManager.commit();

      // Verifica se a atualização foi bem-sucedida
      entity = await VisitationStageEntityObjectImpl.getById(sessionManager, environmentConfiguration, results5.elementAt(1)[0]);
      expect(entity?.name, equals("Updated Stage"));
    } catch (e) {
      await sessionManager.rollback();
      throw e;
    } finally {
      await sessionManager.close();
    }
  });



  });
}