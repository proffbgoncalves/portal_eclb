import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/event/type_of_event_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/event/type_of_event_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/event/type_of_event_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main() {

  ///Cria um grupo de testes com nome da classe seguido da palavra "Test". Todos
  ///os testes devem ser criados dentro do grupo.
  group("TypeOfEventEntityObjectImplTest", ()  {

    ///Esta função sempre executa antes que um teste seja executado. Por isso,
    ///toda as configurações que os testes precisarem devem ser definidas aqui.
    ///Essa sequência de passos deve ser realizada em outros testes.
    setUp(() async {
      ///Obtém a única instância do injetor de dependência da aplicação.
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();

      ///Carrega a configuração do ambiente do sistema usando um arquivo .env_dev
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      ///Se o injetor de dependência não possuir uma configuração de sistema, ele registra uma.
      if (!dependencyInjector.hasEnvironmentConfiguration()) {
        dependencyInjector.registerEnvironmentConfiguration(environmentConfiguration);
      }

      ///Cria uma instância Mock contendo os métodos da interface DatabaseSessionManager.
      DatabaseSessionManager databaseSessionManager = new MockDatabaseSessionManager();
      ///Se o injetor de dependências não possuir uma dependência DatabaseSessionManager,
      ///ele registra uma usando o valor do parâmetro de configuração dbms.
      if (!dependencyInjector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))) {
        dependencyInjector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);
      }

      ///Cria uma instância Mock contendo os métodos da interface DAOFactory.
      DAOFactory daoFactory = new MockDAOFactory();
      ///Se o injetor de dependência não possuir uma dependência DAOFactory, ele registra uma
      ///usando o valor do parâmetro de configuração dbms.
      if (!dependencyInjector.hasDAOFactory(environmentConfiguration.get("dbms"))) {
        dependencyInjector.registerDAOFactory(environmentConfiguration.get("dbms"), daoFactory);
      }

      ///Configura o método clone() do mock DatabaseSessionManager. Este método deve
      ///retornar uma cópia do mock DatabaseSessionManager. 
      when(databaseSessionManager.clone()).thenReturn(databaseSessionManager);

      ///Configura o mock DatabaseSessionManager para responder, quando o método
      ///close() for invocado. Ele não fará nada, pois o retorno desse método é void.
      when(databaseSessionManager.close()).thenAnswer((_) async => {});
      ///Configura o mock DatabaseSessionManager para responder, quando o método
      ///rollback() for invocado. Ele não fará nada, pois o retorno desse método é void.
      when(databaseSessionManager.rollback()).thenAnswer((_) async => {});
      ///Configura o mock DatabaseSessionManager para responder, quando o método
      ///open() for invocado. Ele deverá retornar "true" para que o teste passe
      ///na verificação.
      when(databaseSessionManager.open()).thenAnswer((_) async => true);
      ///Configura o mock DatabaseSessionManager para responder, quando o método
      ///startTransaction() for invocado. Ele deverá retornar "true" para que o teste passe
      ///na verificação.
      when(databaseSessionManager.startTransaction()).thenAnswer((_) async => true);
      ///Configura o mock DatabaseSessionManager para responder, quando o método
      ///commit() for invocado. Ele deverá retornar "true" para que o teste passe
      ///na verificação.
      when(databaseSessionManager.commit()).thenAnswer((_) async => true);
    });

    ///Criação de um teste de inserção de um tipo de evento. A sequência de passos
    ///deste teste é padrão, quando se deseja inserir um objeto em um banco de dados.
    ///Aqui está sendo usado a Mockagem as interfaces DatabaseSessionManager,
    ///DAOFactory e TypeOfEventDAO. Para esse teste funcionar, a função setUp deve
    ///ser implementada corretamente.
    test("testInsertTypeOfEvent", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      ///Obtendo a instância da configuração do ambiente da aplicação registrada na
      ///função setUp().
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      ///Obtendo a instância Mock do tipo DatabaseSessionManager registrado na
      ///função setUp().
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      ///Obtendo a instância Mock do tipo DAOFactory registrado na função setUp().
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      ///Cria uma instância Mock de TypeOfEventDAO;
      TypeOfEventDAO dao = new MockTypeOfEventDAO();

      ///Configura o Mock DAOFactory para retornar o mock de TypeOfEventDAO, quando
      ///o método createTypeOfEventDAO for invocado.
      when(daoFactory.createTypeOfEventDAO(databaseSessionManager)).thenReturn(dao);

      try {
        ///Abre uma conexão com o banco de dados e verifica se a conexão foi aberta;
        expect(await databaseSessionManager.open(), isTrue);
        ///Inicia uma transação no sistema gerenciador de banco de dados e
        ///verifica se é verdadeiro.
        expect(await databaseSessionManager.startTransaction(), isTrue);

        ///Cria o objeto de transferência de dados com os valores que deverão ser
        ///inseridos na tabela TYPESOFEVENTS.
        TypeOfEventDTO dto = new TypeOfEventDTO(id: 10, description: "Formatura");

        ///Configura o mock TypeOfEventDAO para quando o método insert for invocado.
        ///O método retorna "true" para simular que a operação foi bem sucedida.
        when(dao.insert(dto)).thenAnswer((_) async => true);

        ///Cria um objeto TypeOfEventEntityObjectImpl, passando o gerenciador de
        ///conexão com o banco de dados, configuração de ambiente da aplicação e
        ///o DTO contendo dados para inserção.
        TypeOfEventEntityObjectImpl impl = new TypeOfEventEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);

        ///Insere os dados na tabela TYPESOFEVENTS.
        expect(await impl.insert(), isTrue);

        ///Se os dados forem inseridos com sucesso, o objeto do tipo
        ///TypeOfEventEntityObjectImpl retornará o valor gerada automaticamente
        ///para a chave primária e a descrição. Nesta mockagemm o valor 10 foi
        ///passado como parâmetro do DTO, porque ainda não temos o mecanismo de
        ///acesso a banco de dados.
        expect(impl.id, greaterThan(0));
        expect(impl.description, "Formatura");

        ///Confirma a operação de inserção no sistema gerenciador de banco de dados
        ///e verifica se é verdadeiro.
        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        ///Desfaz a transação no sistema gerenciador de banco de dados.
        databaseSessionManager.rollback();
        rethrow;
      } finally {
        ///Fecha a conexão com o sistema gerenciador de banco de dados.
        databaseSessionManager.close();
      }
    });
  });
}