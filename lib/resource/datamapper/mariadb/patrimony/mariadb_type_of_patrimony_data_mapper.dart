import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/datamapper/abstract_type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/type_of_patrimony_dto.dart';

final class MariaDBTypeOfPatrimonyDataMapper extends AbstractTypeOfPatrimonyDataMapper {

  ///Retorna uma coleção de objetos TypeOfPatrimony.
  List generateList(Iterable resultSet) {
    if (resultSet.length == 0) {
      throw new Exception("Types of patrimonies can not be generated.");
    }

    Results results = resultSet as Results;

    List typesOfPatrimonies = [];

    for(var row in results) {
      TypeOfPatrimony typeOfPatrimony = new TypeOfPatrimonyDTO(id: row[0], description: row[1]);
      typesOfPatrimonies.add(typeOfPatrimony);
    }
    return typesOfPatrimonies;
  }

  ///Retorna um objeto TypeOfPatrimony.
  Object generateObject(Iterable resultSet) {
    if (resultSet.length == 0) {
      throw new Exception("Type of Patrimony can not be generated.");
    }

    Results results = resultSet as Results;
    TypeOfPatrimony typeOfPatrimony = new TypeOfPatrimonyDTO(id: results.first[0], description: results.first[1]);
    return typeOfPatrimony;
  }

}