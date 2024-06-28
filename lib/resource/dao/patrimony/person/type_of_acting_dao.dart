import 'package:portal_eclb/model/patrimony/person/type_of_acting.dart';
import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class TypeOfActingDAO implements DAO {

  Future<TypeOfActing> findByDescription(String description);

}