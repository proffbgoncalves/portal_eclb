import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/composite/mariadb_visitation_stage_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/mariadb_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/mariadb_type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/media/mariadb_type_of_media_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/person/mariadb_notable_person_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/person/mariadb_type_of_acting_dao.dart';

import 'package:portal_eclb/resource/dao/mariadb/person/visitor/mariadb_visitor_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_stage_dao.dart';


import 'package:portal_eclb/resource/dao/mariadb/person/visitor/mariadb_visitor_dao.dart';
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
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/composite/mariadb_visitation_stage_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/media/mariadb_type_of_media_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/person/mariadb_notable_persons_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/person/mariadb_type_of_acting_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/person/visitor/mariadb_visitor_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/composite/visitation_stage_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/type_of_media_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/notable_person_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/type_of_acting_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/person/visitor/visitor_data_mapper.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';

///Esta classe implementa um DAOFactory concreto. Este factory é responsável em
///instanciar DAOs capazes de acessar e manipular esquemas de bancos dados gerenciados
///pelo SGBDR MariaDB.
final class MariaDBDAOFactory extends AbstractDAOFactory {

  ///Método construtor respeitando o método construtor da superclasse AbstractDAOFactory.
  MariaDBDAOFactory(super._environmentConfiguration);

  ///Este método é responsável por instanciar a classe MariaDBTypeOfPatrimonyDAO.
  TypeOfPatrimonyDAO createTypeOfPatrimonyDAO(DatabaseSessionManager databaseSessionManager) {

    TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();
    TypeOfPatrimonyDAO dao = new MariaDBTypeOfPatrimonyDAO(databaseSessionManager, dataMapper);

    return dao;
  }

  @override
  PatrimonyDAO createPatrimonyDAO(DatabaseSessionManager databaseSessionManager) {
    PatrimonyDataMapper dataMapper = new MariadbPatrimonyDataMapper();

    MariaDBPatrimonyDAO patrimonyDAO = new MariaDBPatrimonyDAO(databaseSessionManager, dataMapper);
    return patrimonyDAO;
  }

  @override
  TypeOfActingDAO createTypeOfActingDAO(DatabaseSessionManager databaseSessionManager) {
    TypeOfActingDataMapper dataMapper = new MariaDBTypeOfActingDataMapper();

    MariaDBTypeOfActingDAO typeOfActingDAO = new MariaDBTypeOfActingDAO(databaseSessionManager, dataMapper);
    return typeOfActingDAO;
  }

  @override
  TypeOfMediaDAO createTypeOfMediaDAO(DatabaseSessionManager databaseSessionManager) {
    TypeOfMediaDataMapper dataMapper = new MariaDBTypeOfMediaDataMapper();

    MariaDBTypeOfMediaDAO typeOfMediaDAO = new MariaDBTypeOfMediaDAO(databaseSessionManager, dataMapper);
    return typeOfMediaDAO;
  }

  @override
  TypeOfEventDAO createTypeOfEventDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createTypeOfEventDAO
    throw UnimplementedError();
  }
  @override
  VisitorDAO createVisitorDAO(DatabaseSessionManager databaseSessionManager) {
    VisitorDataMapper dataMapper = new MariadbVisitorDataMapper();

    MariadbVisitorDAO visitorDAO = new MariadbVisitorDAO(databaseSessionManager, dataMapper);
    return visitorDAO;
  }

  @override
  VisitationStageDAO createVisitationStageDAO(DatabaseSessionManager databaseSessionManager) {
    VisitationStageDataMapper dataMapper = new MariadbVisitationStageDataMapper();

    MariadbVisitationStageDao visitation = new MariadbVisitationStageDao(databaseSessionManager, dataMapper);
   return visitation;
  }

  @override
  NotablePersonDAO createNotablePersonDAO(DatabaseSessionManager databaseSessionManager) {
    NotablePersonDataMapper dataMapper = new MariadbNotablePersonsDataMapper();
    MariadbNotablePersonDAO dao = new MariadbNotablePersonDAO(databaseSessionManager, dataMapper);
    return dao;
  }


  @override
  PatrimonyNewsMediaDAO createPatrimonyNewsMediaDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createPatrimonyNewsMediaDAO
    throw UnimplementedError();
  }

  @override
  QuizDAO createQuizDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createQuizDAO
    throw UnimplementedError();
  }

  @override
  TypeOfPatrimonyHistoricDAO createTypeOfPatrimonyHistoricDAO(DatabaseSessionManager databaseSessionManager ) {
    // TODO: implement createTypeOfPatrimonyHistoricDAO
    throw UnimplementedError();
  }

  @override
  ActingDAO createActingDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createActingDAO
    throw UnimplementedError();
  }

  @override
  TypeOfSimplePatrimonyDAO createTypeOfSimplePatrimonyDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createTypeOfSimplePatrimonyDAO
    throw UnimplementedError();
  }

  @override
  VisitationElementDAO createVisitationElementDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createVisitationElementDAO
    throw UnimplementedError();
  }

  @override
  UserDAO createUserDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createUserDAO
    throw UnimplementedError();
  }

  @override
  PatrimonyNewsDAO createPatrimonyNewsDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createPatrimonyNewsDAO
    throw UnimplementedError();
  }

  @override
  MediaDAO createMediaDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createMediaDAO
    throw UnimplementedError();
  }

  @override
  PatrimonyMovimentationDAO createPatrimonyMovimentationDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createPatrimonyMovimentationDAO
    throw UnimplementedError();
  }

}