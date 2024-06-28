import 'package:portal_eclb/model/patrimony/media/type_of_media.dart';
import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class TypeOfMediaDAO implements DAO {


  Future<TypeOfMedia> findByDescription(String description);
}