import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
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
        this.isOpened = true;
        this._connection = await MySqlConnection.connect(settings);
      } catch(e) {
        this.isOpened = false;
        rethrow;
      }
    }

    return super.isOpened;
  }

  Future close() async{
    if (this._connection == null) {
      throw new Exception("Conexão com o banco de dados não foi aberta.");
    }
    super.isOpened = false;
    this._connection = null;
    super.isOnTransaction = false;
    await this._connection?.close();
  }

  Future<bool> commit() async {
    if (this._connection == null) {
      throw new Exception("Conexão com o banco de dados não foi aberta.");
    }
    if (!this.isOnTransaction) {
      throw new Exception("Transação não foi iniciada.");
    }
    Results? results;
    try {
      results = await this._connection?.query("COMMIT");
      this.isOnTransaction = false;
    } catch (e) {
      rethrow;
    }
    return results != null;
  }

  Future<bool> execute(String sql, [List? values]) async {
    if (this._connection == null) {
      throw new Exception("Conexão com o banco de dados não foi aberta.");
    }
    if (!this.isOnTransaction) {
      throw new Exception("Transação não foi iniciada.");
    }
    if (sql == "") {
      throw new Exception("SQL não pode ser vazio.");
    }

    Results? results = null;

    try {
      if (values == null) {
        results = await this._connection?.query(sql);
      } else {
        results = await this._connection?.query(sql, values);
      }
    } catch(e) {
      rethrow;
    }

    return results != null;

  }

  Future<Iterable?> executeQuery(String sql, [List<Object>? values]) async {
    throwIf(this._connection == null, new Exception("Conexão com o banco de dados não foi aberta."));
    throwIf(sql == "", new Exception("SQL não pode ser vazio."));

    Results? results;

    try {
      if (values == null) {
        results = await this._connection?.query(sql);
      } else {
        results = await this._connection?.query(sql, values);
      }
    } catch(e) {
      rethrow;
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
      rethrow;
    }
  }


  Future startTransaction() async {
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    super.isOnTransaction = true;
    await this._connection?.query("START TRANSACTION");
  }

  @override
  DatabaseSessionManager clone() {
    return new MariaDBDatabaseSessionManager(_environmentConfiguration);
  }

}
