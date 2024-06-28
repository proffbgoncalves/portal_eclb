import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/person/type_of_acting.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/abstract_type_of_acting_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/type_of_acting_dto.dart';

final class MariaDBTypeOfActingDataMapper extends AbstractTypeOfActingDataMapper{

  List generateList(Iterable resultSet) {
    if (resultSet.length == 0) {
      throw new Exception("Types of patrimonies can not be generated.");
    }

    Results results = resultSet as Results;

    List typesOfActings = [];

    for(var row in results) {
      TypeOfActing typeOfActing = new TypeOfActingDTO(id: row[0], description: row[1]);
      typesOfActings.add(typeOfActing);
    }
    return typesOfActings;
  }

  @override
  Object generateObject(Iterable resultSet) {
    throwIf(resultSet.length == 0, new Exception("Type os acting can not be generated."));

    Results results = resultSet as Results;

    TypeOfActingDTO dto = new TypeOfActingDTO(id: results.first[0], description: results.first[1]);
    return dto;
  }

  @override
  List generateCountStatement() {
    // TODO: implement generateCountStatement
    throw UnimplementedError();
  }
}