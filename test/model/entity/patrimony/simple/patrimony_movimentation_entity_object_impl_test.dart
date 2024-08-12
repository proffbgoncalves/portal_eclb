import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/simple/patrimony_movimentation_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/simple/patrimony_movimentation.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/simple/patrimony_movimentation_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/simple/patrimony_movimentation_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main() {
  group("PatrimonyMovimentationEntityObjectImplTest", () {

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

    test("testInsertPatrimonyMovimentation", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyMovimentationDAO dao = new MockPatrimonyMovimentationDAO();
      when(daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        PatrimonyMovimentationDTO dto = new PatrimonyMovimentationDTO(id: 10, date: DateTime.now(), origin: "Armazém A", destination: "Armazém B", description: "Transferência de items", simplePatrimonyId: 1);

        when(dao.insert(dto)).thenAnswer((_) async => true);

        PatrimonyMovimentationEntityObjectImpl impl = new PatrimonyMovimentationEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.insert(), isTrue);

        expect(impl.id, greaterThan(0));
        expect(impl.origin, "Armazém A");
        expect(impl.destination, "Armazém B");
        expect(impl.description, "Transferência de items");

        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        databaseSessionManager.rollback();
        rethrow;
      } finally {
        databaseSessionManager.close();
      }
    });

    test("testDeletePatrimonyMovimentationEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyMovimentationDAO dao = new MockPatrimonyMovimentationDAO();
      when(daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        PatrimonyMovimentationDTO dto = new PatrimonyMovimentationDTO(id: 120);

        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);

        PatrimonyMovimentationEntityObjectImpl impl = new PatrimonyMovimentationEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.delete(), isTrue);

        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdatePatrimonyMovimentationEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyMovimentationDAO dao = new MockPatrimonyMovimentationDAO();
      when(daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        PatrimonyMovimentationDTO dto = new PatrimonyMovimentationDTO(id: 12, date: DateTime.now(), origin: "Armazém A", destination: "Armazém B", description: "descricao foi atualizada", simplePatrimonyId: 1);

        PatrimonyMovimentationEntityObjectImpl impl = new PatrimonyMovimentationEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

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

    test("testGetByIdPatrimonyMovimentationEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyMovimentationDAO dao = new MockPatrimonyMovimentationDAO();
      when(daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        PatrimonyMovimentationDTO dto = new PatrimonyMovimentationDTO(id: 1, date: DateTime.now(), origin: "Armazém A", destination: "Armazém B", description: "exemplo de uma descricao", simplePatrimonyId: 1);

        when(dao.findById(1)).thenAnswer((_) async => dto);

        PatrimonyMovimentation patrimonyMovimentation = await PatrimonyMovimentationEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(patrimonyMovimentation.id, equals(1));
        expect(patrimonyMovimentation.origin, "Armazém A");
        expect(patrimonyMovimentation.destination, "Armazém B");
        expect(patrimonyMovimentation.description, "exemplo de uma descricao");

      } catch(error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetAllPatrimonyMovimentationEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyMovimentationDAO dao = new MockPatrimonyMovimentationDAO();
      when(daoFactory.createPatrimonyMovimentationDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        List<PatrimonyMovimentation> listForMock = [
          new PatrimonyMovimentationDTO(id: 1, date: DateTime.now(), origin: "Armazém A", destination: "Armazém B", description: "descricao 1", simplePatrimonyId: 1),
          new PatrimonyMovimentationDTO(id: 2, date: DateTime.now(), origin: "Armazém C", destination: "Armazém D", description: "descricao 2", simplePatrimonyId: 2)
        ];

        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);

        List<PatrimonyMovimentation> patrimonyMovimentations = (await PatrimonyMovimentationEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<PatrimonyMovimentation>;

        expect(patrimonyMovimentations[0].id, equals(1));
        expect(patrimonyMovimentations[0].origin, equals("Armazém A"));
        expect(patrimonyMovimentations[0].destination, equals("Armazém B"));
        expect(patrimonyMovimentations[0].description, equals("descricao 1"));

        expect(patrimonyMovimentations[1].id, equals(2));
        expect(patrimonyMovimentations[1].origin, equals("Armazém C"));
        expect(patrimonyMovimentations[1].destination, equals("Armazém D"));
        expect(patrimonyMovimentations[1].description, equals("descricao 2"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}
