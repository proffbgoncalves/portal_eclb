import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

abstract interface class PatrimonyMovimentationDataMapper implements DataMapper {

  List generateFindAllByDateStatement(DateTime date);

  List generateFindAllByOriginStatement(String origin);

  List generateFindAllByDestinationStatement(String destination);

  List generateFindAllByDescriptionStatement(String description);

}