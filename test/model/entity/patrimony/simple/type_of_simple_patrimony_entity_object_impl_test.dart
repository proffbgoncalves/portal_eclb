import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/simple/type_of_simple_patrimony_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/simple/type_of_simple_patrimony.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/simple/type_of_simple_patrimony_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/simple/type_of_simple_patrimony_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';
import '../../../../mocks/portal_eclb_mocks.mocks.dart';
void main() {


  group("TypeOfSimplePatrimonyEntityObjectImplTest", ()  {

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


    test("testInsertTypeOfSimplePatrimony", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      TypeOfSimplePatrimonyDAO dao = MockTypeOfSimplePatrimonyDAO();
      when(daoFactory.createTypeOfSimplePatrimonyDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        TypeOfSimplePatrimonyDTO dto = TypeOfSimplePatrimonyDTO(id: 10, description: "Tipo");
        when(dao.insert(dto)).thenAnswer((_) async => true);

        TypeOfSimplePatrimonyEntityObjectImpl type = new TypeOfSimplePatrimonyEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await type.insert(), isTrue);
        expect(type.id, greaterThan(0));
        expect(type.description, "Tipo");
        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testDeleteTypeOfSimplePatrimonyEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();

      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();

      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));

      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      TypeOfSimplePatrimonyDAO dao = new MockTypeOfSimplePatrimonyDAO();

      when(daoFactory.createTypeOfSimplePatrimonyDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        TypeOfSimplePatrimonyDTO dto = new TypeOfSimplePatrimonyDTO(id: 120);

        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);

        TypeOfSimplePatrimonyEntityObjectImpl impl = new TypeOfSimplePatrimonyEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.delete(), isTrue);

        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdadeTypeOfSimplePatrimonyEntityObjectImpl", () async {

      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      TypeOfSimplePatrimonyDAO dao = new MockTypeOfSimplePatrimonyDAO();

      when(daoFactory.createTypeOfSimplePatrimonyDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        TypeOfSimplePatrimonyDTO dto = TypeOfSimplePatrimonyDTO(id: 12, description: "Idade");

        TypeOfSimplePatrimonyEntityObjectImpl impl = new TypeOfSimplePatrimonyEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

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

    test("testGetByIdTypeOfSimplePatrimonyEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      TypeOfSimplePatrimonyDAO dao = new MockTypeOfSimplePatrimonyDAO();

      when(daoFactory.createTypeOfSimplePatrimonyDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);

        TypeOfSimplePatrimonyDTO dto = new TypeOfSimplePatrimonyDTO(id: 1, description: "Nome");

        when(dao.findById(1)).thenAnswer((_) async => dto);

        TypeOfSimplePatrimony typeofsimple = await TypeOfSimplePatrimonyEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(typeofsimple.id, equals(1));
        expect(typeofsimple.description, "Nome");

      } catch(error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetAllTypeOfSimplePatrimonyEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      TypeOfSimplePatrimonyDAO dao = new MockTypeOfSimplePatrimonyDAO();

      when(daoFactory.createTypeOfSimplePatrimonyDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        List<TypeOfSimplePatrimony> listForMock = [
          new TypeOfSimplePatrimonyDTO(id: 1, description: "Nome"),
          new TypeOfSimplePatrimonyDTO(id: 2, description: "Idade")
        ];

        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);

        List<TypeOfSimplePatrimony> typeofsimple = (await TypeOfSimplePatrimonyEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<TypeOfSimplePatrimony>;

        expect(typeofsimple[0].id, equals(1));
        expect(typeofsimple[0].description, equals("Nome"));

        expect(typeofsimple[1].id, equals(2));
        expect(typeofsimple[1].description, equals("Idade"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}