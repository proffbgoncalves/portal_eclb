import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/media/media_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/media/media.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/media/media_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/media/media_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main() {

  group("MediaEntityObjectImplTest", ()  {

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

    test("testInsertMedia", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      MediaDAO dao = new MockMediaDAO();

      when(daoFactory.createMediaDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        MediaDTO dto = new MediaDTO(
            id: 10,
            name: "Imagem1",
            description: "um arquivo no formato de imagem aqui",
            file: [1, 2, 3, 4],
            extension: "jpg",
            patrimonyId: 1,
            typesOfMediaId: 2
        );

        when(dao.insert(dto)).thenAnswer((_) async => true);

        MediaEntityObjectImpl impl = new MediaEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.insert(), isTrue);

        expect(impl.id, greaterThan(0));
        expect(impl.name, "Imagem1");

        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        databaseSessionManager.rollback();
        rethrow;
      } finally {
        databaseSessionManager.close();
      }
    });

    test("testDeleteMediaEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();

      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();

      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));

      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      MediaDAO dao = new MockMediaDAO();

      when(daoFactory.createMediaDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        MediaDTO dto = new MediaDTO(id: 120);

        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);

        MediaEntityObjectImpl impl = new MediaEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        expect(await impl.delete(), isTrue);

        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdateMediaEntityObjectImpl", () async {

      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      MediaDAO dao = new MockMediaDAO();

      when(daoFactory.createMediaDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        MediaDTO dto = MediaDTO(id: 12, name: "Updated Image", description: "Updated description");

        MediaEntityObjectImpl impl = new MediaEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

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

    test("testGetByIdMediaEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      MediaDAO dao = new MockMediaDAO();

      when(daoFactory.createMediaDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);

        MediaDTO dto = new MediaDTO(
            id: 1,
            name: "Video1",
            description: "um arquivo de video"
        );

        when(dao.findById(1)).thenAnswer((_) async => dto);

        Media media = await MediaEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(media.id, equals(1));
        expect(media.name, "Video1");

      } catch(error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetAllMediaEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      MediaDAO dao = new MockMediaDAO();

      when(daoFactory.createMediaDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);

        List<Media> listForMock = [
          new MediaDTO(id: 1, name: "Imagem1", description: "uma imagem"),
          new MediaDTO(id: 2, name: "Imagem2", description: "outra imagem")
        ];

        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);

        List<Media> mediaList = (await MediaEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<Media>;

        expect(mediaList[0].id, equals(1));
        expect(mediaList[0].name, equals("Imagem1"));

        expect(mediaList[1].id, equals(2));
        expect(mediaList[1].name, equals("Imagem2"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}
