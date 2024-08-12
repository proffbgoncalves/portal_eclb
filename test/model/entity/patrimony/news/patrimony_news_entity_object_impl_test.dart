import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/news/patrimony_news_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/news/patrimony_news.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/news/patrimony_news_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/news/patrimony_news_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main() {

  group("PatrimonyNewsEntityObjectImplTest", () {

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

    test("testInsertPatrimonyNews", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyNewsDAO dao = new MockPatrimonyNewsDAO();

      when(daoFactory.createPatrimonyNewsDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        PatrimonyNewsDTO dto = new PatrimonyNewsDTO(
            id: 10,
            title: "Nova Reforma",
            description: "Descrição da reforma",
            patrimonyId: 123,
            typeOfPatrimonyNewsId: 1
        );

        when(dao.insert(dto)).thenAnswer((_) async => true);

        PatrimonyNewsEntityObjectImpl impl = new PatrimonyNewsEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.insert(), isTrue);

        expect(impl.id, greaterThan(0));
        expect(impl.title, "Nova Reforma");
        expect(impl.description, "Descrição da reforma");

        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        databaseSessionManager.rollback();
        rethrow;
      } finally {
        databaseSessionManager.close();
      }
    });

    test("testDeletePatrimonyNewsEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyNewsDAO dao = new MockPatrimonyNewsDAO();

      when(daoFactory.createPatrimonyNewsDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        PatrimonyNewsDTO dto = new PatrimonyNewsDTO(id: 120);

        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);

        PatrimonyNewsEntityObjectImpl impl = new PatrimonyNewsEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.delete(), isTrue);

        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdatePatrimonyNewsEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyNewsDAO dao = new MockPatrimonyNewsDAO();

      when(daoFactory.createPatrimonyNewsDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        PatrimonyNewsDTO dto = new PatrimonyNewsDTO(
            id: 12,
            title: "Atualização Importante",
            description: "Descrição atualizada",
            patrimonyId: 456,
            typeOfPatrimonyNewsId: 2
        );

        PatrimonyNewsEntityObjectImpl impl = new PatrimonyNewsEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

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

    test("testGetByIdPatrimonyNewsEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyNewsDAO dao = new MockPatrimonyNewsDAO();

      when(daoFactory.createPatrimonyNewsDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        PatrimonyNewsDTO dto = new PatrimonyNewsDTO(
            id: 1,
            title: "Notícia Importante",
            description: "Descrição da notícia",
            patrimonyId: 789,
            typeOfPatrimonyNewsId: 3
        );

        when(dao.findById(1)).thenAnswer((_) async => dto);

        PatrimonyNews patrimonyNews = await PatrimonyNewsEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(patrimonyNews.id, equals(1));
        expect(patrimonyNews.title, "Notícia Importante");
        expect(patrimonyNews.description, "Descrição da notícia");

      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetAllPatrimonyNewsEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      PatrimonyNewsDAO dao = new MockPatrimonyNewsDAO();

      when(daoFactory.createPatrimonyNewsDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        List<PatrimonyNews> listForMock = [
          new PatrimonyNewsDTO(
              id: 1,
              title: "Notícia A",
              description: "Descrição A",
              patrimonyId: 100,
              typeOfPatrimonyNewsId: 1
          ),
          new PatrimonyNewsDTO(
              id: 2,
              title: "Notícia B",
              description: "Descrição B",
              patrimonyId: 101,
              typeOfPatrimonyNewsId: 2
          )
        ];

        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);

        List<PatrimonyNews> patrimonyNewsList = (await PatrimonyNewsEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<PatrimonyNews>;

        expect(patrimonyNewsList[0].id, equals(1));
        expect(patrimonyNewsList[0].title, equals("Notícia A"));
        expect(patrimonyNewsList[0].description, equals("Descrição A"));

        expect(patrimonyNewsList[1].id, equals(2));
        expect(patrimonyNewsList[1].title, equals("Notícia B"));
        expect(patrimonyNewsList[1].description, equals("Descrição B"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}
