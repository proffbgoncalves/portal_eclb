import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/person/person.dart';
import 'package:portal_eclb/resource/datamapper/person/person_data_mapper.dart';

abstract class AbstractPersonDataMapper implements PersonDataMapper {

  @override
  List generateDeleteStatement(Object id) {
    throwIf(!(id is int), new Exception("Id parameter is not instance of int."));

    List statement =["DELETE FROM PERSONS WHERE ID = ?", [id]];
    return statement;
  }

  @override
  List generateFindAllStatement([int limit = 0, int offset = 0]) {
    if (offset > 0 && limit > 0) {
      return ["SELECT * FROM PERSONS LIMIT ? OFFSET ?", [limit, offset]];
    } else if (offset == 0 && limit == 0) {
      return ["SELECT * FROM PERSONS"];
    } else {
      throw new Exception("Invalid parameter for generateFindAllStatements method.");
    }
  }

  @override
  List generateFindByIdStatement(Object id) {
    throwIf(!(id is int), new Exception("Id parameter is not an instance of int."));

    List statement = ["SELECT * FROM PERSONS WHERE ID = ?", [id]];

    return statement;
  }

  @override
  List generateInsertStatement(Object dto) {
    throwIf(!(dto is Person), new Exception("DTO parameter is not an instance of Person"));

    Person person = dto as Person;

    throwIf(dto.name == "", new Exception("Name field can not be empty."));

    List statement = ["INSERT INTO PERSONS (NAME) VALUES (?)", [dto.name]];

    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    throwIf(!(dto is Person), new Exception("DTO parameter is not instance of Person"));

    Person person = (dto as Person);
    throwIf(person.id == null, new Exception("DTO has an invalid id value."));
    throwIf(person.name == "", new Exception("DTO has an invalid name value."));

    List statement = ["UPDATE PERSONS SET NAME = ? WHERE ID = ?", [person.name, person.id]];

    return statement;
  }

  List generateFindByNameStatement(String name) {
    throwIf(name == "", new Exception("Name parameter can not be empty."));

    List statement = ["SELECT * FROM PERSONS WHERE NAME LIKE ?", ["%"+name+"%"]];

    return statement;
  }

}