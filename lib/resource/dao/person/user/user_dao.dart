import 'package:portal_eclb/model/person/person.dart';

abstract interface class User implements Person {

  void set login(String? login);

  String? get login;

  void set password(String? password);

  String? get password;

}