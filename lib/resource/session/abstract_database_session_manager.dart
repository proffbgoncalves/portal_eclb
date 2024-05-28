import 'package:get_it/get_it.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Classe abstrata que implementa parcialmente a interface DatabaseSessionManager.
///Esta classe implementa uma hierarquia de Singletons. As subclasses de
///AbstractDatabaseSessionManager só terão uma única instância cada.
abstract class AbstractDatabaseSessionManager implements DatabaseSessionManager {

  ///Atributo de instância para saber se a sessão está aberta ou não.
  bool _isOpened = false;

  ///Atributo de instância para saber se a sessão está com uma trabsação aberta
  ///ou não.
  bool _isOnTransaction = false;

  ///Método estático para obter as únicas instâncias das subclasses concretas
  ///de AbstractDatabaseSessionManager. As instâncias devem ser obtidas a
  ///partir do nome do SGBDR. Atualmente, este projeto suporta somente um único
  ///SGBDR, que é o MariaDB.
  static DatabaseSessionManager getInstance(EnvironmentConfiguration configuration) {
    throwIf(configuration == null, new Exception("Environment configuration is null."));

    String dbms = configuration.get("dbms");
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    return dependencyInjector.getDatabaseSessionManager(dbms);
  }

  @override
  bool get isOpened => this._isOpened;

  @override
  bool get isOnTransaction => this._isOnTransaction;

  set isOnTransaction(bool value) {
    this._isOnTransaction = value;
  }

  set isOpened(bool value) {
    this._isOpened = value;
  }
}


