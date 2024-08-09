import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/composite/visitation_element_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/composite/visitation_element.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_element_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/visitation_element_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../mocks/portal_eclb_mocks.mocks.dart';
void main() {


  group("VisitationElementEntityObjectImplTest", ()  {

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


    test("testInsertVisitationElement", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      VisitationElementDAO dao = MockVisitationElementDAO();
      when(daoFactory.createVisitationElementDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        VisitationElementDTO dto = VisitationElementDTO(id: 10, description: "Visita");
        when(dao.insert(dto)).thenAnswer((_) async => true);

        VisitationElementEntityObjectImpl visit = new VisitationElementEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await visit.insert(), isTrue);
        expect(dto.id, equals(10));
        expect(visit.id, greaterThan(0));
        expect(visit.description, "Visita");
        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testDeleteVisitationElementEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();

      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();

      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));

      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitationElementDAO dao = new MockVisitationElementDAO();

      when(daoFactory.createVisitationElementDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitationElementDTO dto = new VisitationElementDTO(id: 120);

        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);

        VisitationElementEntityObjectImpl impl = new VisitationElementEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.delete(), isTrue);

        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdadeVisitationElementEntityObjectImpl", () async {

      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitationElementDAO dao = new MockVisitationElementDAO();

      when(daoFactory.createVisitationElementDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitationElementDTO dto = VisitationElementDTO(id: 12, description: "Hora");

        VisitationElementEntityObjectImpl impl = new VisitationElementEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

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

    test("testGetByIdVisitationElementEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitationElementDAO dao = new MockVisitationElementDAO();

      when(daoFactory.createVisitationElementDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);

        VisitationElementDTO dto = new VisitationElementDTO(id: 1, description: "Data");

        when(dao.findById(1)).thenAnswer((_) async => dto);

        VisitationElement visitationelement = await VisitationElementEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(visitationelement.id, equals(1));
        expect(visitationelement.description, "Data");

      } catch(error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetAllVisitationElementEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitationElementDAO dao = new MockVisitationElementDAO();

      when(daoFactory.createVisitationElementDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        List<VisitationElement> listForMock = [
          new VisitationElementDTO(id: 1, description: "Data"),
          new VisitationElementDTO(id: 2, description: "Hora")
        ];

        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);

        List<VisitationElement> VisitationElements = (await VisitationElementEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<VisitationElement>;

        expect(VisitationElements[0].id, equals(1));
        expect(VisitationElements[0].description, equals("Data"));

        expect(VisitationElements[1].id, equals(2));
        expect(VisitationElements[1].description, equals("Hora"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}