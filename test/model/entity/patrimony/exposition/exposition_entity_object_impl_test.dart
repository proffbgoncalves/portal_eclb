import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/exposition/exposition_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/exposition/exposition_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/exposition/exposition.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/exposition/exposition_dao.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/exposition/exposition_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';


import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main() {
  group("ExpositionEntityObjectTest", () {
    setUp(() async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      if (!dependencyInjector.hasEnvironmentConfiguration()) {
        dependencyInjector.registerEnvironmentConfiguration(environmentConfiguration);
      }
      DatabaseSessionManager databaseSessionManager = MockDatabaseSessionManager();
      if (!dependencyInjector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))) {
        dependencyInjector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);
      }

      DAOFactory daoFactory = MockDAOFactory();
      if (!dependencyInjector.hasDAOFactory(environmentConfiguration.get("dbms"))) {
        dependencyInjector.registerDAOFactory(environmentConfiguration.get("dbms"), daoFactory);
      }
      when(databaseSessionManager.clone()).thenReturn(databaseSessionManager);
      when(databaseSessionManager.close()).thenAnswer((_) async => {});
      when(databaseSessionManager.rollback()).thenAnswer((_) async => {});
      when(databaseSessionManager.open()).thenAnswer((_) async => true);
      when(databaseSessionManager.startTransaction()).thenAnswer((_) async => true);
      when(databaseSessionManager.commit()).thenAnswer((_) async => true);
    });

    test("testCreateAndInsertExpositionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      ExpositionDAO dao = MockExpositionDAO();
      when(daoFactory.createExpositionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        ExpositionDTO dto = ExpositionDTO(id: 1, name: "Expo 1", description: "First Exposition");
        when(dao.insert(dto)).thenAnswer((_) async => true);
        ExpositionEntityObjectImpl impl = ExpositionEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.insert(), isTrue);
        impl.id = 1;
        expect(impl.id, greaterThan(0));
        expect(impl.name, "Expo 1");
        expect(impl.description, "First Exposition");
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testDeleteExpositionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      ExpositionDAO dao = MockExpositionDAO();
      when(daoFactory.createExpositionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        ExpositionDTO dto = ExpositionDTO(id: 120);
        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);
        ExpositionEntityObjectImpl impl = ExpositionEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.delete(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdateExpositionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      ExpositionDAO dao = MockExpositionDAO();
      when(daoFactory.createExpositionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        ExpositionDTO dto = ExpositionDTO(id: 12, name: "Expo Update", description: "Updated Description");
        ExpositionEntityObjectImpl impl = ExpositionEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        when(dao.update(dto)).thenAnswer((_) async => true);
        expect(await impl.update(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetByIdExpositionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      ExpositionDAO dao = MockExpositionDAO();
      when(daoFactory.createExpositionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        ExpositionDTO dto = ExpositionDTO(id: 1, name: "Expo 1", description: "First Exposition");
        when(dao.findById(1)).thenAnswer((_) async => dto);
        Exposition exposition = await ExpositionEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(exposition.id, equals(1));
        expect(exposition.name, "Expo 1");
        expect(exposition.description, "First Exposition");
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testFindAllExpositionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      ExpositionDAO dao = MockExpositionDAO();
      when(daoFactory.createExpositionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        List<Exposition> listForMock = [
          ExpositionDTO(id: 1, name: "Expo 1", description: "First Exposition"),
          ExpositionDTO(id: 2, name: "Expo 2", description: "Second Exposition")
        ];
        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);
        List expositions = await ExpositionEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0);
        expect(expositions[0].id, equals(1));
        expect(expositions[0].name, "Expo 1");
        expect(expositions[0].description, "First Exposition");
        expect(expositions[1].id, equals(2));
        expect(expositions[1].name, "Expo 2");
        expect(expositions[1].description, "Second Exposition");
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}
