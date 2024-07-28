import 'package:portal_eclb/transferency/dto/person/visitor/abstract_visitor_dto.dart';

final class DefaultVisitorDTO extends AbstractVisitorDTO{
  //extender sem colocar mais nada
  DefaultVisitorDTO({super.personId,
    super.address,
    super.number,
    super.complemento,
    super.district,
    super.city,
    super.state,
    super.postalCode,
    super.phone,
    super.email,
    super.memoryId,
  } );
}