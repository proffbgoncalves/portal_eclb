import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/abstract_type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/type_of_patrimony_dto.dart';

final class MariaDBTypeOfPatrimonyDataMapper extends AbstractTypeOfPatrimonyDataMapper {

  ///Retorna uma coleção de objetos TypeOfPatrimony.
  List generateList(Iterable resultSet) {
    List typesOfPatrimonies = [];

    if (resultSet.isNotEmpty) {
      Results results = resultSet as Results;

      for (var row in results) {
        TypeOfPatrimony typeOfPatrimony = new TypeOfPatrimonyDTO(
            id: row[0], description: row[1]);
        typesOfPatrimonies.add(typeOfPatrimony);
      }
    }
    return typesOfPatrimonies;
  }

  ///Retorna um objeto TypeOfPatrimony.
  Object? generateObject(Iterable resultSet) {
    if (resultSet.isEmpty) {
      return null;
    }

    Results results = resultSet as Results;
    TypeOfPatrimony typeOfPatrimony = new TypeOfPatrimonyDTO(id: results.first[0], description: results.first[1]);
    return typeOfPatrimony;
  }

}