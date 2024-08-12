import 'package:portal_eclb/model/person/user/user.dart';

final class UserDTO implements User {

  int? _personId;
  String? _login;
  String? _password;
  String? _function;

  UserDTO({int? personId, String? login, String? password, String? function}) {
    this._personId = personId;
    this._login = login;
    this._password = password;
    this._function = function;
  }

  int? get personId => this._personId;

  set personId(int? value) {
    this._personId = value;
  }

  String? get login => this._login;

  set login(String? value) {
    this._login = value;
  }

  String? get password => this._password;

  set password(String? value) {
    this._password = value;
  }

  String? get function => this._function;

  set function(String? value) {
    this._function = value;
  }
}
