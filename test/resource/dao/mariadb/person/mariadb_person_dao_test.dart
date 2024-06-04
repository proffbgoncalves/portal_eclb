import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/person/person.dart';
import 'package:portal_eclb/resource/dao/mariadb/person/mariadb_person_dao.dart';
import 'package:portal_eclb/resource/dao/person/person_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/person/mariadb_person_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/person/person_data_mapper.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/person/abstract_person_dto.dart';
import 'package:portal_eclb/transferency/dto/person/default_person_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("MariaDBPersonDAOTest", () {

    setUp(() async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        await manager.startTransaction();

        await manager.execute("DELETE FROM PERSONS");
        await manager.execute("INSERT INTO PERSONS (NAME) VALUES (?)", ["José"]);
        await manager.execute("INSERT INTO PERSONS (NAME) VALUES (?)", ["Pedro"]);
        await manager.execute("INSERT INTO PERSONS (NAME) VALUES (?)", ["Marcos"]);

        manager.commit();
      } catch (e) {
        await manager.rollback();
        rethrow;
      } finally {
        await manager.close();
      }
    });

    test("testInsertPerson", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        PersonDataMapper dataMapper = new MariaDBPersonDataMapper();
        Person dto = new DefaultPersonDTO(name: "João");

        PersonDAO dao = new MariaDBPersonDAO(manager, dataMapper);

        expect(await dao.insert(dto), isTrue);
        expect(dto.id, greaterThan(0));
        expect(dto.name, equals("João"));

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);
      } catch(e) {
        await manager.rollback();
        expect(manager.isOnTransaction, isFalse);
        rethrow;
      } finally {
        await manager.close();
        expect(manager.isOnTransaction, isFalse);
      }
    });

    test("testFindByName", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        PersonDataMapper dataMapper = MariaDBPersonDataMapper();
        MariaDBPersonDAO dao = new MariaDBPersonDAO(manager, dataMapper);

        List persons = await dao.findByName("o");
        expect(persons.length, equals(3));

        expect((persons[0] as Person).name, equals("José"));
        expect((persons[1] as Person).name, equals("Pedro"));
        expect((persons[2] as Person).name, equals("Marcos"));

      } catch(e) {
        rethrow;
      } finally {
        await manager.close();
        expect(manager.isOnTransaction, isFalse);
      }
    });

    test("testDeletePersons", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        PersonDataMapper dataMapper = MariaDBPersonDataMapper();
        MariaDBPersonDAO dao = new MariaDBPersonDAO(manager, dataMapper);

        List persons = await dao.findByName("o");
        expect(persons.length, equals(3));

        expect((persons[0] as Person).name, equals("José"));
        expect((persons[1] as Person).name, equals("Pedro"));
        expect((persons[2] as Person).name, equals("Marcos"));

        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        await dao.delete((persons[0] as Person).id!);
        await dao.delete((persons[1] as Person).id!);
        await dao.delete((persons[2] as Person).id!);

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);

        try {
          persons = await dao.findByName("o");
        } catch (e) {
          expect(e.toString(), contains("No record found."));
        }

      } catch(e) {
        await manager.rollback();
        expect(manager.isOnTransaction, isFalse);
        rethrow;
      } finally {
        await manager.close();
        expect(manager.isOnTransaction, isFalse);
      }
    });

    test("testFindAllPersons", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        PersonDataMapper dataMapper = MariaDBPersonDataMapper();
        MariaDBPersonDAO dao = new MariaDBPersonDAO(manager, dataMapper);

        List persons = await dao.findAll();
        expect(persons.length, equals(3));

        expect((persons[0] as Person).name, equals("José"));
        expect((persons[1] as Person).name, equals("Pedro"));
        expect((persons[2] as Person).name, equals("Marcos"));

      } catch(e) {
        rethrow;
      } finally {
        await manager.close();
        expect(manager.isOnTransaction, isFalse);
      }
    });

    test("testUpdatesPersons", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        PersonDataMapper dataMapper = MariaDBPersonDataMapper();
        MariaDBPersonDAO dao = new MariaDBPersonDAO(manager, dataMapper);

        List persons = await dao.findByName("o");
        expect(persons.length, equals(3));

        expect((persons[0] as Person).name, equals("José"));
        expect((persons[1] as Person).name, equals("Pedro"));
        expect((persons[2] as Person).name, equals("Marcos"));

        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        (persons[0] as Person).name = "Antônio";

        expect(await dao.update(persons[0]), isTrue);

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);

        persons = await dao.findByName("Antônio");
        expect(persons.length, equals(1));

        expect((persons[0] as Person).name, equals("Antônio"));

      } catch(e) {
        await manager.rollback();
        expect(manager.isOnTransaction, isFalse);
        rethrow;
      } finally {
        await manager.close();
        expect(manager.isOnTransaction, isFalse);
      }
    });

    test("testFindByIdPersons", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        PersonDataMapper dataMapper = MariaDBPersonDataMapper();
        MariaDBPersonDAO dao = new MariaDBPersonDAO(manager, dataMapper);

        List persons = await dao.findAll();
        expect(persons.length, equals(3));

        Person person = persons[0];

        Person result = (await dao.findById(person.id as Object) as Person);
        expect(person.id, equals(result.id));
        expect(person.name, equals(result.name));

      } catch(e) {
        rethrow;
      } finally {
        await manager.close();
        expect(manager.isOnTransaction, isFalse);
      }
    });

  });

}