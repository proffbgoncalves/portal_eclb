import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class ActingDAO implements DAO {

  Future<ActingDAO> findByDescription(String description);

}