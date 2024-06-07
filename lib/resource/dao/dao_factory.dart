import 'package:portal_eclb/resource/dao/patrimony/patrimony_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/type_of_patrimony_dao.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

///Esta interface define o contrato para criação de Data Access Objects (DAO).
///De acordo com o padrão de projeto DAO, os factories são responsáveis em instanciar
///DAOs de um mesmo SGBDR.
abstract interface class DAOFactory {

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///de TypeOfPatrimonyDAO.
  TypeOfPatrimonyDAO createTypeOfPatrimonyDAO();

  ///Este método é responsável em instanciar uma classe que implemente o contrato
  ///PatrimonyDAO.
  PatrimonyDAO createPatrimonyDAO();
  
}