import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

abstract interface class PatrimonyDataMapper implements DataMapper {

  List generateFindAllByNameStatement(String name);

  List generateFindAllByCountryStatement(String country);

  List generateFindAllByDescriptionStatement(String description);

  List generateFindAllByUNESCOCLassification(int unescoClassification);

  List generateFindAllByTypeOfPatrimonyId(int typeOfPatrimonyId);

}