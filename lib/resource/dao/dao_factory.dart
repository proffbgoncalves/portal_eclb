
import 'package:portal_eclb/model/patrimony/news/patrimony_news_media.dart';
import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_element_dao.dart';

import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_stage_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/event/type_of_event_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/historic/type_of_patrimony_historic_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/media/media_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/media/type_of_media_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/news/patrimony_news_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/news/patrimony_news_media_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/patrimony_dao.dart';

import 'package:portal_eclb/resource/dao/patrimony/person/acting_dao.dart';

import 'package:portal_eclb/resource/dao/patrimony/person/notable_person_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/type_of_acting_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/quiz/quiz_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/simple/patrimony_movimentation_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/simple/type_of_simple_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/person/user/user_dao.dart';
import 'package:portal_eclb/resource/dao/person/visitor/visitor_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
//import 'package:portal_eclb/utils/environment_configuration.dart';

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

  ///Este método é responsável em instanciar uma classe que implemente o contrato

  ///PatrimonyNewsMediaDAO.
  PatrimonyNewsMediaDAO createPatrimonyNewsMediaDAO(DatabaseSessionManager databaseSessionManager);

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///TypeOfPatrimonyHistoricDAO.
  TypeOfPatrimonyHistoricDAO createTypeOfPatrimonyHistoricDAO(DatabaseSessionManager databaseSessionManager);

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///QuizDAO.
  QuizDAO createQuizDAO(DatabaseSessionManager databaseSessionManager);

  ///Este método é responsável em instanciar uma classe que implemente o contrato

  ///VisitorDAO.
  VisitorDAO createVisitorDAO(DatabaseSessionManager databaseSessionManager);

  VisitationStageDAO createVisitationStageDAO(DatabaseSessionManager databaseSessionManager);

  NotablePersonDAO createNotablePersonDAO(DatabaseSessionManager databaseSessionManager);

  ActingDAO createActingDAO(DatabaseSessionManager databaseSessionManager);

  VisitationElementDAO createVisitationElementDAO(DatabaseSessionManager databaseSessionManager);

  TypeOfSimplePatrimonyDAO createTypeOfSimplePatrimonyDAO(DatabaseSessionManager databaseSessionManager);

  UserDAO createUserDAO(DatabaseSessionManager databaseSessionManager);

  PatrimonyNewsDAO createPatrimonyNewsDAO(DatabaseSessionManager databaseSessionManager);

  MediaDAO createMediaDAO(DatabaseSessionManager databaseSessionManager);

  PatrimonyMovimentationDAO createPatrimonyMovimentationDAO (DatabaseSessionManager databaseSessionManager);

}