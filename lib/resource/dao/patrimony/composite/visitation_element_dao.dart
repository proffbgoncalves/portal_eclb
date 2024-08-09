import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class VisitationElementDAO implements DAO {

  Future<VisitationElementDAO> findByDescription(String description);

}