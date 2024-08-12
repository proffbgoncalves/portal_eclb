import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/person/user/user_entity_object_impl.dart';
import 'package:portal_eclb/model/person/user/user.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/person/user/user_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/person/user/user_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main() {
  group("UserEntityObjectImplTest", () {

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

    test("testInsertUser", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      UserDAO dao = new MockUserDAO();

      when(daoFactory.createUserDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        UserDTO dto = new UserDTO(
            personId: 10,
            login: "devmoreir4",
            password: "password123",
            function: "admin"
        );

        when(dao.insert(dto)).thenAnswer((_) async => true);

        UserEntityObjectImpl impl = new UserEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.insert(), isTrue);

        expect(impl.id, greaterThan(0));
        expect(impl.login, "devmoreir4");
        expect(impl.function, "admin");

        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testDeleteUserEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      UserDAO dao = new MockUserDAO();

      when(daoFactory.createUserDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        UserDTO dto = new UserDTO(personId: 120);

        when(dao.delete(dto.personId as Object)).thenAnswer((_) async => true);

        UserEntityObjectImpl impl = new UserEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.delete(), isTrue);

        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdateUserEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      UserDAO dao = new MockUserDAO();

      when(daoFactory.createUserDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        UserDTO dto = new UserDTO(
            personId: 12,
            login: "updatedUser",
            password: "updatedPassword123",
            function: "manager"
        );

        UserEntityObjectImpl impl = new UserEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

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

    test("testGetByIdUserEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      UserDAO dao = new MockUserDAO();

      when(daoFactory.createUserDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        UserDTO dto = new UserDTO(
            personId: 1,
            login: "userById",
            password: "passwordById",
            function: "user"
        );

        when(dao.findById(1)).thenAnswer((_) async => dto);

        User user = await UserEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(user.personId, equals(1));
        expect(user.login, "userById");
        expect(user.function, "user");

      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetAllUserEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      UserDAO dao = new MockUserDAO();

      when(daoFactory.createUserDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        List<User> listForMock = [
          new UserDTO(
              personId: 1,
              login: "joaozin",
              password: "54321",
              function: "dev"
          ),
          new UserDTO(
              personId: 2,
              login: "devmoreir4",
              password: "12345",
              function: "owner"
          )
        ];

        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);

        List<User> userList = (await UserEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<User>;

        expect(userList[0].personId, equals(1));
        expect(userList[0].login, equals("joaozin"));
        expect(userList[0].function, equals("dev"));

        expect(userList[1].personId, equals(2));
        expect(userList[1].login, equals("devmoreir4"));
        expect(userList[1].function, equals("owner"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}
