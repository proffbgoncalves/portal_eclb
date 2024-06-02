import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Subclasse concreta de AbstractDatabaseSessionManager. Ela implementa todo o
///contrato definido pela interface DatabaseSessionManager. Esta classe foi
///implementada como classe aninhada, pois o Dart não possui visibilidade de
///pacote.
final class MariaDBDatabaseSessionManager extends AbstractDatabaseSessionManager {

  MySqlConnection? _connection;
  EnvironmentConfiguration _environmentConfiguration;

  MariaDBDatabaseSessionManager(this._environmentConfiguration);

  Future<bool> open() async {
    if (this._connection == null) {
      ConnectionSettings settings = new ConnectionSettings(
          host: this._environmentConfiguration.get("host"),
          port: this._environmentConfiguration.get<int>("port"),
          user: this._environmentConfiguration.get("user"),
          password: this._environmentConfiguration.get("password"),
          db: this._environmentConfiguration.get("db")
      );

      try {
        this._connection = await MySqlConnection.connect(settings);
        super.isOpened = true;
      } catch(e) {
        String msg = e.toString();

        throw new Exception(msg.split(":")[1]);
      }
    }

    return super.isOpened;
  }

  Future close() async{
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    super.isOpened = false;
    this._connection = null;
    super.isOnTransaction = false;
    await this._connection?.close();
  }

  Future<bool> commit() async {
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    if (!this.isOnTransaction) {
      throw new Exception("Transaction was not started.");
    }
    Results? results;
    try {
      results = await this._connection?.query("COMMIT");
      this.isOnTransaction = false;
    } catch (e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }
    return results != null;
  }

  Future<bool> execute(String sql, [List? values]) async {
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    if (!this.isOnTransaction) {
      throw new Exception("Transaction was not started.");
    }
    if (sql == "") {
      throw new Exception("Statement sql can not be empty.");
    }


    Results? results = null;

    try {
      if (values == null) {
        results = await this._connection?.query(sql);
      } else {
        results = await this._connection?.query(sql, values);
      }
    } catch(e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }

    return results != null;

  }

  Future<Iterable?> executeQuery(String sql, [List<Object>? values]) async {
    throwIf(this._connection == null, new Exception("Session is not opened."));
    throwIf(sql == "", new Exception("Statement sql can not be empty."));

    Results? results;

    try {
      if (values == null) {
        results = await this._connection?.query(sql);
      } else {
        results = await this._connection?.query(sql, values);
      }
    } catch(e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }

    return results;
  }

  String getType() {
    return this._environmentConfiguration.get("dbms");
  }

  Future rollback() async {
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    try {
      this.isOnTransaction = false;
      await this._connection?.query("ROLLBACK");
    } catch (e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }
  }


  Future startTransaction() async {
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    super.isOnTransaction = true;
    await this._connection?.query("START TRANSACTION");
  }

}
