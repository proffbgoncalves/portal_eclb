import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("TypeOfPatrimonyEntityObjectTest", () {

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
        await databaseSessionManager.execute("DELETE FROM TYPESOFPATRIMONIES");
        await databaseSessionManager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Natural"]);
        await databaseSessionManager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Imaterial"]);
        await databaseSessionManager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Cultural"]);
        await databaseSessionManager.commit();
      } catch(e) {
        await databaseSessionManager.rollback();
        throw e;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testCreateAndInsertTypeOfPatrimonyEntityObject", () async {

      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");

      TypeOfPatrimonyEntityObject entity = new TypeOfPatimonyEntityObjectImpl(environmentConfiguration, "Teste");

      expect(entity.description, equals("Teste"));

      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

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

    test("testGetByDescriptionTypeOfPatrimonyEntityObject", () async {
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

      try {
        await sessionManager.open();

        TypeOfPatrimonyEntityObject entity = await TypeOfPatimonyEntityObjectImpl.getByDescription(environmentConfiguration, "Imaterial");
        expect(entity.description, equals("Imaterial"));
        expect(entity.id, greaterThan(0));
      } catch (e) {
        throw e;
      } finally {
        await sessionManager.close();
      }
    });

  });

  test("testDeleteTypeOfPatrimonyEntityObject", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();
      await sessionManager.startTransaction();

      TypeOfPatrimonyEntityObject entity = await TypeOfPatimonyEntityObjectImpl.getByDescription(environmentConfiguration, "Imaterial");

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

  test("testUpdateTypeOfPatrimonyEntityObject", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();
      await sessionManager.startTransaction();

      TypeOfPatrimonyEntityObject entity = await TypeOfPatimonyEntityObjectImpl.getByDescription(environmentConfiguration, "Natural");

      expect(entity.description, equals("Natural"));

      entity.description = "Teste de Atualização";

      expect(await entity.update(), isTrue);

      await sessionManager.commit();

      entity = await TypeOfPatimonyEntityObjectImpl.getByDescription(environmentConfiguration, "Teste de Atualização");
      expect(entity.description, equals("Teste de Atualização"));
    } catch(e) {
      await sessionManager.rollback();
      throw e;
    } finally {
      await sessionManager.close();
    }
  });

  test("testFindByIdTypeOfPatrimonyEntityObject", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();

      TypeOfPatrimonyEntityObject entity = await TypeOfPatimonyEntityObjectImpl.getByDescription(environmentConfiguration, "Cultural");
      expect(entity.description, equals("Cultural"));
      expect(entity.id, greaterThan(0));

      TypeOfPatrimonyEntityObject otherEntity = await TypeOfPatimonyEntityObjectImpl.getById(environmentConfiguration, entity.id!);
      expect(entity.description, equals("Cultural"));
    } catch (e) {
      throw e;
    } finally {
      await sessionManager.close();
    }
  });

  test("testFindAllTypeOfPatrimonyEntityObject", () async {
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();

      List<TypeOfPatrimonyEntityObject> entities = await TypeOfPatimonyEntityObjectImpl.getAll(environmentConfiguration);
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