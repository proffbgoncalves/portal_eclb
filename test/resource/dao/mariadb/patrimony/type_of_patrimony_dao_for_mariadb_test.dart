import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/maria_db_type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/type_of_patrimony_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("TypeOfPatrimonyDAOForMariaDBTest", () {

    setUp(() async {

      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();
        await manager.execute("DELETE FROM TYPESOFPATRIMONIES");
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Natural"]);
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Imaterial"]);
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Cultural"]);
        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }

    });

    test("testInsertTypeOfPatrimony", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        TypeOfPatrimony patrimony = new TypeOfPatrimonyDTO(
            description: "Histórico");
        TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();
        TypeOfPatrimonyDAO dao = new MariaDBTypeOfPatrimonyDAO(
            manager, dataMapper);
        await dao.insert(patrimony);
        expect(patrimony.id, greaterThan(0));
        expect(patrimony.description, "Histórico");
        await manager.commit();
        expect(manager.isOnTransaction, isFalse);
      } catch(e) {
        manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testDeleteTypeOfPatrimony", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();
        TypeOfPatrimonyDAO dao = MariaDBTypeOfPatrimonyDAO(manager, dataMapper);

        TypeOfPatrimony dto = await  dao.findByDescription("Natural");

        expect(dto.id, greaterThan(0));
        expect(dto.description, equals("Natural"));

        expect(await dao.delete(dto.id as Object), isTrue);

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);

        expect(await  dao.findByDescription("Natural"), isNull);
      } catch (e) {
        await manager.rollback();
        expect(e.toString(), equals("Exception: Type of patrimony was not found."));
      } finally {
        await manager.close();
      }
    });

    test("testUpdateTypeOfPatrimony", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();
        TypeOfPatrimonyDAO dao = MariaDBTypeOfPatrimonyDAO(manager, dataMapper);

        TypeOfPatrimony dto = await  dao.findByDescription("Natural");

        expect(dto.id, greaterThan(0));
        expect(dto.description, equals("Natural"));

        dto.description = "Intangível";

        expect(dto.description, equals("Intangível"));

        expect(await dao.update(dto), isTrue);

        dto = await  dao.findByDescription("Intangível");

        expect(dto.description, equals("Intangível"));

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);
      } catch (e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });
    
    test("testFindByIdAndFindByDescriptionTypeOfPatrimony", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();

        TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();
        TypeOfPatrimonyDAO dao = MariaDBTypeOfPatrimonyDAO(manager, dataMapper);

        TypeOfPatrimony dto = await  dao.findByDescription("Imaterial");

        expect(dto.id, greaterThan(0));
        expect(dto.description, equals("Imaterial"));

        dto = (await dao.findById(dto.id as Object)) as TypeOfPatrimony;

        expect(dto.description, equals("Imaterial"));

      } catch (e) {
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testFindAllTypesOfPatrimonies", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();

        TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();
        TypeOfPatrimonyDAO dao = MariaDBTypeOfPatrimonyDAO(manager, dataMapper);

        List typesOfPatrimonies = await dao.findAll();
        expect(typesOfPatrimonies.length, equals(3));

        TypeOfPatrimony typeOfPatrimony = typesOfPatrimonies[0];
        expect(typeOfPatrimony.description, equals("Cultural"));

        typeOfPatrimony = typesOfPatrimonies[1];
        expect(typeOfPatrimony.description, equals("Imaterial"));

        typeOfPatrimony = typesOfPatrimonies[2];
        expect(typeOfPatrimony.description, equals("Natural"));
      } catch (e) {
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testFindAllTypesOffPatrimoniesWithLimitAndOffset", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();

        TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();
        TypeOfPatrimonyDAO dao = MariaDBTypeOfPatrimonyDAO(manager, dataMapper);

        List typesOfPatrimonies = await dao.findAll(2, 1);
        expect(typesOfPatrimonies.length, equals(2));

        TypeOfPatrimony typeOfPatrimony = typesOfPatrimonies[0];
        expect(typeOfPatrimony.description, equals("Imaterial"));

        typeOfPatrimony = typesOfPatrimonies[1];
        expect(typeOfPatrimony.description, equals("Natural"));
      } catch (e) {
        throw e;
      } finally {
        await manager.close();
      }
    });
    
  });
}