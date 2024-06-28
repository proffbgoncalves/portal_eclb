import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/dao/dao.dart';

///Esta interface define o contrato para TypeOfPatrimonyDAO. Ela realiza uma herança
///de tipo da interface DAO. Ao implementar esta interface, uma classe é responsável
///em encapsular os mecanismos para acessar e manipular dados na tabela TYPESOFPATRIMONIES.
abstract interface class TypeOfPatrimonyDAO implements DAO {

  ///Este método recupera um TypeOfPatrimony utilizando sua descrição.
  Future<TypeOfPatrimony?> findByDescription(String description);
}