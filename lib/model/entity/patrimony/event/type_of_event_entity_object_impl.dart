import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/event/type_of_event_entity_object.dart';
import 'package:portal_eclb/model/patrimony/event/type_of_event.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/event/type_of_event_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Esta classe concreta realiza uma herança de implementação de AbstractEntityObject.
///Também realiza uma herança de tipo de TypeOfEventEntityObject.
///
/// Esta classe encapsula um objeto de acesso a dados do tipo TypeOfEvent.
/// Também encapsula a camada de acesso a dados.
final class TypeOfEventEntityObjectImpl extends AbstractEntityObject implements TypeOfEventEntityObject {

  ///Atributo para armazenar a referência para uma instância de um DTO.
  TypeOfEvent _dto;

  ///Construtor da classe para inicializar os objetos com objetos do tipo
  ///DatabaseSessionManager e EnvironmentConfiguration. Essa parte do construtor
  ///é herdada de AbstractEntityObject e, por isso, é obrigatório constar a
  ///a chamada à super classe aqui. Também possui um parâmetro dto, que é específico
  ///deste construtor. Ele inicializa o atributo _dto.
  TypeOfEventEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    
    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));

    TypeOfEventDAO dao = factory.createTypeOfEventDAO(databaseSessionManager);

    try {
      return await dao.delete(this._dto.id as Object);
    } catch (error){
      rethrow;
    }
  }

  ///Este método implementa o método abstrato herdado da interface EntityObject.
  ///Ele retornará "true", se a operação de inserção foi realizada com sucesso
  ///pelo sistema gerenciador de banco de dados.
  @override
  Future<bool> insert() async {
    ///Obtém a única instância do injetor de dependência.
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    ///Obtém a dependência de DAOFactory registrada no injetor de dependência,
    ///usando o valor do parâmetro "dbms" do arquivo de configuração.
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    ///A fábrica de objetos de acesso a dados cria um objeto do tipo TypeOfEventDAO.
    TypeOfEventDAO dao = daoFactory.createTypeOfEventDAO(databaseSessionManager);
    try {
      ///O objeto de acesso a dados executa a operação de inserção de dados
      ///na tabela TYPESOFEVENTS. Se a operação for bem sucedida, o objeto de
      ///acesso a dados retornará "true".
      return await dao.insert(this._dto);
    } catch(error) {
      ///Relançará a exceção, se a operação de inserção falhar.
      rethrow;
    }
  }

  @override
  Future<bool> update() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();

    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    TypeOfEventDAO dao = daoFactory.createTypeOfEventDAO(databaseSessionManager);

    try {
      return await dao.update(this._dto);
    } catch (error) {
      rethrow;
    }
  }

  int? get id {
    return this._dto.id;
  }

  void set id(int? id) {
    throw UnimplementedError();
  }

  String? get description {
    return this._dto.description;
  }

  void set description(String? description) {
    this._dto.description = description;
  }

  static Future<TypeOfEvent> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    TypeOfEventDAO dao = daoFactory.createTypeOfEventDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as TypeOfEvent;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List>? getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    TypeOfEventDAO dao = daoFactory.createTypeOfEventDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }


}