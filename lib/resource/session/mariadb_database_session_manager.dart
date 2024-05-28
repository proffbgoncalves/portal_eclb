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

  @override
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
        if (this._connection == null) {
          throw new Exception("Database connection failed.");
        }
        super.isOpened = true;
      } catch(e) {
        String msg = e.toString();

        throw new Exception(msg.split(":")[1]);
      }
    }

    return super.isOpened;
  }

  @override
  Future close() async{
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    print(await this._connection?.close());
    super.isOpened = false;
    this._connection = null;
    super.isOnTransaction = false;
  }

  @override
  Future<bool> commit() async {
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    Results? results;
    try {
      results = await this._connection?.query("COMMIT");
      super.isOnTransaction = false;
    } catch (e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }
    return results != null;
  }

  @override
  Future<bool> execute(String sql, [List? values]) async {
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

  @override
  Future<Iterable?> executeQuery(String sql, [List<Object>? values]) async {
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

    return results;
  }

  @override
  String getType() {
    return this._environmentConfiguration.get("dbms");
  }

  @override
  Future rollback() async {
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    try {
      await this._connection?.query("ROLLBACK");
      super.isOnTransaction = false;
    } catch (e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }
  }

  @override
  Future startTransaction() async {
    if (this._connection == null) {
      throw new Exception("Session is not opened.");
    }
    await this._connection?.query("START TRANSACTION");
    super.isOnTransaction = true;

  }

}
