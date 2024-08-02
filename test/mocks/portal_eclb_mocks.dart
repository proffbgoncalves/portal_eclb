import 'package:mockito/annotations.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';

import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/person/visitor/mariadb_visitor_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/event/type_of_event_dao.dart';
import 'package:portal_eclb/resource/dao/person/visitor/visitor_dao.dart';

import 'package:portal_eclb/resource/dao/patrimony/event/type_of_event_dao.dart';

import 'package:portal_eclb/resource/session/database_session_manager.dart';

///Esta anotação é uma facilidde oferecida pela biblioteca mockito. Ela é responsável
///em gerar as classes de Mock Objects para o processo de Mocking (Mockagem),
///quando estamos implementando classes que possuem dependência que ainda não foram
///implementadas concretamente, mas já existe uma definição do contrato de métodos
/// ou interface.
///
/// Aqui devemos incluir as interfaces requeridas nas implementações e para a criação
/// de Mock Objects durante a escrita de testes de unidade. O nome das interfaces
/// devem ser incluídos em uma lista, como pode ser visto abaixo.
///
/// Sempre que se desejar criar ou atualizar os mocks, você deverá executar
/// o seguinte comando no terminal: dart run build_runner build. Esse comando
/// vai gerar um arquivo contendo todas as classes Mocks para o nosso projeto.
/// O arquivo gerado é portal_eclb_mocks.mocks.dart.
///
/// Lembre-se de ter o git instalado no seu computador.
@GenerateMocks([
  DatabaseSessionManager,
  DAOFactory,
  TypeOfEventDAO,
  VisitorDAO,
  TypeOfEventDAO

])
void main(){}