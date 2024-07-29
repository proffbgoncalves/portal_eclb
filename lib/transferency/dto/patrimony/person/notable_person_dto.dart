import 'package:portal_eclb/model/patrimony/person/notable_person.dart';

final class NotablePersonDTO implements NotablePerson{
  int? _patrimonyPersonId;


  NotablePersonDTO({
    int? patrimonyPersonId
}):
      _patrimonyPersonId = patrimonyPersonId;

@override
  int? get patrimonyPersonId => _patrimonyPersonId;
@override
  void set patrimonyPersonId(int? patrimonyPersonId) => _patrimonyPersonId = patrimonyPersonId;
}