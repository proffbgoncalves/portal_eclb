import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

abstract interface class PatrimonyNewsDataMapper implements DataMapper {

  List generateFindByTitleStatement(String title);

  List generateFindByDescriptionStatement(String description);
}