import 'package:portal_eclb/model/person/user/user.dart';
import 'package:portal_eclb/transferency/dto/person/abstact_person_dto.dart';

final class UserDTO extends AbstactPersonDTO implements User {

  String? _login;
  String? _password;

  UserDTO({super.id, super.name, String? login, String? password}) {
    this._login = login;
    this._password = password;
  }

  String? get password => _password;

  set password(String? value) {
    _password = value;
  }

  String? get login => _login;

  set login(String? value) {
    _login = value;
  }
}