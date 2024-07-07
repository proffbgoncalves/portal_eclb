import 'package:portal_eclb/resource/dao/patrimony/event/type_of_event_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/media/type_of_media_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/type_of_acting_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Esta interface define o contrato para criação de Data Access Objects (DAO).
///De acordo com o padrão de projeto DAO, os factories são responsáveis em instanciar
///DAOs de um mesmo SGBDR.
abstract interface class DAOFactory {

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///de TypeOfPatrimonyDAO.
  TypeOfPatrimonyDAO createTypeOfPatrimonyDAO(DatabaseSessionManager databaseSessionManager);

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///PatrimonyDAO.
  PatrimonyDAO createPatrimonyDAO(DatabaseSessionManager databaseSessionManager);

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///TypeOfActingDAO.
  TypeOfActingDAO createTypeOfActingDAO(DatabaseSessionManager databaseSessionManager);

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///TypeOfMediaDAO.
  TypeOfMediaDAO createTypeOfMediaDAO(DatabaseSessionManager databaseSessionManager);

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///TypeOfEventDAO.
  TypeOfEventDAO createTypeOfEventDAO(DatabaseSessionManager databaseSessionManager);
}