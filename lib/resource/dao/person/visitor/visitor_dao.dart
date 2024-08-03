import 'package:portal_eclb/model/person/visitor/visitor.dart';
import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class VisitorDAO implements DAO{

  Future<Visitor?> findByPersonId(int personId);

  Future<List> findAllByAddress(String address);

  Future<List> findAllByNumber(int number);

  Future<List> findAllByComplemento(String complemento);

  Future<List> findAllByDistrict(String district);

  Future<List> findAllByCity(String city);

  Future<List> findAllByState(String state);

  Future<List> findAllByPostalCode(String postalCode);

  Future<List> findAllByPhone(String phone);

  Future<Visitor?> findByEmail(String email);

  Future<Visitor?> findByMemoryId(int memoryId);
}