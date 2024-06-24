import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/patrimony.dart';
import 'package:portal_eclb/resource/dao/abstract_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/patrimony_dao.dart';

final class MariaDBPatrimonyDAO extends AbstractDAO implements PatrimonyDAO {


  MariaDBPatrimonyDAO(super.sessionManager, super.dataMapper);
  
  @override
  Future<bool> insert(Object dto) async {
    bool result = await super.insert(dto);

    Results? results = (await super.sessionManager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;

    Patrimony patrimony = dto as Patrimony;
    patrimony.id = results.first[0];

    return result;
  }


  @override
  Future<List> findAllByCountry(String country) {
    // TODO: implement findAllByCountry
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByDescription(String description) {
    // TODO: implement findAllByDescription
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByName(String name) {
    // TODO: implement findAllByName
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByTypeOfPatrimonyId(int typeOfPatrimonyId) {
    // TODO: implement findAllByTypeOfPatrimonyId
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByUNESCOClassification(int unescoClassification) {
    // TODO: implement findAllByUNESCOClassification
    throw UnimplementedError();
  }

  @override
  Future<int> count() async {
    throwIf(!this.sessionManager.isOpened, new Exception("Database session is not opened."));

    List statement = this.dataMapper!.generateCountStatement();
    Results? results = (await this.sessionManager.executeQuery(statement[0])) as Results;

    return results.first[0];
  }

}