import 'package:portal_eclb/resource/datamapper/patrimony/patrimony_data_mapper.dart';

abstract class AbstractPatrimonyDataMapper implements PatrimonyDataMapper {

  @override
  List generateDeleteStatement(Object id) {
    // TODO: implement generateDeleteStatement
    throw UnimplementedError();
  }

  @override
  List generateFindAllByCountryStatement(String country) {
    // TODO: implement generateFindAllByCountryStatement
    throw UnimplementedError();
  }

  @override
  List generateFindAllByDescriptionStatement(String description) {
    // TODO: implement generateFindAllByDescriptionStatement
    throw UnimplementedError();
  }

  @override
  List generateFindAllByNameStatement(String name) {
    // TODO: implement generateFindAllByNameStatement
    throw UnimplementedError();
  }

  @override
  List generateFindAllByTypeOfPatrimonyId(int typeOfPatrimonyId) {
    // TODO: implement generateFindAllByTypeOfPatrimonyId
    throw UnimplementedError();
  }

  @override
  List generateFindAllByUNESCOCLassification(int unescoClassification) {
    // TODO: implement generateFindAllByUNESCOCLassification
    throw UnimplementedError();
  }

  @override
  List generateFindAllStatement([int limit = 0, int offset = 0]) {
    // TODO: implement generateFindAllStatement
    throw UnimplementedError();
  }

  @override
  List generateFindByIdStatement(Object id) {
    // TODO: implement generateFindByIdStatement
    throw UnimplementedError();
  }

  @override
  List generateInsertStatement(Object dto) {
    // TODO: implement generateInsertStatement
    throw UnimplementedError();
  }

  @override
  List generateUpdateStatement(Object dto) {
    // TODO: implement generateUpdateStatement
    throw UnimplementedError();
  }
}