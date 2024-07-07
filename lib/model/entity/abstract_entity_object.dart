import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/entity_object.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Esta classe abstrata implementa parcialmente o contrato definido por EntityObject.
///Nela, são definidos:

abstract class AbstractEntityObject implements EntityObject {

  ///Atributo para armazenar a referência da configuração do ambiente da aplicação.
  EnvironmentConfiguration _environmentConfiguration;

  ///Atributo para armazenar a referência do gerenciador da sessão com banco de dados.
  DatabaseSessionManager _databaseSessionManager;

  ///Método construtor padrão. Todas as subclasses devem chamar este construtor.
  AbstractEntityObject(this._databaseSessionManager, this._environmentConfiguration);

  ///Método de acesso para obter a referência para a configuração do ambiente da
  ///aplicação.
  EnvironmentConfiguration get environmentConfiguration =>
      this._environmentConfiguration;

  ///Método de acesso para obter a referência para o gerenciador da sessão com o
  ///banco de dados.
  DatabaseSessionManager get databaseSessionManager => _databaseSessionManager;
}