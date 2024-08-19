import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/patrimony/composite/visitation_stage.dart';
import 'package:portal_eclb/model/patrimony/person/notable_person.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/person/mariadb_notable_person_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/notable_person_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/person/mariadb_notable_persons_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/notable_person_data_mapper.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/visitation_stage_dto.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/default_notable_person_dto.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/notable_person_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main(){

  group("MariadbNotablePersonsDAOTest", (){
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

        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.NOTABLEPERSONS");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.PATRIMONYPERSONS");
        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.PERSONS");


        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();


        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.persons (name) VALUES (?), (?), (?)",

            ['John Doe', "Jane Smith", "Alice Johnson "]);

        await databaseSessionManager.commit();
        await databaseSessionManager.startTransaction();


        Results? results = (await databaseSessionManager.executeQuery("SELECT id FROM `eclb_dev`.PERSONS")) as Results;
        print(results);

        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.patrimonypersons (personId, birthday, biography, deathDate, photo) "

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

        await databaseSessionManager.execute("DELETE FROM `eclb_dev`.NOTABLEPERSONS");

        Results? results2 = (await databaseSessionManager.executeQuery("SELECT personId FROM `eclb_dev`.patrimonypersons")) as Results;


        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.notablepersons (patrimonyPersonId) VALUES (?)",
            [results2.elementAt(0)[0]]);
        await databaseSessionManager.execute("INSERT INTO `eclb_dev`.notablepersons (patrimonyPersonId) VALUES (?)",

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


        await manager.execute("DELETE FROM `eclb_dev`.NOTABLEPERSONS");


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


        await manager.execute("DELETE FROM `eclb_dev`.NOTABLEPERSONS");
        await manager.execute("DELETE FROM `eclb_dev`.PATRIMONYPERSONS");
        await manager.execute("DELETE FROM `eclb_dev`.PERSONS");


        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }

    });

    test("InsertNotablePersonDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = await MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        expect(databaseSessionManager.isOnTransaction, isTrue);

        Results? results2 = (await databaseSessionManager.executeQuery("SELECT personId FROM `eclb_dev`.patrimonypersons")) as Results;
        NotablePerson dto = NotablePersonDTO(patrimonyPersonId: results2.elementAt(2)[0]);
        NotablePersonDataMapper dataMapper = MariadbNotablePersonsDataMapper();
        NotablePersonDAO dao = MariadbNotablePersonDAO(databaseSessionManager, dataMapper);


        expect(await dao.insert(dto), isTrue);
        await databaseSessionManager.commit();
        //expect(dto.patrimonyPersonId, results2.elementAt(2)[0]);//como dava erro na hora de atualizar nao comitava



      }catch (e){
        await databaseSessionManager.rollback();
        throw e;
      }finally{
        await databaseSessionManager.close();
      }
    });

    test("DeleteNotablePersonDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = await MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        expect(databaseSessionManager.isOnTransaction, isTrue);

        Results? results2 = (await databaseSessionManager.executeQuery("SELECT personId FROM `eclb_dev`.patrimonypersons")) as Results;

        NotablePersonDataMapper dataMapper = MariadbNotablePersonsDataMapper();
        NotablePersonDAO dao = MariadbNotablePersonDAO(databaseSessionManager, dataMapper);


        expect(await dao.delete(results2.elementAt(1)[0]), isTrue);
        await databaseSessionManager.commit();
        //expect(dto.patrimonyPersonId, results2.elementAt(2)[0]);//como dava erro na hora de atualizar nao comitava



      }catch (e){
        await databaseSessionManager.rollback();
        throw e;
      }finally{
        await databaseSessionManager.close();
      }
    });

    test("UpdateNotablePersonDAOTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = await MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        expect(databaseSessionManager.isOnTransaction, isTrue);

        Results? results2 = (await databaseSessionManager.executeQuery("SELECT personId FROM `eclb_dev`.patrimonypersons")) as Results;

        NotablePersonDataMapper dataMapper = MariadbNotablePersonsDataMapper();
        NotablePersonDAO dao = MariadbNotablePersonDAO(databaseSessionManager, dataMapper);

        NotablePerson dto = await dao.findById(results2.elementAt(1)[0]) as DefaultNotablePersonDTO;
        expect(dto.patrimonyPersonId, (results2.elementAt(1)[0]));
        dto.patrimonyPersonId = results2.elementAt(2)[0];

        expect(await dao.update(dto), isTrue);
        await databaseSessionManager.commit();
        //expect(dto.patrimonyPersonId, results2.elementAt(2)[0]);//como dava erro na hora de atualizar nao comitava



      }catch (e){
        await databaseSessionManager.rollback();
        throw e;
      }finally{
        await databaseSessionManager.close();
      }
    });

    test("FindByIdFindAllTest", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);

      try{
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();

        NotablePersonDataMapper dataMapper = MariadbNotablePersonsDataMapper();
        NotablePersonDAO dao = MariadbNotablePersonDAO(databaseSessionManager, dataMapper);

        Results? results2 = (await databaseSessionManager.executeQuery("SELECT personId FROM `eclb_dev`.patrimonypersons")) as Results;

        NotablePerson dto = await dao.findById(results2.elementAt(1)[0]) as DefaultNotablePersonDTO;
        expect(dto.patrimonyPersonId, results2.elementAt(1)[0]);

        var lista = await dao.findAll(10, 0);
        expect(lista.length, equals(2));

        NotablePerson person1 = lista[0];
        expect(person1.patrimonyPersonId, results2.elementAt(0)[0]);

        NotablePerson person2 = lista[1];
        expect(person2.patrimonyPersonId, results2.elementAt(1)[0]);

      }catch (e){
        await databaseSessionManager.rollback();
        throw e;
      } finally{
        await databaseSessionManager.close();
      }

    });
  });
}