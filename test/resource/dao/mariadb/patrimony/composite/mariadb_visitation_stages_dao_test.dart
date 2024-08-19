import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/patrimony/composite/visitation_stage.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/composite/mariadb_visitation_stage_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_stage_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/composite/mariadb_visitation_stage_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/composite/visitation_stage_data_mapper.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/default_visitation_stage_dto.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/visitation_stage_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main(){
  group("MariadbVisitationStagesDAO", (){
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

        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.VISITATIONSTAGES");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.VISITATIONITINERARY");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.COMPOSITEPATRIMONIES");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.PATRIMONIES");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.TYPESOFCOMPOSITEPATRIMONIES");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.TYPESOFPATRIMONIES");


        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();


        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.typesofcompositepatrimonies (id, description) VALUES (?, ?), (?, ?), (?, ?)",
            [1, "Architectural Complex", 2, 'Historic District', 3, 'Natural Landmark']);
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
        Results? results22 = (await databaseSessionManager.executeQuery("SELECT id  FROM `eclb_dev`.typesofcompositepatrimonies")) as Results;


        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.compositepatrimonies ( patrimonyId, typeofcompositepatrimonyId) "

            "VALUES (?, ?), (?, ?),(?, ?) ",
            [ results2.elementAt(0)[0], results22.elementAt(0)[0],
              results2.elementAt(1)[0], results22.elementAt(1)[0],
              results2.elementAt(2)[0], results22.elementAt(2)[0]]);


        Results? results3 = (await databaseSessionManager.executeQuery("SELECT patrimonyid  FROM `eclb_dev`.compositepatrimonies")) as Results;
        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.visitationitinerary ( description, compositypatrimonyId, durattion) "

            "VALUES (?, ?, ?), (?, ?, ?),(?, ?, ?) ",
            [ 'Colosseum Tour', results3.elementAt(0)[0], '02:00:00',
              'Grand Canyon Visit', results3.elementAt(1)[0], '03:00:00',
              'Machu Picchu Exploration', results3.elementAt(2)[0], '04:00:00']);
        await databaseSessionManager.commit();
      } catch (e){

        print("deu erro em setupall sql");

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

        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.visitationStages");


        Results? results4 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.visitationitinerary")) as Results;

        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.visitationstages ( name, visitationitineraryId) "
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


        await manager.execute("DELETE FROM `eclb_dev`.VISITATIONSTAGES");


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


        await manager.execute("DELETE FROM `eclb_dev`.VISITATIONSTAGES");
        await manager.execute("DELETE FROM `eclb_dev`.VISITATIONITINERARY");
        await manager.execute("DELETE FROM `eclb_dev`.COMPOSITEPATRIMONIES");
        await manager.execute("DELETE FROM `eclb_dev`.PATRIMONIES");
        await manager.execute("DELETE FROM `eclb_dev`.TYPESOFCOMPOSITEPATRIMONIES");
        await manager.execute("DELETE FROM `eclb_dev`.TYPESOFPATRIMONIES");

        print("deletando tudo -------------------------------------------");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        rethrow;
      } finally {
        await manager.close();
      }

    });


    test("InsertVisitationStageDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        expect(databaseSessionManager.isOnTransaction, isTrue);

        Results? results = (await(databaseSessionManager.executeQuery("SELECT ID FROM eclb_dev.VISITATIONITINERARY"))) as Results;


        print(results);
        print("--------------------------------------------------");
        VisitationStage visitationStage = new VisitationStageDTO(name: "Stage 1", visitationItineraryId: results.elementAt(0)[0] );
        VisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper( );
        VisitationStageDAO dao = new MariadbVisitationStageDao(databaseSessionManager, dataMapper);
        await dao.insert(visitationStage);
        expect(visitationStage.name, "Stage 1");
        expect(visitationStage.visitationItineraryId,results.elementAt(0)[0] );

        await databaseSessionManager.commit();
        expect(databaseSessionManager.isOnTransaction, isFalse);


      }catch(e){
        databaseSessionManager.rollback();
        throw e;
      } finally{
        databaseSessionManager.close();

      }
    });

    test("DeleteVisitationStagesDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        expect(databaseSessionManager.isOnTransaction, isTrue);


        VisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper( );
        VisitationStageDAO dao = new MariadbVisitationStageDao(databaseSessionManager, dataMapper);

        Results? results = (await(databaseSessionManager.executeQuery("SELECT ID FROM eclb_dev.VISITATIONSTAGES"))) as Results;


        VisitationStage dto = await dao.findById(results.elementAt(0)[0]) as DefaultVisitationStageDTO;
        expect(dto.id, greaterThan(-1));
        expect(dto.name, "Stage 1");

        expect(await dao.delete(dto.id as Object), isTrue);
        await databaseSessionManager.commit();
        //expect(databaseSessionManager.isOnTransaction, isFalse);

      }catch(e){
        databaseSessionManager.rollback();
        throw e;
      } finally {
        databaseSessionManager.close();
      }
    });

    test("UpdateVisitationStagesDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        expect(databaseSessionManager.isOnTransaction, isTrue);


        VisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper( );
        VisitationStageDAO dao = new MariadbVisitationStageDao(databaseSessionManager, dataMapper);

        Results? results = (await(databaseSessionManager.executeQuery("SELECT ID FROM eclb_dev.VISITATIONSTAGES"))) as Results;


        VisitationStage dto = await dao.findById(results.elementAt(0)[0]) as DefaultVisitationStageDTO;
        expect(dto.id, equals(results.elementAt(0)[0]));
        expect(dto.name, "Stage 1");

        dto.name = "Stage Update";

        expect(await dao.update(dto), isTrue);

        dto = await dao.findByName("Stage Update");
        expect(dto.name, "Stage Update");

        await databaseSessionManager.commit();

      }catch(e){
        databaseSessionManager.rollback();
        throw e;
      } finally {
        databaseSessionManager.close();
      }
    });

    test("FindByIdFindByNameTests", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();

        MariadbVisitationStageDataMapper dataMapper = MariadbVisitationStageDataMapper();

        MariadbVisitationStageDao dao = MariadbVisitationStageDao(databaseSessionManager, dataMapper);

        Results? results = (await(databaseSessionManager.executeQuery("SELECT ID FROM eclb_dev.VISITATIONSTAGES"))) as Results;


        VisitationStage dto = await dao.findByid(results.elementAt(0)[0]) ?? VisitationStageDTO() ;
        expect(dto.id, results.elementAt(0)[0]);
        expect(dto.name, "Stage 1");

        dto = await dao.findByName("Stage 1");
        expect(dto.name, "Stage 1");
        expect(dto.id, results.elementAt(0)[0]);

      }catch (e){
        await databaseSessionManager.rollback();
        throw e;
      } finally{
        await databaseSessionManager.close();
      }
    });


  });
}