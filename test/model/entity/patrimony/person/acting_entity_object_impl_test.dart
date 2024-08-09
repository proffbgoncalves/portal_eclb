import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/person/acting_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/person/acting.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/acting_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/acting_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';
void main() {


  group("ActingEntityObjectImplTest", ()  {

    setUp(() async {

      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      if (!dependencyInjector.hasEnvironmentConfiguration()) {
        dependencyInjector.registerEnvironmentConfiguration(environmentConfiguration);
      }
      DatabaseSessionManager databaseSessionManager = new MockDatabaseSessionManager();
      if (!dependencyInjector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))) {
        dependencyInjector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);
      }
      DAOFactory daoFactory = new MockDAOFactory();
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


    test("testInsertActing", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      ActingDAO dao = MockActingDAO();
      when(daoFactory.createActingDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        ActingDTO dto = ActingDTO(id: 5, description: "Olhar");
        when(dao.insert(dto)).thenAnswer((_) async => true);

        ActingEntityObjectImpl visit = new ActingEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await visit.insert(), isTrue);
        expect(visit.id, greaterThan(0));
        expect(visit.description, "Olhar");
        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testDeleteActingEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();

      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();

      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));

      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      ActingDAO dao = new MockActingDAO();

      when(daoFactory.createActingDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        ActingDTO dto = new ActingDTO(id: 120);

        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);

        ActingEntityObjectImpl impl = new ActingEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.delete(), isTrue);

        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdadeActingEntityObjectImpl", () async {

      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      ActingDAO dao = new MockActingDAO();

      when(daoFactory.createActingDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        ActingDTO dto = ActingDTO(id: 12, description: "Hora");

        ActingEntityObjectImpl impl = new ActingEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        when(dao.update(dto)).thenAnswer((_) async => true);

        expect(await impl.update(), isTrue);

        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }

    });

    test("testGetByIdActingEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      ActingDAO dao = new MockActingDAO();

      when(daoFactory.createActingDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);

        ActingDTO dto = new ActingDTO(id: 1, description: "Data");

        when(dao.findById(1)).thenAnswer((_) async => dto);

        Acting acting = await ActingEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(acting.id, equals(1));
        expect(acting.description, "Data");

      } catch(error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetAllActingEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      ActingDAO dao = new MockActingDAO();

      when(daoFactory.createActingDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        List<Acting> listForMock = [
          new ActingDTO(id: 1, description: "Data"),
          new ActingDTO(id: 2, description: "Hora")
        ];

        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);

        List<Acting> acting = (await ActingEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<Acting>;

        expect(acting[0].id, equals(1));
        expect(acting[0].description, equals("Data"));

        expect(acting[1].id, equals(2));
        expect(acting[1].description, equals("Hora"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}