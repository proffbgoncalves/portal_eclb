import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/person/user/user.dart';
import 'package:portal_eclb/resource/datamapper/person/user/user_data_mapper.dart';

abstract class AbstractUserDataMapper implements UserDataMapper {

  List generateDeleteStatement(Object id) {
    throwIf(!(id is int), new Exception("Não é possível gerar statement SQL. O parâmetro id não é um int."));

    List statement = ["DELETE FROM USERS WHERE PERSONID = ?", [id]];
    return statement;
  }

  List generateFindAllStatement([int limit = 0, int offset = 0]) {
    if (offset > 0 && limit > 0) {
      return ["SELECT * FROM USERS LIMIT ? OFFSET ?", [limit, offset]];
    } else if (offset == 0 && limit == 0) {
      return ["SELECT * FROM USERS"];
    } else {
      throw new Exception("Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos.");
    }
  }

  List generateFindByIdStatement(Object id) {
    throwIf(!(id is int), new Exception("Não é possível gerar statement SQL. O parâmetro id não é um int."));

    List statement = ["SELECT * FROM USERS WHERE PERSONID = ?", [id]];

    return statement;
  }

  List generateInsertStatement(Object dto) {
    throwIf(!(dto is User), new Exception("Não é possível gerar statement SQL. DTO não é uma instância de User."));

    User user = dto as User;

    throwIf(user.login == "", new Exception("Não é possível gerar statement SQL. Atributo login não pode ser vazio"));
    throwIf(user.password == "", new Exception("Não é possível gerar statement SQL. Atributo password não pode ser vazio"));
    throwIf(user.function == "", new Exception("Não é possível gerar statement SQL. Atributo function não pode ser vazio"));

    List statement = ["INSERT INTO USERS (PERSONID, LOGIN, PASSWORD, FUNCTION) VALUES (?, ?, ?, ?)",
      [user.personId, user.login, user.password, user.function]];

    return statement;
  }

  List generateUpdateStatement(Object dto) {
    throwIf(!(dto is User), new Exception("DTO não é uma instância de User."));

    User user = (dto as User);
    throwIf(user.personId == null, new Exception("DTO has an invalid personId value."));
    throwIf(user.login == "", new Exception("DTO has an invalid login value."));
    throwIf(user.password == "", new Exception("DTO has an invalid password value."));
    throwIf(user.function == "", new Exception("DTO has an invalid function value."));

    List statement = ["UPDATE USERS SET LOGIN = ?, PASSWORD = ?, FUNCTION = ? WHERE PERSONID = ?",
      [user.login, user.password, user.function, user.personId]];

    return statement;
  }

  List generateFindByLoginStatement(String login) {
    throwIf(login == "", new Exception("Parâmetro login não pode ser vazio."));

    List statement = ["SELECT * FROM USERS WHERE LOGIN LIKE ?", ["%"+login+"%"]];

    return statement;
  }

  List generateFindByFunctionStatement(String function) {
    throwIf(function == "", new Exception("Parâmetro function não pode ser vazio."));

    List statement = ["SELECT * FROM USERS WHERE FUNCTION LIKE ?", ["%"+function+"%"]];

    return statement;
  }

  List generateCountStatement() {
    List statement = ["SELECT COUNT(PERSONID) FROM USERS"];
    return statement;
  }
}
