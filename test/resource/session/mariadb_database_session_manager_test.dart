import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {
  group("MariaDBDatabaseSessionManagerTest", () {

    test("testOpenAndCloseDabaseSession", () async {
      EnvironmentConfiguration environmentConfiguration =
          await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
          new MariaDBDatabaseSessionManager(environmentConfiguration);

      expect(sessionManager.getType(), equals("MARIADB"));

      await sessionManager.open();

      expect(sessionManager.isOpened, isTrue);

      await sessionManager.close();

      expect(sessionManager.isOpened, isFalse);
    });

    test("testStartTransactionCommit", () async {
      EnvironmentConfiguration environmentConfiguration =
          await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
          new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.open();

        expect(sessionManager.isOpened, isTrue);

        sessionManager.startTransaction();

        await sessionManager.execute("DELETE FROM  eclb_dev.TYPESOFPATRIMONIES");

        await sessionManager.execute(
            "INSERT INTO eclb_dev.TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)",
            ["Material"]);

        await sessionManager.commit();

        expect(sessionManager.isOnTransaction, isFalse);
      } catch (e) {
        sessionManager.rollback();
        rethrow;
      } finally {
        await sessionManager.close();

        expect(sessionManager.isOpened, isFalse);
      }
    });

    test("testStartTransactionCommitRollback", () async {
      EnvironmentConfiguration environmentConfiguration =
          await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
          new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.open();

        expect(sessionManager.isOpened, isTrue);

        sessionManager.startTransaction();

        await sessionManager.execute("DELETE FROM  eclb_dev.TYPESOFPATRIMONIES");

        await sessionManager.execute(
            "INSERT INTO eclb_dev.TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)",
            ["Material"]);

        await sessionManager.commit();

        sessionManager.startTransaction();

        await sessionManager.execute(
            "INSERT INTO eclb_dev.TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)",
            ["Material"]);

        await sessionManager.commit();
      } catch (e) {
        expect(sessionManager.isOnTransaction, isTrue);

        sessionManager.rollback();

        expect(sessionManager.isOnTransaction, isFalse);
      } finally {
        await sessionManager.close();

        expect(sessionManager.isOpened, isFalse);
      }
    });

    test("testTryStartStransaction", () async {
      EnvironmentConfiguration environmentConfiguration =
          await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
          new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.startTransaction();
      } catch (e) {
        expect(e.toString(), contains("Session is not opened."));
      }
    });

    test("testCloseSession", () async {
      EnvironmentConfiguration environmentConfiguration =
          await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
          new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.close();
      } catch (e) {
        expect(e.toString(), contains("Conexão com o banco de dados não foi aberta."));
      }
    });

    test("testTryCommitWithConnectionClosed", () async {
      EnvironmentConfiguration environmentConfiguration =
      await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
      new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.commit();
      } catch (e) {
        expect(e.toString(), contains("Conexão com o banco de dados não foi aberta."));
      }
    });

    test("testTryExecuteWithConnectionClosed", () async {
      EnvironmentConfiguration environmentConfiguration =
      await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
      new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.execute("DELETE FROM eclb_dev.TYPESOFPATRIMONIES");
      } catch (e) {
        expect(e.toString(), contains("Conexão com o banco de dados não foi aberta."));
      }
    });

    test("testTryExecuteWithoutSQLStatement", () async {
      EnvironmentConfiguration environmentConfiguration =
      await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
      new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.open();
        await sessionManager.startTransaction();
        await sessionManager.execute("");
      } catch (e) {
        expect(e.toString(), contains("Exception: SQL não pode ser vazio."));
      } finally {
        await sessionManager.close();
      }
    });

    test("testTryExecuteSQLStatementWithoutStartedTransaction", () async {
      EnvironmentConfiguration environmentConfiguration =
      await EnvironmentConfiguration.fromFile(".env_dev");

      MariaDBDatabaseSessionManager sessionManager =
      new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.open();
        await sessionManager.execute("DELETE FROM eclb_dev.TYPESOFPATRIMONIES");
      } catch (e) {
        expect(e.toString(), contains("Transação não foi iniciada."));
      } finally {
        await sessionManager.close();
      }
    });

    test("testConnectionFailed", () async {
      EnvironmentConfiguration environmentConfiguration =
          await EnvironmentConfiguration.fromFile(".env_test");

      MariaDBDatabaseSessionManager sessionManager =
      new MariaDBDatabaseSessionManager(environmentConfiguration);

      try {
        await sessionManager.open();
      } catch (e) {
        expect(e.toString(), contains("Unknown database \'portal\'"));
      }
    });
  });
}
