import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/mariadb_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/mariadb_type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/media/mariadb_type_of_media_dao.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/person/mariadb_type_of_acting_dao.dart';
<<<<<<< Updated upstream
=======
import 'package:portal_eclb/resource/dao/patrimony/event/type_of_event_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/historic/patrimony_historic_dao.dart';
>>>>>>> Stashed changes
import 'package:portal_eclb/resource/dao/patrimony/media/type_of_media_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/type_of_acting_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/media/mariadb_type_of_media_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/person/mariadb_type_of_acting_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/type_of_media_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/type_of_acting_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/dao/patrimony/exposition/exposition_dao.dart';

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
  ExpositionDAO createExpositionDAO(DatabaseSessionManager databaseSessionManager) {
    throw UnimplementedError();


  }

  @override
  createQuestionDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createQuestionDAO
    throw UnimplementedError();
  }

  @override
  PatrimonyHistoricDAO createPatrimonyHistoricDAO(DatabaseSessionManager databaseSessionManager) {
    // TODO: implement createPatrimonyHistoricDAO
    throw UnimplementedError();
  }

}