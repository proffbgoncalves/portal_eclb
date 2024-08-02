import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/person/visitor/visitor.dart';
import 'package:portal_eclb/resource/dao/abstract_dao.dart';
import 'package:portal_eclb/resource/dao/person/visitor/visitor_dao.dart';
import 'package:portal_eclb/resource/datamapper/person/visitor/visitor_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/person/visitor/visitor_dto.dart';

final class MariadbVisitorDAO extends AbstractDAO implements VisitorDAO{
  MariadbVisitorDAO(super.sessionManager, super.dataMapper);

  @override
  Future<int> count() async {
    throwIf(!this.sessionManager.isOpened, new Exception("Database session is not opened."));

    List statement = this.dataMapper!.generateCountStatement();
    Results results = (await super.sessionManager.executeQuery(statement[0])) as Results;

    return results.first[0];
  }



  @override
  Future<bool> insert(Object dto) async {
    print("printando em visitorDAO 1");
    bool result = await super.insert(dto);
    print("printando em visitorDAO 2");
    Results? results = (await super.sessionManager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;
    print("printando em visitorDAO 3");
    dto as Visitor;
    dto.personId = results.first[0];
    print("printando em visitorDAO ${results.first[0]}");

    return result;

  }

  @override
  Future<List> findAllByAddress(String address) {
    // TODO: implement findAllByAddress
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByCity(String city) {
    // TODO: implement findAllByCity
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByComplemento(String complemento) {
    // TODO: implement findAllByComplemento
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByDistrict(String district) {
    // TODO: implement findAllByDistrict
    throw UnimplementedError();
  }

  @override
  Future<Visitor?> findByEmail(String email)  async{
    print("printando em findbyemail 1");
    if (!this.sessionManager.isOpened) {
      throw new Exception("Conexão com o banco de dados não foi aberta.");
    }
    print("printando em findbyemail 2");
    if (email == "") {
      throw new Exception("Email não pode ser vazio.");
    }
    print("printando em findbyemail 3");
    List statement = (this.dataMapper as VisitorDataMapper).generateFindAllByEmail(email);
    print("printando em findbyemail 4");
    Results results = (await this.sessionManager.executeQuery(statement[0], statement[1])) as Results;
    print("printando em findbyemail 5");
    if (results.length == 0) {
      return null;
    }
    print("printando em findbyemail 6");
    Visitor dto = new VisitorDTO(personId: results.first[0],
        address: results.first[1],
        number:results.first[2],
        complemento:results.first[3],
        district:results.first[4],
        city:results.first[5],
        state:results.first[6],
        postalCode:results.first[7],
        phone:results.first[8],
        email:results.first[9],
        memoryId:results.first[10]
    );
    print("printando em findbyemail 7 ${dto.email}");
    return dto;
  }

  @override
  Future<Visitor?> findByMemoryId(int memoryId) {
    // TODO: implement findAllByMemoryId
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByNumber(int number) {
    // TODO: implement findAllByNumber
    throw UnimplementedError();
  }

  @override
  Future<Visitor?> findByPersonId(int personId) {
    // TODO: implement findAllByPersonId
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByPhone(String phone) {
    // TODO: implement findAllByPhone
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByPostalCode(String postalCode) {
    // TODO: implement findAllByPostalCode
    throw UnimplementedError();
  }

  @override
  Future<List> findAllByState(String state) {
    // TODO: implement findAllByState
    throw UnimplementedError();
  }

}