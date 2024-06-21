import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/entity_object.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Esta classe abstrata implementa parcialmente o contrato definido por EntityObject.
///Nela, são definidos:
///* O atributo para referenciar a identidade do EntityObject;
///* O método de acesso para obter a identidade do EntityObject;
///* Método construtor que recece a identidade do objeto como parâmetro. Este método
///padroniza a inicialização de qualquer EntityObject cuja a classe herde de
///AbstractEntityObject.
abstract class AbstractEntityObject implements EntityObject {

  EnvironmentConfiguration _environmentConfiguration;
  DatabaseSessionManager _databaseSessionManager;

  ///Método construtor padrão. Todas as subclasses devem chamar este construtor.
  AbstractEntityObject(this._databaseSessionManager, this._environmentConfiguration);

  EnvironmentConfiguration get environmentConfiguration =>
      this._environmentConfiguration;

  DatabaseSessionManager get databaseSessionManager => _databaseSessionManager;
}