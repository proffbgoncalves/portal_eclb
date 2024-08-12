import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class MediaDAO implements DAO {

  Future<List> findAllByFile(List<int> file);

  Future<List> findAllByName(String name);

  Future<List> findAllByDescription(String description);

  Future<List> findAllByExtension(String extension);

  Future<List> findAllByPatrimonyId(int patrimonyId);

  Future<List> findAllByTypesOfMediaId(int typesOfMediaId);

}
