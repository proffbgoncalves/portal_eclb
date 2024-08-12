import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class UserDAO implements DAO {

  Future<List> findAllByPersonId(int personId);

  Future<List> findAllByLogin(String login);

  Future<List> findAllByFunction(String function);

}
