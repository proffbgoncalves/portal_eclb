import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/abstract_notable_person_data_mapper.dart';

import 'package:portal_eclb/transferency/dto/patrimony/person/default_notable_person_dto.dart';


final class MariadbNotablePersonsDataMapper extends AbstractNotablePersonDataMapper {
  @override
  List generateList(Iterable resultSet) {
    throwIf(resultSet.length == 0, new Exception("Notable Persons can not be generated."));

    resultSet as Results;
    List notablePersons = [];

    for (ResultRow row in resultSet) {
      DefaultNotablePersonDTO dto = new DefaultNotablePersonDTO(
          patrimonyPersonId: row[0],
      );
      notablePersons.add(dto);
    }
    return notablePersons;
  }

  @override
  Object? generateObject(Iterable resultSet) {
    throwIf(resultSet.length == 0, new Exception("Notable Person can not be generated."));
    resultSet as Results;

    return new DefaultNotablePersonDTO(
        patrimonyPersonId: resultSet.first[0],
    );
  }







}
