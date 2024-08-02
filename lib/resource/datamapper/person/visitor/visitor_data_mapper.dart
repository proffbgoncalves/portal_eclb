import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

abstract interface class VisitorDataMapper implements DataMapper{

  List generateFindAllByPersonId(int personId);
  //vou pegar chave estrangeira assim?

  List generateFindAllByAddress(String address);

  List generateFindAllByNumber(int number);

  List generateFindAllByComplemento(String complemento);

  List generateFindAllByDistrict(String district);

  List generateFindAllByCity(String city);

  List generateFindAllByState(String state);

  List generateFindAllByPostalCode(String postalCode);

  List generateFindAllByPhone(String phone);

  List generateFindAllByEmail(String email);

  List generateFindAllByMemoryId(int memoryId);
//vou pegar chave estrangeira assim?
}