import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/person/notable_person.dart';

import 'package:portal_eclb/resource/dao/abstract_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/notable_person_dao.dart';

import 'package:portal_eclb/resource/datamapper/patrimony/person/notable_person_data_mapper.dart';

import 'package:portal_eclb/transferency/dto/patrimony/person/notable_person_dto.dart';


final class MariadbNotablePersonDAO extends AbstractDAO implements NotablePersonDAO {
  MariadbNotablePersonDAO(super.sessionManager, super.dataMapper);

  @override
  Future<int> count() async {
    throwIf(!this.sessionManager.isOpened, new Exception("Database session is not opened."));

    List statement = this.dataMapper!.generateCountStatement();
    Results results = (await super.sessionManager.executeQuery(statement[0])) as Results;

    return results.first[0];
  }

  @override
  Future<bool> insert(Object dto) async {
    print("printando em notablePersonDAO 1");
    bool result = await super.insert(dto);
    print("printando em notablePersonDAO 2");
    Results? results = (await super.sessionManager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;
    print("printando em notablePersonDAO 3");
    dto as NotablePerson;
    dto.patrimonyPersonId = results.first[0];
    print("printando em notablePersonDAO ${results.first[0]}");

    return result;
  }

  @override
  Future<NotablePerson?> findByPatrimonyPersonId(int patrimonyPersonId) async {

    if (!this.sessionManager.isOpened) {
      throw new Exception("Conexão com o banco de dados não foi aberta.");
    }
    print("printando em findByPatrimonyPersonId 2");
    if (patrimonyPersonId <= 0) {
      throw new Exception("patrimonyPersonId não pode ser menor ou igual a zero.");
    }

    List statement = (this.dataMapper as NotablePersonDataMapper).generateFindByPatrimonyPersonId(patrimonyPersonId);

    Results results = (await this.sessionManager.executeQuery(statement[0], statement[1])) as Results;

    if (results.isEmpty) {
      return null;
    }

    NotablePerson dto = new NotablePersonDTO(
        patrimonyPersonId: results.first[0],
    );
    return dto;
  }


}
