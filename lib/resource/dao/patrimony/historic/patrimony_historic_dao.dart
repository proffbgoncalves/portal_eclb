import 'package:portal_eclb/resource/dao/dao.dart';
import 'package:portal_eclb/model/patrimony/historic/patrimony_historic.dart';

import '../../../../transferency/dto/patrimony/historic/patrimony_historic_dto.dart';

abstract interface class PatrimonyHistoricDAO implements DAO{
  // Encontra um visitante pelo ID da pessoa
  Future<PatrimonyHistoric?> findByPersonId(int personId);

  // Encontra todos os visitantes pelo endereço
  Future<List> findAllByAddress(String address);

  // Encontra todos os visitantes pelo número
  Future<List> findAllByNumber(int number);

  // Encontra todos os visitantes pelo complemento
  Future<List> findAllByComplemento(String complemento);

  // Encontra todos os visitantes pelo distrito
  Future<List> findAllByDistrict(String district);

  // Encontra todos os visitantes pela cidade
  Future<List> findAllByCity(String city);

  // Encontra todos os visitantes pelo estado
  Future<List> findAllByState(String state);

  // Encontra todos os visitantes pelo código postal
  Future<List> findAllByPostalCode(String postalCode);

  // Encontra todos os visitantes pelo telefone
  Future<List> findAllByPhone(String phone);

  // Encontra um visitante pelo e-mail
  Future<PatrimonyHistoric?> findByEmail(String email);

  // Encontra um visitante pelo ID da memória
  Future<PatrimonyHistoric?> findByMemoryId(int memoryId);

  @override
  Future<bool> insert(Object dto);

  findByNarrative(String narrative) {}
}


