import 'package:portal_eclb/resource/dao/dao.dart';
import 'package:portal_eclb/resource/datamapper/data_mapper.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';

///Esta classe abstrata implementa parcialmente o contrato definido pela interface DAO.
///Ela servirá como superclasse para todas as implementações de DAOs.
abstract class AbstractDAO implements DAO {

  ///Referência para um DatabaseSessionManager. Esse objeto será utilizado como
  ///o mecanismo interação com o SGBDR configurado para a aplicação.
  DatabaseSessionManager _sessionManager;

  ///Referência para um DataMapper. Este objeto será utilizado como mecanismo
  ///para geração de statements SQL. Estes statements serão utilizados nas
  ///operações de manipulação de dados de tabelas de um esquema de banco de dados.
  DataMapper? _dataMapper;

  ///Método construtor para inicializar um DAO. Todo DAO precisa ser inicializado
  ///com um objeto DatabaseSessionManager, a fim de que este objeto possar ser
  ///utilizado para acessar e manipular os dados mantidos em um esquema de banco
  ///de dados.
  AbstractDAO(this._sessionManager, this._dataMapper);

  ///Este método é uma implementação padrão para a operação de inserção de uma
  ///linha em uma tabela de um esquema de banco de dados. Em tabelas cuja chave
  ///primária é gerada de forma autoincremental, este método deve ser sobrescrito,
  ///a fim de obter o valor da chave primária e configurar o DTO com este valor.
  Future<bool> insert(Object dto) async {
    if (!this._sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }
    try {
      List? statement = this._dataMapper?.generateInsertStatement(dto);
      await this._sessionManager.execute(statement?[0], statement?[1]);
      return true;
    } catch(e) {
      throw e;
    }
  }

  ///Este método é a implementação padrão para a operação de atualização de uma
  ///linha em uma tabela de um esquema de banco de dados.
  Future<bool> update(Object dto) async {
    if (!this._sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }
    try {
      List? statement = this._dataMapper?.generateUpdateStatement(dto);
      await this._sessionManager.execute(statement?[0], statement?[1]);
      return true;
    } catch(e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }
  }

  ///Este método é a implementação padrão para a operação de deleção de uma linha
  ///em uma tabela de um esquema de banco de dados.
  Future<bool> delete(Object id) async {
    if (!this._sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }
    try {
      List? statement = this._dataMapper?.generateDeleteStatement(id);
      await this._sessionManager.execute(statement?[0], statement?[1]);
      return true;
    } catch(e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }
  }

  ///Este método é a implementação padrão para a operação de recuperar uma linha
  ///em uma tebela de um esquema de banco de dados.
  Future<Object> findById(Object id) async {
    if (!this._sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }
    try {
      List? statement = this._dataMapper!.generateFindByIdStatement(id);
      var resultSet = await this._sessionManager.executeQuery(statement[0], statement[1]);
      Object? modelObject = this._dataMapper!.generateObject(resultSet!);
      return modelObject;
    } catch(e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }
  }

  ///Este método é a implementação padrão para a operação de recuperar várias linhas
  ///em uma tabela em um esquema de banco de dados.
  Future<List> findAll([int offset = 0, int limit = 0]) async {
    if (!this._sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }
    try {
      List? statement = null;
      if (offset > 0 && limit > 0) {
        statement = this._dataMapper?.generateFindAllStatement(offset, limit);
      } else if (offset == 0 && limit == 0) {
        statement = this._dataMapper?.generateFindAllStatement();
      } else {
        throw new Exception("Invalid parameter for findAll method.");
      }
      var resultSet;
      if (statement?.length == 1) {
        resultSet = await this._sessionManager.executeQuery(statement?[0]);
      } else if (statement?.length == 2) {
        resultSet = await this._sessionManager.executeQuery(statement?[0], statement?[1]);
      }

      if ((resultSet as Iterable).length == 0) {
        throw new Exception("Types of patrimonies table is empty.");
      }

      return this._dataMapper!.generateList(resultSet);
    } catch(e) {
      String msg = e.toString();
      throw new Exception(msg.split(":")[1]);
    }
  }

  ///Retorna o objeto DataMapper definido para o DAO. Este objeto não deve ser
  ///utilizado fora de um DAO.
  DataMapper? get dataMapper => _dataMapper;

  ///Retorna o objeto DatabaseSessionManager definido para o DAO.
  DatabaseSessionManager get sessionManager => _sessionManager;
}