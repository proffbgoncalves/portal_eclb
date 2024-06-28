import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

abstract interface class TypeOfActingDataMapper implements DataMapper {

  List generateFindByDescriptionStatement(String name);
}