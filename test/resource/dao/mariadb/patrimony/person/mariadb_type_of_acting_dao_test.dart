import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/model/patrimony/person/type_of_acting.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/person/mariadb_type_of_acting_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/type_of_acting_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/person/mariadb_type_of_acting_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/type_of_acting_data_mapper.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/type_of_acting_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main (){

  group("TypeOfActingDAOForMariaDBTest", (){

    setUp(()async{

      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager =  new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        await manager.startTransaction();
        await manager.execute("DELETE FROM TYPESOFACTINGS");
        await manager.execute("INSERT INTO TYPESOFACTINGS (DESCRIPTION) VALUES (?)", ["Natural"]);
        await manager.execute("INSERT INTO TYPESOFACTINGS (DESCRIPTION) VALUES (?)", ["Imaterial"]);
        await manager.execute("INSERT INTO TYPESOFACTINGS (DESCRIPTION) VALUES (?)", ["Cultural"]);
        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });

      test("testInsertTypeOfACtings", () async {
        EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
        MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
        try {
          await manager.open();
          await manager.startTransaction();
          expect(manager.isOnTransaction, isTrue);

          TypeOfActing acting = new TypeOfActingDTO(
              description: "Histórico");
          TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper();
          TypeOfActingDAO dao = new MariaDBTypeOfActingDAO(
              manager, dataMapper);
          await dao.insert(acting);
          expect(acting.id, greaterThan(0));
          expect(acting.description, "Histórico");
          await manager.commit();
          expect(manager.isOnTransaction, isFalse);
        } catch(e) {
          manager.rollback();
          throw e;
        } finally {
          await manager.close();
        }
      });

      test("testDeleteTypeOfActing", () async {
        EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
        MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
        try {
          await manager.open();
          await manager.startTransaction();
          expect(manager.isOnTransaction, isTrue);

          TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper();
          TypeOfActingDAO dao = MariaDBTypeOfActingDAO(manager, dataMapper);

          TypeOfActing dto = await  dao.findByDescription("Natural");

          expect(dto.id, greaterThan(0));
          expect(dto.description, equals("Natural"));

          expect(await dao.delete(dto.id as Object), isTrue);

          await manager.commit();
          expect(manager.isOnTransaction, isFalse);

          expect(await  dao.findByDescription("Natural"), isNull);
        } catch (e) {
          await manager.rollback();
          expect(e.toString(), equals("Exception: Type of acting was not found."));
        } finally {
          await manager.close();
        }
      });

      test("testUpdateTypeOfActing", () async {
        EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
        MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
        try {
          await manager.open();
          await manager.startTransaction();
          expect(manager.isOnTransaction, isTrue);

          TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper();
          TypeOfActingDAO dao = MariaDBTypeOfActingDAO(manager, dataMapper);

          TypeOfActing dto = await  dao.findByDescription("Natural");

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

      test("testFindByIdAndFindByDescriptionTypeOfActing", () async {
        EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
        MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
        try {
          await manager.open();

          TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper();
          TypeOfActingDAO dao = MariaDBTypeOfActingDAO(manager, dataMapper);

          TypeOfActing dto = await  dao.findByDescription("Imaterial");

          expect(dto.id, greaterThan(0));
          expect(dto.description, equals("Imaterial"));

          dto = (await dao.findById(dto.id as Object)) as TypeOfActing;
          //
          // expect(dto.description, equals("Imaterial"));

        } catch (e) {
          throw e;
        } finally {
          await manager.close();
        }
      });

      test("testFindAllTypesOfActings", () async {
        EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
        MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
        try {
          await manager.open();

          TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper();
          TypeOfActingDAO dao = MariaDBTypeOfActingDAO(manager, dataMapper);

          List typesOfActings = await dao.findAll();
          expect(typesOfActings.length, equals(3));

          TypeOfActing typesOfActing = typesOfActings[0];
          expect(typesOfActing.description, equals("Cultural"));

          typesOfActing = typesOfActings[1];
          expect(typesOfActing.description, equals("Imaterial"));

          typesOfActing = typesOfActings[2];
          expect(typesOfActing.description, equals("Natural"));
        } catch (e) {
          throw e;
        } finally {
          await manager.close();
        }
      });

      test("testFindAllTypesOfActingsWithLimitAndOffset", () async {
        EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
        MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
        try {
          await manager.open();

          TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper ();
          TypeOfActingDAO dao = MariaDBTypeOfActingDAO(manager, dataMapper);

          List typesOfActings = await dao.findAll(2, 1);
          expect(typesOfActings.length, equals(2));


          TypeOfActing typeOfActing = typesOfActings[0];
          expect(typeOfActing.description, equals("Imaterial"));

          typeOfActing = typesOfActings[1];
          expect(typeOfActing.description, equals("Natural"));
        } catch (e) {
          throw e;
        } finally {
          await manager.close();
        }
      });

      test("testThrowEsceptionsWithCloseDatabaseSessionManager", () async {

        EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
        MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

        TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper();
        TypeOfActingDAO dao = MariaDBTypeOfActingDAO(manager, dataMapper);

        TypeOfActingDTO dto = new TypeOfActingDTO(description: "Teste Data Transfer Object");

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

        TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper();
        TypeOfActingDAO dao = MariaDBTypeOfActingDAO(manager, dataMapper);

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
            expect(e.toString(), contains("Type of acting was not found."));
          }

        } finally {
          await manager.close();
        }
      });


  });
}