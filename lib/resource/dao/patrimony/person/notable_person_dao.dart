import 'package:portal_eclb/model/patrimony/person/notable_person.dart';

import '../../dao.dart';

abstract interface class NotablePersonDAO implements DAO{

  Future<NotablePerson?> findByPatrimonyPersonId(int id);


}