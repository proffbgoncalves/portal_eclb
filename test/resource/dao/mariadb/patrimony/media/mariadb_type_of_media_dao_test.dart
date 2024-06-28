import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/patrimony/media/type_of_media.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/media/mariadb_type_of_media_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/media/type_of_media_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/media/mariadb_type_of_media_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/type_of_media_data_mapper.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/media/type_of_media_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("TypeOfPatrimonyDAOForMariaDBTest", () {

    setUp(() async {

      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();
        await manager.execute("DELETE FROM TYPESOFMEDIAS");
        await manager.execute("INSERT INTO TYPESOFMEDIAS (DESCRIPTION) VALUES (?)", ["Natural"]);
        await manager.execute("INSERT INTO TYPESOFMEDIAS (DESCRIPTION) VALUES (?)", ["Imaterial"]);
        await manager.execute("INSERT INTO TYPESOFMEDIAS (DESCRIPTION) VALUES (?)", ["Cultural"]);
        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }

    });

    test("testInsertTypeOfMedia", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        TypeOfMedia media = new TypeOfMediaDTO(
            description: "Histórico");
        TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();
        TypeOfMediaDAO dao = new MariaDBTypeOfMediaDAO(
            manager, dataMapper);
        await dao.insert(media);
        expect(media.id, greaterThan(0));
        expect(media.description, "Histórico");
        await manager.commit();
        expect(manager.isOnTransaction, isFalse);
      } catch(e) {
        manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testDeleteTypeOfPatrimony", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();
        TypeOfMediaDAO dao = MariaDBTypeOfMediaDAO(manager, dataMapper);

        TypeOfMedia dto = await  dao.findByDescription("Natural");

        expect(dto.id, greaterThan(0));
        expect(dto.description, equals("Natural"));

        expect(await dao.delete(dto.id as Object), isTrue);

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);

        expect(await  dao.findByDescription("Natural"), isNull);
      } catch (e) {
        await manager.rollback();
        expect(e.toString(), equals("Exception: Type of media was not found."));
      } finally {
        await manager.close();
      }
    });

    test("testUpdateTypeOfMedia", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();
        TypeOfMediaDAO dao = MariaDBTypeOfMediaDAO(manager, dataMapper);

        TypeOfMedia dto = await  dao.findByDescription("Natural");

        expect(dto.id, greaterThan(0));
        expect(dto.description, equals("Natural"));

        dto.description = "Intangível";

        expect(dto.description, equals("Intangível"));

        expect(await dao.update(dto), isTrue);

        dto = await  dao.findByDescription("Intangível");

        expect(dto.description, equals("Intangível"));

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);
      } catch (e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testFindByIdAndFindByDescriptionTypeOfMedia", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();

        TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();
        TypeOfMediaDAO dao = MariaDBTypeOfMediaDAO(manager, dataMapper);

        TypeOfMedia dto = await  dao.findByDescription("Imaterial");

        expect(dto.id, greaterThan(0));
        expect(dto.description, equals("Imaterial"));

        dto = (await dao.findById(dto.id as Object)) as TypeOfMedia;

        expect(dto.description, equals("Imaterial"));

      } catch (e) {
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testFindAllTypesOfPatrimonies", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();

        TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper (); // MariaDBTypeOfMediaDataMapper
        TypeOfMediaDAO dao = MariaDBTypeOfMediaDAO(manager, dataMapper);

        List typesOfMedias = await dao.findAll();
        expect(typesOfMedias.length, equals(3));

        TypeOfMedia typeOfMedia = typesOfMedias[0];
        expect(typeOfMedia.description, equals("Cultural"));

        typeOfMedia = typesOfMedias[1];
        expect(typeOfMedia.description, equals("Imaterial"));

        typeOfMedia = typesOfMedias[2];
        expect(typeOfMedia.description, equals("Natural"));
      } catch (e) {
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testFindAllTypesOfMediaWithLimitAndOffset", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();

        TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();
        TypeOfMediaDAO dao = MariaDBTypeOfMediaDAO(manager, dataMapper);

        List typesOfMedias = await dao.findAll(2, 0);
        expect(typesOfMedias.length, equals(2));


        TypeOfMedia typeOfMedia = typesOfMedias[0];
        expect(typeOfMedia.description, equals("Cultural"));

        typeOfMedia = typesOfMedias[1];
        expect(typeOfMedia.description, equals("Imaterial"));
      } catch (e) {
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testThrowEsceptionsWithCloseDatabaseSessionManager", () async {

      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();
      TypeOfMediaDAO dao = MariaDBTypeOfMediaDAO(manager, dataMapper);

      TypeOfMediaDTO dto = new TypeOfMediaDTO(description: "Teste Data Transfer Object");

      try {
        await dao.insert(dto);
      } catch (e) {
        expect(e.toString(), contains("Conexão com o banco de dados não foi aberta."));
      }

      try {
        await dao.update(dto);
      } catch (e) {
        expect(e.toString(), contains("Conexão com o banco de dados não foi aberta."));
      }

      try {
        await dao.delete(10);
      } catch (e) {
        expect(e.toString(), contains("Conexão com o banco de dados não foi aberta."));
      }

      try {
        await dao.findById(10);
      } catch (e) {
        expect(e.toString(), contains("Conexão com o banco de dados não foi aberta."));
      }

      try {
        await dao.findAll();
      } catch (e) {
        expect(e.toString(), contains("Conexão com o banco de dados não foi aberta."));
      }

      try {
        await dao.findByDescription("Material");
      } catch (e) {
        expect(e.toString(), contains("Database session is not opened."));
      }

    });

    test("testThrowOtherExceptions", () async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();
      TypeOfMediaDAO dao = MariaDBTypeOfMediaDAO(manager, dataMapper);

      try {
        await manager.open();

        try {
          await dao.findAll(-1, -1);
        } catch (e) {
          expect(e.toString(), contains("Parâmetros limit e offset são inválidos."));
        }

        try {
          await dao.findAll();
        } catch (e) {
          expect(e.toString(), contains("No record found."));
        }

        try {
          await dao.findByDescription("");
        } catch (e) {
          expect(e.toString(), contains("Description can not be empty"));
        }

        try {
          await dao.findByDescription("Teste");
        } catch (e) {
          expect(e.toString(), contains("Type of media was not found."));
        }

      } finally {
        await manager.close();
      }
    });

  });
}