import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/media/type_of_media_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/media/type_of_media_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("TypeOfMediaEntityObjectTest", () {

    setUp(() async {
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
        await databaseSessionManager.execute("DELETE FROM TYPESOFMEDIAS");
        await databaseSessionManager.execute("INSERT INTO TYPESOFMEDIAS (DESCRIPTION) VALUES (?)", ["Natural"]);
        await databaseSessionManager.execute("INSERT INTO TYPESOFMEDIAS (DESCRIPTION) VALUES (?)", ["Imaterial"]);
        await databaseSessionManager.execute("INSERT INTO TYPESOFMEDIAS (DESCRIPTION) VALUES (?)", ["Cultural"]);
        await databaseSessionManager.commit();
      } catch(e) {
        await databaseSessionManager.rollback();
        throw e;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testCreateAndInsertTypeOfMediaEntityObject", () async {

      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");

      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

      TypeOfMediaEntityObject entity = new TypeOfMediaEntityObjectImpl(sessionManager, environmentConfiguration, "Teste");

      expect(entity.description, equals("Teste"));

      try {
        await sessionManager.open();
        await sessionManager.startTransaction();

        await entity.insert();
        expect(entity.id, greaterThan(0));

        await sessionManager.commit();
      } catch(e) {
        await sessionManager.rollback();
        throw e;
      } finally {
        await sessionManager.close();
      }

    });

    test("testGetByDescriptionTypeOfMediaEntityObject", () async {
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

      try {
        await sessionManager.open();

        TypeOfMediaEntityObject entity = await TypeOfMediaEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Imaterial");
        expect(entity.description, equals("Imaterial"));
        expect(entity.id, greaterThan(0));
      } catch (e) {
        throw e;
      } finally {
        await sessionManager.close();
      }
    });

  });

  test("testDeleteTypeOfMediaEntityObject", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();
      await sessionManager.startTransaction();

      TypeOfMediaEntityObject entity = await TypeOfMediaEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Imaterial");

      expect(entity.description, equals("Imaterial"));
      expect(await entity.delete(), isTrue);

      await sessionManager.commit();
    } catch(e) {
      await sessionManager.rollback();
      throw e;
    } finally {
      await sessionManager.close();
    }
  });

  test("testUpdateTypeOfMediaEntityObject", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();
      await sessionManager.startTransaction();

      TypeOfMediaEntityObject entity = await TypeOfMediaEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Natural");

      expect(entity.description, equals("Natural"));

      entity.description = "Teste de Atualização";

      expect(await entity.update(), isTrue);

      await sessionManager.commit();

      entity = await TypeOfMediaEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Teste de Atualização");
      expect(entity.description, equals("Teste de Atualização"));
    } catch(e) {
      await sessionManager.rollback();
      throw e;
    } finally {
      await sessionManager.close();
    }
  });

  test("testFindByIdTypeOfMediaEntityObject", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();

      TypeOfMediaEntityObject entity = await TypeOfMediaEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Cultural");
      expect(entity.description, equals("Cultural"));
      expect(entity.id, greaterThan(0));

      TypeOfMediaEntityObject otherEntity = await TypeOfMediaEntityObjectImpl.getById(sessionManager, environmentConfiguration, entity.id!);
      expect(entity.description, equals("Cultural"));
    } catch (e) {
      throw e;
    } finally {
      await sessionManager.close();
    }
  });

  test("testFindAllTypeOfMediaEntityObject", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();

      List<TypeOfMediaEntityObject> entities = await TypeOfMediaEntityObjectImpl.getAll(sessionManager, environmentConfiguration);
      expect(entities.length, equals(2));

      expect(entities[0].description, equals("Cultural"));
      expect(entities[0].id, greaterThan(0));
      expect(entities[1].description, equals("Teste de Atualização"));
      expect(entities[1].id, greaterThan(0));
    } catch (e) {
      throw e;
    } finally {
      await sessionManager.close();
    }
  });

}