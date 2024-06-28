import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/person/type_of_acting.dart';
import 'package:portal_eclb/resource/dao/abstract_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/type_of_acting_dao.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/person/type_of_acting_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/type_of_acting_dto.dart';


final class MariaDBTypeOfActingDAO extends AbstractDAO implements TypeOfActingDAO{


  MariaDBTypeOfActingDAO(super._sessionManager,super._dataMapper);

  Future<bool> insert(Object dto) async {
    try {
      bool insertResult = await super.insert(dto);

      Results? results = (await super.sessionManager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;

      TypeOfActing typesOfActingDTO = dto as TypeOfActing;
      typesOfActingDTO.id = results.first[0];

      return insertResult;
    }catch (e){
      rethrow;
    }
  }
  Future<TypeOfActing> findByDescription(String description) async {
    if (!this.sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }
    if (description == null) {
      throw new Exception("Description parameter is null.");
    } else if (description == "") {
      throw new Exception("Description can not be empty");
    }
    List statement = (this.dataMapper as TypeOfActingDataMapper).generateFindByDescriptionStatement(description);
    Results results = (await this.sessionManager.executeQuery(statement[0], statement[1])) as Results;
    if (results.length == 0) {
      throw new Exception("Type of acting was not found.");
    }
    TypeOfActing dto = new TypeOfActingDTO(id: results.first[0], description: results.first[1]);
    return dto;
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

}