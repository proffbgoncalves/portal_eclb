import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class PatrimonyDAO implements DAO {

  Future<List> findAllByName(String name);

  Future<List> findAllByCountry(String country);

  Future<List> findAllByDescription(String description);

  Future<List> findAllByUNESCOClassification(int unescoClassification);

  Future<List> findAllByTypeOfPatrimonyId(int typeOfPatrimonyId);

}