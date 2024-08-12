import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/resource/datamapper/person/user/abstract_user_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/person/user/user_dto.dart';

final class MariaDBUserDataMapper extends AbstractUserDataMapper {

  @override
  List generateList(Iterable resultSet) {
    throwIf(resultSet.isEmpty, new Exception("Users cannot be generated."));

    Results results = resultSet as Results;

    List users = [];

    for (ResultRow row in results) {
      UserDTO dto = new UserDTO(
          personId: row[0],
          login: row[1],
          password: row[2],
          function: row[3]
      );
      users.add(dto);
    }
    return users;
  }

  @override
  Object generateObject(Iterable resultSet) {
    throwIf(resultSet.isEmpty, new Exception("User cannot be generated."));

    Results results = resultSet as Results;
    return new UserDTO(
        personId: results.first[0],
        login: results.first[1],
        password: results.first[2],
        function: results.first[3]
    );
  }

  @override
  List generateCountStatement() {
    return ["SELECT COUNT(*) FROM USERS"];
  }
}
