import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class PersonDAO implements DAO {

  Future<List> findByName(String name);
}