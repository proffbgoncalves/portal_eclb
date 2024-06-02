import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/person/person.dart';
import 'package:portal_eclb/resource/dao/abstract_dao.dart';
import 'package:portal_eclb/resource/dao/person/person_dao.dart';
import 'package:portal_eclb/resource/datamapper/person/person_data_mapper.dart';

final class MariaDBPersonDAO extends AbstractDAO implements PersonDAO {

  MariaDBPersonDAO(super.sessionManager, super.dataMapper);

  Future<bool> insert(Object dto) async {
    try {
      bool insertResult = await super.insert(dto);

      Results? results = (await super.sessionManager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;
      
      throwIf(!(dto is Person), "DTO parameter is not an Person instance.");

      Person person = dto as Person;
      person.id = results.first[0];

      return insertResult;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List> findByName(String name) async {
    throwIf(!this.sessionManager.isOpened, new Exception("Database session is not opened."));
    throwIf(name == "", new Exception("Name parameter can not be empty."));

    try {
      List statement = (this.dataMapper as PersonDataMapper)
          .generateFindByNameStatement(name);
      Results results = (await this.sessionManager.executeQuery(
          statement[0], statement[1])) as Results;
      if (results.length == 0) {
        throw new Exception("No record found.");
      }
      return this.dataMapper!.generateList(results);
    } catch (e) {
      rethrow;
    }
  }

}