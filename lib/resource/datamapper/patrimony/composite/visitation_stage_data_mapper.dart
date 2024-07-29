import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

abstract interface class VisitationStageDataMapper implements DataMapper {

  List generateFindAllByName(String name);

  List generateFindById(int id);

  List generateFindAllByVisitationItineraryId(int visitationItineraryId);

}
