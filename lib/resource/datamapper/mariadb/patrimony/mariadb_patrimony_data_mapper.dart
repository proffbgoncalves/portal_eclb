
import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/patrimony.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/abstract_patrimony_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/pratrimony_dto.dart';

final class MariadbPatrimonyDataMapper extends AbstractPatrimonyDataMapper {

  @override
  List generateList(Iterable resultSet) {
    // TODO: implement generateList
    throw UnimplementedError();
  }

  @override
  Object generateObject(Iterable resultSet) {
    throwIf(resultSet.length == 0, new Exception("Patrimony can not be generated."));

    Results results = resultSet as Results;

    Patrimony patrimony = new PatrimonyDTO();

    patrimony.id = results.first[0];
    patrimony.name = results.first[1];
    patrimony.description = results.first[2].toString();
    patrimony.unescoClassification = results.first[3];
    patrimony.typeOfPatrimonyId = results.first[4];
    patrimony.compositePatrimonyId = results.first[5];
    patrimony.hasLocation = results.first[6];
    patrimony.country = results.first[7];
    patrimony.state = results.first[8];
    patrimony.city = results.first[9];
    patrimony.district = results.first[10];
    patrimony.address = results.first[11];
    patrimony.postalCode = results.first[12];
    patrimony.longitude = results.first[13];
    patrimony.latitude = results.first[14];
    patrimony.altitude = results.first[15];

    return patrimony;
  }

}