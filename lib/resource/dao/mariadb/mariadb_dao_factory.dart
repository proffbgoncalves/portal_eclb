import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/patrimony/mariadb_type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/datamapper/mariadb/patrimony/mariadb_type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Esta classe implementa um DAOFactory concreto. Este factory é responsável em
///instanciar DAOs capazes de acessar e manipular esquemas de bancos dados gerenciados
///pelo SGBDR MariaDB.
final class MariaDBDAOFactory extends AbstractDAOFactory {

  ///Método construtor respeitando o método construtor da superclasse AbstractDAOFactory.
  MariaDBDAOFactory(super.environmentConfiguration);

  ///Este método é responsável por instanciar a classe MariaDBTypeOfPatrimonyDAO.
  TypeOfPatrimonyDAO createTypeOfPatrimonyDAO() {
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    TypeOfPatrimonyDataMapper dataMapper = new MariaDBTypeOfPatrimonyDataMapper();
    TypeOfPatrimonyDAO dao = new MariaDBTypeOfPatrimonyDAO(sessionManager!, dataMapper);

    return dao;
  }


}