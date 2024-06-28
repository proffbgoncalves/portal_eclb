import 'package:portal_eclb/model/patrimony/person/type_of_acting.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/type_of_acting_data_mapper.dart';



abstract class AbstractTypeOfActingDataMapper implements TypeOfActingDataMapper {


  List generateDeleteStatement(Object id) {
    if (id == null) {
      throw new Exception("Id parameter is null.");
    }
    List statement = ["DELETE FROM TYPESOFACTINGS WHERE ID = ?", [id]];
    return statement;
  }

  List<Object> generateFindAllStatement([int limit = 0, int offset = 0]) {

    if (offset >= 0 && limit > 0) {
      return ["SELECT * FROM TYPESOFACTINGS LIMIT ? OFFSET ?", [limit, offset]];
    } else if (offset == 0 && limit == 0) {
      return ["SELECT * FROM TYPESOFACTINGS"];
    } else {
      throw new Exception("Invalid parameter for generateFindAllStatements method.");
    }
  }

  List generateFindByIdStatement(Object id) {
    if (id == null) {
      throw new Exception("Id parameter is null");
    }
    List statement = ["SELECT * FROM TYPESOFACTINGS WHERE ID = ?", [id]];
    return statement;
  }

  List generateInsertStatement(Object dto) {
    if (dto == null) {
      throw new Exception("DTO parameter is null");
    }

    TypeOfActing acting = dto as TypeOfActing;

    if (acting.description == "") {
      throw new Exception("Description field can not be empty.");
    }
    List <Object> statement = ["INSERT INTO TYPESOFACTINGS (DESCRIPTION) VALUES (?)", [acting.description]];
    return statement;
  }

  List generateUpdateStatement(Object dto) {
    if (dto == null) {
      throw new Exception("DTO parameter is null.");
    } else if ((dto as TypeOfActing).id! <= 0) {
      throw new Exception("DTO has an invalid id value.");
    }
    TypeOfActing typeOfActing = dto as TypeOfActing;
    List statement = ["UPDATE TYPESOFACTINGS SET DESCRIPTION = ? WHERE ID = ?", [typeOfActing.description, typeOfActing.id]];
    return statement;
  }

  List generateFindByDescriptionStatement(String name) {
    if (name == null) {
      throw new Exception("Name parameter is null.");
    } else if (name == "") {
      throw new Exception("Name parameter can not be empty.");
    }
    List statement = ["SELECT * FROM TYPESOFACTINGS WHERE DESCRIPTION = ?", [name]];
    return statement;
  }

}