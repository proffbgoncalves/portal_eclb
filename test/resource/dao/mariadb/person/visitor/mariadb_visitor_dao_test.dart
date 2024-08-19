import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/person/visitor/visitor.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/person/visitor/mariadb_visitor_dao.dart';
import 'package:portal_eclb/resource/dao/person/visitor/visitor_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/person/visitor/mariadb_visitor_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/person/visitor/visitor_data_mapper.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/person/visitor/default_visitor_dto.dart';
import 'package:portal_eclb/transferency/dto/person/visitor/visitor_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main(){

  group("MariaDBVisitorDAOTest", (){

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



        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.patrimonies (name, description, "

            "unescoClassification, typeOfPatrimonyId, compositePatrimonyId,"
            " hasLocation, country, state, city, district, address, postalCode, longitude, latitude,"
            " altitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?),"
            "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?), (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            ['Eiffel Tower', 'Temp description', 1, results.elementAt(0)[0], null, 1, 'France', 'Île-de-France', 'Paris', 'Temp district', 'Temp address', 75007, 0, 0, 0,
              'Great Wall of China', 'Temp description', 2, results.elementAt(1)[0], null, 1, 'China', 'Beijing', 'Beijing', 'Temp district', 'Temp address', 100000, 0, 0, 0,
              'Niagara Falls', 'Temp description', 3, results.elementAt(2)[0], null, 1, 'USA', 'New York', 'Niagara Falls', 'Temp district', 'Temp address', 14303, 0, 0, 0]);


        Results? results2 = (await databaseSessionManager.executeQuery("SELECT id  FROM `eclb_dev`.PATRIMONIES")) as Results;


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

        Results? results4 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.MEMORIES")) as Results;


        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.VISITORS (PERSONID, ADDRESS, NUMBER, COMPLEMENTO, DISTRICT, CITY, STATE, POSTALCODE, PHONE, EMAIL, MEMORYID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            [results3.elementAt(0)[0], "rua", 100, "ali", "centro", "bji","rj",
              "100", "2299", "@gmail.com",results4.elementAt(0)[0]]);
        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.VISITORS (PERSONID, ADDRESS, NUMBER, COMPLEMENTO, DISTRICT, CITY, STATE, POSTALCODE, PHONE, EMAIL, MEMORYID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",

            [results3.elementAt(1)[0], "rua", 100, "ali", "centro", "bji","rj",
              "100", "2299", "@gmail2.com",results4.elementAt(1)[0]]);

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

        //print("deletando tudo -------------------------------------------");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }

    });

    test("InsertVisitorDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();

        Results? results3 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.PERSONS")) as Results;

        Results? results4 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.MEMORIES")) as Results;

        Visitor dto = VisitorDTO(
            personId: results3.elementAt(2)[0],
            memoryId: results4.elementAt(2)[0],
            address: "rua",
            city: "bji",
            state: "rj",
            number: 100,
            complemento: "ali",
            district: "centro",
            phone: "2299",
            postalCode: "100",
            email: "@gmail3.com"
        );
        VisitorDataMapper dataMapper = MariadbVisitorDataMapper();
        VisitorDAO dao = MariadbVisitorDAO(databaseSessionManager, dataMapper);

        await dao.insert(dto);
        //expect(dto.personId, results3.elementAt(2)[0]);
        await databaseSessionManager.commit();

      }catch (e){
        await databaseSessionManager.rollback();
        throw e;
      } finally{
        await databaseSessionManager.close();
      }

    });

    test("DeleteVisitorDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();

        Results? results3 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.PERSONS")) as Results;


        VisitorDataMapper dataMapper = MariadbVisitorDataMapper();
        VisitorDAO dao = MariadbVisitorDAO(databaseSessionManager, dataMapper);

        await dao.delete(results3.elementAt(0)[0]);
        //expect(dto.personId, results3.elementAt(2)[0]);
        await databaseSessionManager.commit();

      }catch (e){
        await databaseSessionManager.rollback();
        throw e;
      } finally{
        await databaseSessionManager.close();
      }

    });

    test("UpdateVisitorDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();

        Results? results3 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.PERSONS")) as Results;


        VisitorDataMapper dataMapper = MariadbVisitorDataMapper();
        VisitorDAO dao = MariadbVisitorDAO(databaseSessionManager, dataMapper);

        Visitor dto = await dao.findById(results3.elementAt(1)[0]) as DefaultVisitorDTO;
        dto.email = "@gmailUpdate.com";
        await dao.update(dto);
        expect(dto.email, "@gmailUpdate.com");
        await databaseSessionManager.commit();

      }catch (e){
        await databaseSessionManager.rollback();
        throw e;
      } finally{
        await databaseSessionManager.close();
      }

    });

    test("FindByIDFindByEmailFindAllTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();

        Results? results3 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.PERSONS")) as Results;


        VisitorDataMapper dataMapper = MariadbVisitorDataMapper();
        VisitorDAO dao = MariadbVisitorDAO(databaseSessionManager, dataMapper);

        Visitor dto = await dao.findById(results3.elementAt(1)[0]) as DefaultVisitorDTO;//por que aqui é default
        expect(dto.email, "@gmail2.com");
        expect(dto.personId, results3.elementAt(1)[0]);

        dto = await dao.findByEmail("@gmail.com") as VisitorDTO;//e aqui não
        expect(dto.email, "@gmail.com");
        expect(dto.personId, results3.elementAt(0)[0]);

        var listDto = await dao.findAll(10, 0);
        expect(listDto.length, equals(2));

        Visitor dto1 = listDto[0];
        expect(dto1.personId, results3.elementAt(0)[0]);

        Visitor dto2 = listDto[1];
        expect(dto2.personId, results3.elementAt(1)[0]);


    }catch (e){
      await databaseSessionManager.rollback();
      print(e);
      throw e;
    } finally{
    await databaseSessionManager.close();
    }
    });

    // test("FindByAddressFindByCityFindByDistrict", () async{
    //   EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    //   MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);
    //
    //   try{
    //     await databaseSessionManager.open();
    //     await databaseSessionManager.startTransaction();
    //
    //     Results? results3 = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.PERSONS")) as Results;
    //
    //
    //   VisitorDataMapper dataMapper = MariadbVisitorDataMapper();
    //   VisitorDAO dao = MariadbVisitorDAO(databaseSessionManager, dataMapper);
    //
    //   List<Visitor> listDto = await dao.findAllByAddress("rua") as List<VisitorDTO>;//por que aqui é default
    //     Visitor dto1 = listDto[0];
    //     expect(dto1.address, "rua");
    //
    //     Visitor dto2 = listDto[1];
    //     expect(dto2.address, "rua");
    //
    //   listDto = await dao.findAllByCity("bji") as List<VisitorDTO>;//e aqui não
    //     dto1 = listDto[0];
    //     expect(dto1.city, "bji");
    //
    //     dto2 = listDto[1];
    //     expect(dto2.city, "bji");
    //
    //   listDto = await dao.findAllByDistrict("centro")as List<VisitorDTO>;
    //     dto1 = listDto[0];
    //     expect(dto1.district, "centro");
    //
    //     dto2 = listDto[1];
    //     expect(dto2.district, "centro");
    //
    //
    //
    //
    //   }catch (e){
    //   await databaseSessionManager.rollback();
    //   print(e);
    //   throw e;
    //   } finally{
    //   await databaseSessionManager.close();
    //   }
    // });

  });
}