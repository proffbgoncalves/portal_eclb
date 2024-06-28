import 'package:portal_eclb/model/patrimony/media/type_of_media.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/type_of_media_data_mapper.dart';

abstract class AbstractTypeOfMediaDataMapper implements TypeOfMediaDataMapper {


  List generateDeleteStatement(Object id) {
    if (id == null) {
      throw new Exception("Id parameter is null.");
    }
    List statement = ["DELETE FROM TYPESOFMEDIAS WHERE ID = ?", [id]];
    return statement;
  }


  List<Object> generateFindAllStatement([int limit = 0, int offset = 0]) {

    if (offset >= 0 && limit > 0) {
      return ["SELECT * FROM TYPESOFMEDIAS LIMIT ? OFFSET ?", [limit, offset]];
    } else if (offset == 0 && limit == 0) {
      return ["SELECT * FROM TYPESOFMEDIAS"];
    } else {
      throw new Exception("Invalid parameter for generateFindAllStatements method.");
    }
  }

  List generateFindByIdStatement(Object id) {
    if (id == null) {
      throw new Exception("Id parameter is null");
    }
    List statement = ["SELECT * FROM TYPESOFMEDIAS WHERE ID = ?", [id]];
    return statement;
  }

  List generateInsertStatement(Object dto) {
    if (dto == null) {
      throw new Exception("DTO parameter is null");
    }

    TypeOfMedia patrimony = dto as TypeOfMedia;

    if (patrimony.description == "") {
      throw new Exception("Description field can not be empty.");
    }
    List <Object> statement = ["INSERT INTO TYPESOFMEDIAS (DESCRIPTION) VALUES (?)", [patrimony.description]];
    return statement;
  }

  List generateUpdateStatement(Object dto) {
    if (dto == null) {
      throw new Exception("DTO parameter is null.");
    } else if ((dto as TypeOfMedia).id! <= 0) {
      throw new Exception("DTO has an invalid id value.");
    }
    TypeOfMedia typeOfMedia = dto as TypeOfMedia;
    List statement = ["UPDATE TYPESOFMEDIAS SET DESCRIPTION = ? WHERE ID = ?", [typeOfMedia.description, typeOfMedia.id]];
    return statement;
  }


  List generateFindByDescriptionStatement(String name) {
    if (name == null) {
      throw new Exception("Name parameter is null.");
    } else if (name == "") {
      throw new Exception("Name parameter can not be empty.");
    }
    List statement = ["SELECT * FROM TYPESOFMEDIAS WHERE DESCRIPTION = ?", [name]];
    return statement;
  }

}