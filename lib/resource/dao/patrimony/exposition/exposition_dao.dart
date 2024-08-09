import 'package:portal_eclb/resource/dao/dao.dart';
import 'package:portal_eclb/model/patrimony/exposition/exposition.dart';


abstract interface class ExpositionDAO implements DAO{
  Future<Exposition?> findByid(int id);

  Future<List> findAllByAName(String name);

  Future<List> findAllByDescription(String description);

  findByDescription(String description) {}

}
