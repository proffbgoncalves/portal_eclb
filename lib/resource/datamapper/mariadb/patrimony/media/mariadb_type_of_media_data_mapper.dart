import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/media/type_of_media.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/abstract_type_of_media_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/media/type_of_media_dto.dart';

final class MariaDBTypeOfMediaDataMapper extends AbstractTypeOfMediaDataMapper {


  List generateList(Iterable resultSet) {
    if (resultSet.length == 0) {
      throw new Exception("Types of media can not be generated.");
    }

    Results results = resultSet as Results;

    List typesOfMedia = [];

    for(var row in results) {
      TypeOfMedia typeOfMedia = new TypeOfMediaDTO(id: row[0], description: row[1]);
      typesOfMedia.add(typeOfMedia);
    }
    return typesOfMedia;
  }


  Object generateObject(Iterable resultSet) {
    if (resultSet.length == 0) {
      throw new Exception("Type of Media can not be generated.");
    }

    Results results = resultSet as Results;
    TypeOfMedia typeOfMedia = new TypeOfMediaDTO(id: results.first[0], description: results.first[1]);
    return typeOfMedia;
  }

  @override
  List generateCountStatement() {
    // TODO: implement generateCountStatement
    throw UnimplementedError();
  }

}