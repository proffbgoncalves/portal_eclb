import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/historic/patrimony_historic_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/historic/patrimony_historic_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/historic/patrimony_historic.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/historic/patrimony_historic_dao.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/historic/patrimony_historic_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';


void main() {
  group("PatrimonyHistoricEntityObjectTest", () {
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

    test("testCreateAndInsertPatrimonyHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      PatrimonyHistoricDAO dao = MockPatrimonyHistoricDAO();
      when(daoFactory.createPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        PatrimonyHistoricDTO dto = PatrimonyHistoricDTO(id: 1, name: "Historic 1", date: DateTime.now(), narrative: "First Historic", patrimonyID: 1, typeOfPatrimonyHistoricID: 1);
        when(dao.insert(dto)).thenAnswer((_) async => true);
        PatrimonyHistoricEntityObjectImpl impl = PatrimonyHistoricEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.insert(), isTrue);
        impl.id = 1;
        expect(impl.id, greaterThan(0));
        expect(impl.name, "Historic 1");
        expect(impl.date, isNotNull);
        expect(impl.narrative, "First Historic");
        expect(impl.patrimonyID, 1);
        expect(impl.typeOfPatrimonyHistoricID, 1);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testDeletePatrimonyHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      PatrimonyHistoricDAO dao = MockPatrimonyHistoricDAO();
      when(daoFactory.createPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        PatrimonyHistoricDTO dto = PatrimonyHistoricDTO(id: 120);
        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);
        PatrimonyHistoricEntityObjectImpl impl = PatrimonyHistoricEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.delete(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdatePatrimonyHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      PatrimonyHistoricDAO dao = MockPatrimonyHistoricDAO();
      when(daoFactory.createPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        PatrimonyHistoricDTO dto = PatrimonyHistoricDTO(id: 12, name: "Updated Historic", date: DateTime.now(), narrative: "Updated Narrative", patrimonyID: 2, typeOfPatrimonyHistoricID: 2);
        PatrimonyHistoricEntityObjectImpl impl = PatrimonyHistoricEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
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

    test("testGetByIdPatrimonyHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      PatrimonyHistoricDAO dao = MockPatrimonyHistoricDAO();
      when(daoFactory.createPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        PatrimonyHistoricDTO dto = PatrimonyHistoricDTO(id: 1, name: "Historic 1", date: DateTime.now(), narrative: "First Historic", patrimonyID: 1, typeOfPatrimonyHistoricID: 1);
        when(dao.findById(1)).thenAnswer((_) async => dto);
        PatrimonyHistoric patrimonyHistoric = await PatrimonyHistoricEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(patrimonyHistoric.id, equals(1));
        expect(patrimonyHistoric.name, "Historic 1");
        expect(patrimonyHistoric.date, isNotNull);
        expect(patrimonyHistoric.narrative, "First Historic");
        expect(patrimonyHistoric.patrimonyID, 1);
        expect(patrimonyHistoric.typeOfPatrimonyHistoricID, 1);
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testFindAllPatrimonyHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      PatrimonyHistoricDAO dao = MockPatrimonyHistoricDAO();
      when(daoFactory.createPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        List<PatrimonyHistoric> listForMock = [
          PatrimonyHistoricDTO(id: 1, name: "Historic 1", date: DateTime.now(), narrative: "First Historic", patrimonyID: 1, typeOfPatrimonyHistoricID: 1),
          PatrimonyHistoricDTO(id: 2, name: "Historic 2", date: DateTime.now(), narrative: "Second Historic", patrimonyID: 2, typeOfPatrimonyHistoricID: 2)
        ];
        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);
        List? patrimonyHistorics = await PatrimonyHistoricEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0);
        expect(patrimonyHistorics?[0].id, equals(1));
        expect(patrimonyHistorics?[0].name, "Historic 1");
        expect(patrimonyHistorics?[0].date, isNotNull);
        expect(patrimonyHistorics?[0].narrative, "First Historic");
        expect(patrimonyHistorics?[0].patrimonyID, 1);
        expect(patrimonyHistorics?[0].typeOfPatrimonyHistoricID, 1);
        expect(patrimonyHistorics?[1].id, equals(2));
        expect(patrimonyHistorics?[1].name, "Historic 2");
        expect(patrimonyHistorics?[1].date, isNotNull);
        expect(patrimonyHistorics?[1].narrative, "Second Historic");
        expect(patrimonyHistorics?[1].patrimonyID, 2);
        expect(patrimonyHistorics?[1].typeOfPatrimonyHistoricID, 2);
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}
