import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/patrimony/patrimony.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/patrimony_data_mapper.dart';

abstract class AbstractPatrimonyDataMapper implements PatrimonyDataMapper {

  @override
  List generateDeleteStatement(Object id) {
    throwIf(!(id is int), new Exception("Id parameter is not an instance of int."));

    List statement = ["DELETE FROM PATRIMONIES WHERE ID = ?", [id]];

    return statement;
  }

  @override
  List generateFindAllByCountryStatement(String country) {
    // TODO: implement generateFindAllByCountryStatement
    throw UnimplementedError();
  }

  @override
  List generateFindAllByDescriptionStatement(String description) {
    // TODO: implement generateFindAllByDescriptionStatement
    throw UnimplementedError();
  }

  @override
  List generateFindAllByNameStatement(String name) {
    // TODO: implement generateFindAllByNameStatement
    throw UnimplementedError();
  }

  @override
  List generateFindAllByTypeOfPatrimonyId(int typeOfPatrimonyId) {
    // TODO: implement generateFindAllByTypeOfPatrimonyId
    throw UnimplementedError();
  }

  @override
  List generateFindAllByUNESCOCLassification(int unescoClassification) {
    // TODO: implement generateFindAllByUNESCOCLassification
    throw UnimplementedError();
  }

  @override
  List generateFindAllStatement([int limit = 0, int offset = 0]) {
    // TODO: implement generateFindAllStatement
    throw UnimplementedError();
  }

  @override
  List generateFindByIdStatement(Object id) {
    throwIf(!(id is int), "Id parameter is not instance of int.");

    List statement = ["SELECT * FROM PATRIMONIES WHERE ID = ?", [id]];

    return statement;
  }

  @override
  List generateInsertStatement(Object dto) {
    throwIf(!(dto is Patrimony), "DTO parameter is not an instance of Patrimony");

    Patrimony patrimony = dto as Patrimony;

    List statement = ["INSERT INTO PATRIMONIES "
        "(NAME, DESCRIPTION, UNESCOCLASSIFICATION, TYPEOFPATRIMONYID, HASLOCATION)"
        "VALUES (?, ?, ?, ?, ?)",
      [patrimony.name, patrimony.description, patrimony.unescoClassification, patrimony.typeOfPatrimonyId, patrimony.hasLocation]];

    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    throwIf(!(dto is Patrimony), new Exception("DTO parameter is not instance of Patrimony."));

    Patrimony patrimony = dto as Patrimony;

    List statement = ["UPDATE PATRIMONIES SET "
        "NAME = ?, DESCRIPTION = ?, UNESCOCLASSIFICATION = ?, TYPEOFPATRIMONYID = ?,"
        "COMPOSITEPATRIMONYID = ?, HASLOCATION = ?, COUNTRY = ?, STATE = ?, CITY = ?,"
        "DISTRICT = ?, ADDRESS = ?, POSTALCODE = ?, LONGITUDE = ?, LATITUDE = ?,"
        "ALTITUDE = ? WHERE ID = ?",
      [
        patrimony.name, patrimony.description, patrimony.unescoClassification,
        patrimony.typeOfPatrimonyId, patrimony.compositePatrimonyId, patrimony.hasLocation,
        patrimony.country, patrimony.state, patrimony.city, patrimony.district,
        patrimony.address, patrimony.postalCode, patrimony.longitude, patrimony.latitude,
        patrimony.altitude, patrimony.id
      ]
    ];

    return statement;
  }

  List generateCountStatement() {
    List statement =["SELECT COUNT(ID) FROM PATRIMONIES"];
    return statement;
  }
}