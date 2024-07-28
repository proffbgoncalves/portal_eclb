import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/resource/datamapper/person/visitor/abstract_visitor_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/person/visitor/default_visitor_dto.dart';

final class MariadbVisitorDataMapper extends AbstractVisitorDataMapper{
  @override
  List generateList(Iterable resultSet) {
    throwIf(resultSet.length == 0, new Exception("Visitors can not be generated."));

    resultSet as Results;
    List visitors = [];

    for(ResultRow row in resultSet){
      DefaultVisitorDTO dto = new DefaultVisitorDTO(personId: row[0],
          address: row[1],
          number:row[2],
          complemento:row[3],
          district:row[4],
          city:row[5],
          state:row[6],
          postalCode:row[7],
          phone:row[8],
          email:row[9],
          memoryId:row[10]

      );
      visitors.add(dto);
    }
    return visitors;

  }

  @override
  Object? generateObject(Iterable resultSet) {
    throwIf(resultSet.length ==0, new Exception("Visitor can not be generated."));
    resultSet as Results;

    return new DefaultVisitorDTO(personId: resultSet.first[0],
        address: resultSet.first[1],
        number:resultSet.first[2],
        complemento:resultSet.first[3],
        district:resultSet.first[4],
        city:resultSet.first[5],
        state:resultSet.first[6],
        postalCode:resultSet.first[7],
        phone:resultSet.first[8],
        email:resultSet.first[9],
        memoryId:resultSet.first[10]
    );
  }


}