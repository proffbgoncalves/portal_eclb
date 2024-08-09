import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/news/patrimony_news_media_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/news/patrimony_news_media_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/news/patrimony_news_media.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/news/patrimony_news_media_dao.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/news/patrimony_news_media_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main (){

  group("PatrimonyNewsMediaObjectTest", (){

   setUp(() async{

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

   test("testCreateAndInsertPatrimonyNewsMediaEntityObject", () async {
     DependencyInjector dependencyInjector = DependencyInjector.getInstance();
     EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
     DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
     DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
     PatrimonyNewsMediaDAO dao = MockPatrimonyNewsMediaDAO();
     when(daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager)).thenReturn(dao);

     try {
       expect(await databaseSessionManager.open(), isTrue);
       expect(await databaseSessionManager.startTransaction(), isTrue);
       PatrimonyNewsMediaDTO dto = PatrimonyNewsMediaDTO(id: 1, description: "Jornal");
       when(dao.insert(dto)).thenAnswer((_) async => true);
       PatrimonyNewsMediaEntityObjectImpl impl = new PatrimonyNewsMediaEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
       expect(await impl.insert(), isTrue);
       impl.id = 1;
       expect(impl.id, greaterThan(0));
       expect(impl.description, "Jornal");
       expect(await databaseSessionManager.commit(), isTrue);
     } catch (error) {
       await databaseSessionManager.rollback();
     } finally {
       await databaseSessionManager.close();
     }
   });


   test("testDeletePatrimonyNewsMediaEntityObject", () async {
     DependencyInjector dependencyInjector = DependencyInjector.getInstance();
     EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
     DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
     DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
     PatrimonyNewsMediaDAO dao = new MockPatrimonyNewsMediaDAO();
     when(daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager)).thenReturn(dao);

     try {
       expect(await databaseSessionManager.open(), isTrue);
       expect(await databaseSessionManager.startTransaction(), isTrue);
       PatrimonyNewsMediaDTO dto = new PatrimonyNewsMediaDTO(id: 120);
       dto.id = 120;
       when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);
       PatrimonyNewsMediaEntityObjectImpl impl = new PatrimonyNewsMediaEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
       expect(await impl.delete(), isTrue);
       expect(await databaseSessionManager.commit(), isTrue);
     } catch(error) {
       await databaseSessionManager.rollback();
       rethrow;
     } finally {
       await databaseSessionManager.close();
     }
   });

   test("testUpdatePatrimonyNewsMediaEntityObject", () async {
     DependencyInjector dependencyInjector = DependencyInjector.getInstance();
     EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
     DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
     DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
     PatrimonyNewsMediaDAO dao = new MockPatrimonyNewsMediaDAO();
     when(daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager)).thenReturn(dao);

     try {
       expect(await databaseSessionManager.open() , isTrue);
       expect(await databaseSessionManager.startTransaction(), isTrue);
       PatrimonyNewsMediaDTO dto = PatrimonyNewsMediaDTO(id: 12, description: "Documento");
       PatrimonyNewsMediaEntityObjectImpl impl = new PatrimonyNewsMediaEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
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

   test("testGetByIdPatrimonyNewsMediaEntityObject", () async {
     DependencyInjector dependencyInjector = DependencyInjector.getInstance();
     EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
     DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
     DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
     PatrimonyNewsMediaDAO dao = new MockPatrimonyNewsMediaDAO();
     when(daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager)).thenReturn(dao);

     try {
       expect(await databaseSessionManager.open() , isTrue);
       PatrimonyNewsMediaDTO dto = new PatrimonyNewsMediaDTO(id: 1, description: "Jornal");
       when(dao.findById(1)).thenAnswer((_) async => dto);
       PatrimonyNewsMedia patrimonyNewsMedia = (await PatrimonyNewsMediaEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1));
       patrimonyNewsMedia.id = 1;
       patrimonyNewsMedia.description = "Jornal";
       expect(patrimonyNewsMedia.id, equals(1));
       expect(patrimonyNewsMedia.description, "Jornal");
     } catch(error) {
       rethrow;
     } finally {
       await databaseSessionManager.close();
     }
   });

   test("testFindAllPatrimonyEntityObject", () async {
     DependencyInjector dependencyInjector = DependencyInjector.getInstance();
     EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
     DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
     DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
     PatrimonyNewsMediaDAO dao = new MockPatrimonyNewsMediaDAO();
     when(daoFactory.createPatrimonyNewsMediaDAO(databaseSessionManager)).thenReturn(dao);

     try {
       expect(await databaseSessionManager.open(), isTrue);
       List<PatrimonyNewsMedia> listForMock = [
         new PatrimonyNewsMediaDTO(id: 1, description: "Jornal"),
         new PatrimonyNewsMediaDTO(id: 2, description: "Caderno")
       ];
       when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);
       List<PatrimonyNewsMedia> patrimonies = (await PatrimonyNewsMediaEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<PatrimonyNewsMedia>;
       patrimonies[0].id = 1;
       patrimonies[0].description = "Jornal";

       patrimonies[1].id = 2;
       patrimonies[1].description = "Caderno";

       expect(patrimonies[0].id, equals(1));
       expect(patrimonies[0].description, equals("Jornal"));
       expect(patrimonies[1].id, equals(2));
       expect(patrimonies[1].description, equals("Caderno"));
     } catch (error) {
       rethrow;
     } finally {
       await databaseSessionManager.close();
     }
   });


  });


}