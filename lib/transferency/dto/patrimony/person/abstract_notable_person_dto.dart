import 'package:portal_eclb/model/patrimony/person/notable_person.dart';


abstract class AbstractNotablePersonDTO implements NotablePerson {
  int? _patrimonyPersonId;

  AbstractNotablePersonDTO({int? patrimonyPersonId}) : _patrimonyPersonId = patrimonyPersonId;

  int? get patrimonyPersonId => _patrimonyPersonId;
  set patrimonyPersonId(int? value) {
    _patrimonyPersonId = value;
  }
}
