import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/historic/type_of_patrimony_historic_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/historic/type_of_patrimony_historic_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/historic/type_of_patrimony_historic.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/historic/type_of_patrimony_historic_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/quiz/quiz_dao.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/historic/type_of_patrimony_historic_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main() {


  group("TypeOfPatrimonyHistoricObjectTest", () {
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

    test("testCreateAndInsertTypeOfPatrimonyNHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      TypeOfPatrimonyHistoricDAO dao = MockTypeOfPatrimonyHistoricDAO();
      when(daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        TypeOfPatrimonyHistoricDTO dto = TypeOfPatrimonyHistoricDTO(id: 1, description: "Livro");
        when(dao.insert(dto)).thenAnswer((_) async => true);
        TypeOfPatrimonyHistoricEntityObjectImpl impl = new TypeOfPatrimonyHistoricEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.insert(), isTrue);
        impl.id = 1;
        expect(impl.id, greaterThan(0));
        expect(impl.description, "Livro");
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
      } finally {
        await databaseSessionManager.close();
      }
    });


    test("testDeleteTypeOfPatrimonyHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      TypeOfPatrimonyHistoricDAO dao = new MockTypeOfPatrimonyHistoricDAO();
      when(daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        TypeOfPatrimonyHistoricDTO dto = new TypeOfPatrimonyHistoricDTO(id: 120);

        dto.id = 120;
        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);
        TypeOfPatrimonyHistoricEntityObjectImpl impl = new TypeOfPatrimonyHistoricEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.delete(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdateTypeOfPatrimonyHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      TypeOfPatrimonyHistoricDAO dao = new MockTypeOfPatrimonyHistoricDAO();
      when(daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        TypeOfPatrimonyHistoricDTO dto = TypeOfPatrimonyHistoricDTO(id: 12, description: "Quiz 12");
        TypeOfPatrimonyHistoricEntityObjectImpl impl = new TypeOfPatrimonyHistoricEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
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

    test("testGetByIdTypeOfPatrimonyHistoricEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      TypeOfPatrimonyHistoricDAO dao = new MockTypeOfPatrimonyHistoricDAO();
      when(daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        TypeOfPatrimonyHistoricDTO dto = new TypeOfPatrimonyHistoricDTO(id: 1, description: "Livro");
        when(dao.findById(1)).thenAnswer((_) async => dto);
        TypeOfPatrimonyHistoric typeOfPatrimonyHistoric = (await TypeOfPatrimonyHistoricEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1));
        typeOfPatrimonyHistoric.id = 1;
        typeOfPatrimonyHistoric.description = "Livro";
        expect(typeOfPatrimonyHistoric.id, equals(1));
        expect(typeOfPatrimonyHistoric.description, "Livro");
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetAllTypeOfPatrimonyEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      TypeOfPatrimonyHistoricDAO dao = new MockTypeOfPatrimonyHistoricDAO();
      when(daoFactory.createTypeOfPatrimonyHistoricDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        List<TypeOfPatrimonyHistoric> listForMock = [
          new TypeOfPatrimonyHistoricDTO(id: 1, description: "Livro 1"),
          new TypeOfPatrimonyHistoricDTO(id: 2, description: "Livro 2")
        ];
        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);
        List<TypeOfPatrimonyHistoric> typeOfPatrimonyHistoric = (await TypeOfPatrimonyHistoricEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<TypeOfPatrimonyHistoric>;
        typeOfPatrimonyHistoric[0].id = 1;
        typeOfPatrimonyHistoric[0].description = "Livro 1";
        typeOfPatrimonyHistoric[1].id = 2;
        typeOfPatrimonyHistoric[1].description = "Livro 2";
        expect(typeOfPatrimonyHistoric[0].id, equals(1));
        expect(typeOfPatrimonyHistoric[0].description, equals("Livro 1"));
        expect(typeOfPatrimonyHistoric[1].id, equals(2));
        expect(typeOfPatrimonyHistoric[1].description, equals("Livro 2"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });


  });


}


