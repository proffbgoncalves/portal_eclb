import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

abstract interface class MediaDataMapper implements DataMapper {

  List generateFindAllByNameStatement(String name);

  List generateFindAllByExtensionStatement(String extension);

  List generateFindAllByDescriptionStatement(String description);

  List generateFindAllByPatrimonyId(int patrimonyId);
}