import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Esta classe define uma hierarquia de classes fábricas de DAOs. Ela implementa
///o contrato definido pela interface DAOFactory. Neste projeto, todos as subclasses
///de AbstractDAOFactory devem ter somente uma única instância. Cada instância
///é capaz de criar objetos de classes de uma mesma família.
abstract class AbstractDAOFactory implements DAOFactory {

  ///Atributo de instância utilizado para manter a referência de um objeto
  ///EnvironmenteConfiguration. Este objeto é compartilhado com todos os DAOs criados
  ///pelos factories. Este atributo é inicializado quando o construtor de um DAO
  ///é invocado.
  EnvironmentConfiguration _environmentConfiguration;

  ///Este método construtor define um contrato de inicialização para toda a hierarquia
  ///de classes criada a partir desta classe abstrata. Ele define que, toda todas as
  ///classes que herdem de AbstractDAOFactory devem chamar este método construtor, a
  ///fim de garantir que todos os objetos de classes da hierarquia sejam inicializados
  ///com um objeto EnvironmenteConfiguration.
  AbstractDAOFactory(this._environmentConfiguration);

  ///Este método retorna uma instância de DAOFactory, de acordo com os parâmetros
  ///de configuração mantidos por um objeto EnvironmentConfiguration. Sendo mais
  ///específico, de acordo com o parâmetro 'dbms' obtido a partir de objeto
  ///EnvironmentConfiguration, o método retorna o DAOFactory responsável em
  ///instanciar DAOs capazes de acessar e manipular dados em tabelas de um esquema
  ///de banco de dados em um SGBDR configurado para a aplicação.
  static DAOFactory getInstance(EnvironmentConfiguration environmentConfiguration) {
    if (environmentConfiguration == null) {
      throw new Exception("Environment configuration parameter is null.");
    }

    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    return factory;

  }

  EnvironmentConfiguration get environmentConfiguration =>
      _environmentConfiguration;
}