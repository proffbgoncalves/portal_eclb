import 'package:portal_eclb/model/entity/entity_object.dart';
import 'package:portal_eclb/model/patrimony/event/type_of_event.dart';

///Esta interface define o contrato de métodos para classes que a implementarão.
///Ela realiza uma herança de tipo de TypeOfEvent e EntityObject. Isso quer dizer
///que, serão herdados os métodos abstratos tanto de TypeOfEvent quanto EntityObject.
///
/// Lembre-se de que os tanto os métodos herdados quanto os métodos criado aqui
/// serão sempre de instância. Neste caso, deve-se utilizazar objetos de classes
/// que implementam completamente esta interface.
abstract interface class TypeOfEventEntityObject implements TypeOfEvent, EntityObject {

}