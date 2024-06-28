import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/patrimony.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/mariadb_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/mariadb_type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/pratrimony_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("MariaDBPatrimonyDAOTest", () {

    int typeOfPatrimonyId;
    int? patrimonyId;

    setUp(() async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();

        await manager.execute("DELETE FROM TYPESOFPATRIMONIES");
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Natural"]);
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Imaterial"]);
        await manager.execute("INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", ["Cultural"]);
        await manager.commit();

        Results? results = (await manager.executeQuery("SELECT * FROM TYPESOFPATRIMONIES WHERE DESCRIPTION = ?", ["Natural"])) as Results;

        typeOfPatrimonyId = results.first[0];
        
        await manager.startTransaction();
        
        await manager.execute(
            "INSERT INTO PATRIMONIES (NAME, DESCRIPTION, UNESCOCLASSIFICATION, TYPEOFPATRIMONYID, HASLOCATION) VALUES (?, ?, ?, ?, ?)",
            ["Rio Itabapoana", "Rio de Bom Jesus", 1, typeOfPatrimonyId, 1]
        );

        results = (await manager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;

        patrimonyId = results.first[0];

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });

    tearDown(() async {
      EnvironmentConfiguration? configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      try {
        await manager.open();
        await manager.startTransaction();

        await manager.execute("DELETE FROM PATRIMONIES");

        await manager.commit();
      } catch(e) {
        await manager.rollback();
        throw e;
      } finally {
        await manager.close();
      }
    });

    test("testInsertPatrimony", () async {

      EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        MariaDBTypeOfPatrimonyDataMapper typeOfPatrimonyDataMapper = new MariaDBTypeOfPatrimonyDataMapper();
        MariaDBTypeOfPatrimonyDAO typeOfPatrimonyDAO = new MariaDBTypeOfPatrimonyDAO(manager, typeOfPatrimonyDataMapper);

        TypeOfPatrimony? typeOfPatrimony = await typeOfPatrimonyDAO.findByDescription("Natural");
        expect(typeOfPatrimony?.description, equals("Natural"));

        PatrimonyDTO patrimonyDTO = new PatrimonyDTO(
            name: "Pico da Bandeira",
            description: "Monumento natural situado na serra do Caparaó",
            unescoClassification: 1,
            typeOfPatrimonyId: typeOfPatrimony?.id,
            hasLocation: 1
        );

        MariadbPatrimonyDataMapper patrimonyDataMapper = new MariadbPatrimonyDataMapper();
        MariaDBPatrimonyDAO patrimonyDAO = new MariaDBPatrimonyDAO(manager, patrimonyDataMapper);

        await patrimonyDAO.insert(patrimonyDTO);

        expect(patrimonyDTO.id, greaterThan(0));


        await manager.commit();
        expect(manager.isOnTransaction, isFalse);
      } catch (error) {

        await manager.rollback();
        expect(manager.isOnTransaction, isFalse);
        rethrow;

      } finally {
        await manager.close();
        expect(manager.isOpened, isFalse);
      }

    });


    test("testDeletePatrimony", () async {

      EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        MariadbPatrimonyDataMapper patrimonyDataMapper = new MariadbPatrimonyDataMapper();
        MariaDBPatrimonyDAO patrimonyDAO = new MariaDBPatrimonyDAO(manager, patrimonyDataMapper);

        await patrimonyDAO.delete(patrimonyId as Object);

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);
      } catch (error) {

        await manager.rollback();
        expect(manager.isOnTransaction, isFalse);
        rethrow;

      } finally {
        await manager.close();
        expect(manager.isOpened, isFalse);
      }

    });

    test("testUpdatePatrimony", () async {
      EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);

      try {
        await manager.open();
        expect(manager.isOpened, isTrue);

        await manager.startTransaction();
        expect(manager.isOnTransaction, isTrue);

        MariadbPatrimonyDataMapper patrimonyDataMapper = new MariadbPatrimonyDataMapper();
        MariaDBPatrimonyDAO patrimonyDAO = new MariaDBPatrimonyDAO(manager, patrimonyDataMapper);

        Patrimony patrimony = (await patrimonyDAO.findById(patrimonyId as Object)) as Patrimony;
        expect(patrimony.id, greaterThan(0));
        expect(patrimony.name, equals("Rio Itabapoana"));

        patrimony.name = "Rio Itapemirim";
        patrimony.description = "Rio de Cachoeiro de Itapemirim";

        await patrimonyDAO.update(patrimony);

        await manager.commit();
        expect(manager.isOnTransaction, isFalse);

        Patrimony patrimony2 = (await patrimonyDAO.findById(patrimonyId as Object)) as Patrimony;
        expect(patrimony2.name, equals("Rio Itapemirim"));
        expect(patrimony2.description, equals("Rio de Cachoeiro de Itapemirim"));

      } catch (error) {

        await manager.rollback();
        expect(manager.isOnTransaction, isFalse);
        rethrow;

      } finally {
        await manager.close();
        expect(manager.isOpened, isFalse);
      }
    });

  });
}