import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class TypeOfSimplePatrimonyDAO implements DAO {

  Future<TypeOfSimplePatrimonyDAO> findByDescription(String description);

}