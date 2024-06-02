import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/resource/datamapper/person/abstract_person_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/person/default_person_dto.dart';

final class MariaDBPersonDataMapper extends AbstractPersonDataMapper {

  @override
  List generateList(Iterable resultSet) {
    throwIf(resultSet.length == 0, new Exception("Persons can not be generated."));

    Results results = resultSet as Results;

    List persons = [];

    for (ResultRow row in results) {

      DefaultPersonDTO dto = new DefaultPersonDTO(id: row[0], name: row[1]);
      persons.add(dto);

    }
    return persons;
  }

  @override
  Object generateObject(Iterable resultSet) {
    throwIf(resultSet.length == 0, new Exception("Person can not be generated."));

    Results results = resultSet as Results;
    return new DefaultPersonDTO(id: results.first[0], name: results.first[1]);
  }

}