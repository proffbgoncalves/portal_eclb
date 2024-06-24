import 'package:portal_eclb/model/entity/entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object.dart';
import 'package:portal_eclb/model/patrimony/patrimony.dart';

abstract interface class PatrimonyEntityObject implements Patrimony, EntityObject {

  Future<TypeOfPatrimonyEntityObject?> get typeOfPatrimony;
}