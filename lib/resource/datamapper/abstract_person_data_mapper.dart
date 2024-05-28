import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/person/person.dart';
import 'package:portal_eclb/resource/datamapper/person_data_mapper.dart';

abstract class AbstractPersonDataMapper implements PersonDataMapper {

  @override
  List generateDeleteStatement(Object id) {
    // TODO: implement generateDeleteStatement
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
    throwIf(dto == null, new Exception("DTO parameter is null"));
    throwIf(!(dto is Person), new Exception("DTO is not an instance of Person"));

    Person person = dto as Person;

    throwIf(dto.name == "", new Exception("Name field can not be empty."));

    List statement = ["INSERT INTO PERSONS (NAME) VALUES (?)", [dto.name]];

    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    // TODO: implement generateUpdateStatement
    throw UnimplementedError();
  }

}