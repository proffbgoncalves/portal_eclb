import 'package:get_it/get_it.dart'; // throwIf
import 'package:portal_eclb/model/patrimony/person/notable_person.dart';

import 'package:portal_eclb/resource/datamapper/patrimony/person/notable_person_data_mapper.dart';


abstract class AbstractNotablePersonDataMapper implements NotablePersonDataMapper {
  @override
  List generateCountStatement() {
    List statement = ["SELECT COUNT(patrimonyPersonId) FROM `eclb_dev`.NOTABLEPERSONS"];
    return statement;
  }

  @override
  List generateDeleteStatement(Object id) {
    throwIf(!(id is int), new Exception("Id parameter is not an instance of int."));
    List statement = ["DELETE FROM `eclb_dev`.NOTABLEPERSONS WHERE PATRIMONYPERSONID = ?", [id]];
    return statement;
  }

  @override
  List generateFindByPatrimonyPersonId(Object id) {
    throwIf(!(id is int), new Exception("Id parameter is not an instance of int."));
    List statement = ["SELECT * FROM `eclb_dev`.NOTABLEPERSONS WHERE PATRIMONYPERSONID = ?", [id]];
    return statement;
  }
  @override
  List generateFindByIdStatement(Object id) {
    throwIf(!(id is int), new Exception("Id parameter is not an instance of int."));
    List statement = ["SELECT * FROM `eclb_dev`.NOTABLEPERSONS WHERE PATRIMONYPERSONID = ?", [id]];
    return statement;
  }

  @override
  List generateInsertStatement(Object dto) {
    throwIf(!(dto is NotablePerson), new Exception("DTO parameter is not an instance of NotablePerson"));

    dto = dto as NotablePerson;

    if (dto.patrimonyPersonId == null || !(dto.patrimonyPersonId is int) || dto.patrimonyPersonId! < 0) {
      throw new Exception("Não é possível gerar statement SQL. Atributo patrimonyPersonId não é válido.");
    }

    List statement = [
      "INSERT INTO `eclb_dev`.NOTABLEPERSONS (PATRIMONYPERSONID) VALUES (?)",
      [
        dto.patrimonyPersonId,
      ]
    ];
    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    throwIf(!(dto is NotablePerson), new Exception("DTO parameter is not an instance of NotablePerson"));

    dto = dto as NotablePerson;

    if (dto.patrimonyPersonId == null || !(dto.patrimonyPersonId is int) || dto.patrimonyPersonId! < 0) {
      throw new Exception("Não é possível gerar statement SQL. Atributo patrimonyPersonId não é válido.");
    }

    List statement = [
      "UPDATE `eclb_dev`.NOTABLEPERSONS SET "
          " patrimonypersonid = ? WHERE PATRIMONYPERSONID = ?",
      [
         dto.patrimonyPersonId, dto.patrimonyPersonId
      ]
    ];
    return statement;
  }

  @override
  List generateFindAllStatement([int limit = 0, int offset = 0]) {
    if (limit > 0 && offset >= 0) {
      return ["SELECT * FROM `eclb_dev`.NOTABLEPERSONS LIMIT = ? OFFSET = ?", [limit, offset]];
    } else if (limit == 0 && offset == 0) {
      return ["SELECT * FROM `eclb_dev`.NOTABLEPERSONS"];
    } else {
      throw new Exception("Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos");
    }
  }

}
