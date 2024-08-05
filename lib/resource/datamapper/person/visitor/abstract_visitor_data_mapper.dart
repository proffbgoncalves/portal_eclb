import 'package:get_it/get_it.dart';// throwIf
import 'package:portal_eclb/model/person/visitor/visitor.dart';
import 'package:portal_eclb/resource/datamapper/person/visitor/visitor_data_mapper.dart';

abstract class AbstractVisitorDataMapper implements VisitorDataMapper{
  @override
  List generateCountStatement() {
    //nao pode passar por parâmetro pois queremos que o sql puxe genericamente todos id
    List statement = [ "SELECT COUNT(personId) FROM `eclb_dev`.VISITORS"];
    return statement;
  }

  @override
  List generateDeleteStatement(Object id) {
    throwIf(!(id is int), new Exception("Id parameter is not an instance of int."));
    List statement = ["DELETE FROM `eclb_dev`.VISITORS WHERE PERSONID = ?", [id]];//por que por id numa lista
    return statement;
  }



  @override
  List generateFindByIdStatement(Object id) {
    throwIf(!(id is int), new Exception("Id parameter is not an instance of int."));

    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE PERSONID = ?", [id]];
    return statement;
  }

  @override
  List generateInsertStatement(Object dto) {
    throwIf(!(dto is Visitor), new Exception("DTO parameter is not an instance of Visitor"));


    //Visitor visitante = dto as Visitor;
    //pq n fazer o cast de dto logo sem criar novos objetos?
    dto = dto as Visitor;
    //o cast é para definir o objeto genérico em um Visitor
    // e então podermos usa-lo para transferir seus valores para o novo objeto

    if(dto.personId == null ||!(dto.personId is int) || dto.personId! < 0){
      throw new Exception("Não é possível gerar statement SQL. Atributo personId não é valido.");
    }
    //precisa de verificações de nulo para cada campo not null?
    List statement = ["INSERT INTO `eclb_dev`.VISITORS (PERSONID, ADDRESS, NUMBER, COMPLEMENTO, DISTRICT, CITY, STATE, POSTALCODE, PHONE, EMAIL, MEMORYID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [dto.personId, dto.address, dto.number, dto.complemento, dto.district, dto.city, dto.state,
        dto.postalCode, dto.phone, dto.email, dto.memoryId]];
    //como vou inserir os ids estrangeiros - garantindo que ja existem valores para person e memories?

    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    throwIf(!(dto is Visitor), new Exception("DTO parameter is not an instance of Visitor"));

    dto = dto as Visitor;

    if(dto.personId == null ||!(dto.personId is int) || dto.personId! < 0){
      throw new Exception("Não é possível gerar statement SQL. Atributo personId não é valido.");
    }
    //continuo precisando das verificações pois o where usa o id
    List statement = ["UPDATE `eclb_dev`.VISITORS SET "
        "ADDRESS = ?, NUMBER = ?, COMPLEMENTO = ?, DISTRICT = ?, CITY = ?, STATE = ?,"
        "POSTALCODE = ?, PHONE = ?, EMAIL = ? WHERE PERSONID = ?", [ dto.address, dto.number, dto.complemento, dto.district, dto.city, dto.state,
      dto.postalCode, dto.phone, dto.email, dto.personId]];
    return statement;
  }

  @override
  List generateFindAllStatement([int limit =0, int offset = 0]) {
    if(limit > 0 && offset >= 0){
      return ["SELECT * FROM `eclb_dev`.VISITORS LIMIT = ? OFFSET = ?", [limit, offset]];
    } else if(limit == 0 && offset == 0){
      return ["SELECT * FROM `eclb_dev`.VISITORS"];
    }else{
      throw new Exception("Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos");
    }
  }

/* implementacao so no maria db?
  @override
  List generateList(Iterable resultSet) {
    // TODO: implement generateList
    throw UnimplementedError();
  }

  @override
  Object? generateObject(Iterable resultSet) {
    // TODO: implement generateObject
    throw UnimplementedError();
  }
*/



  @override
  List generateFindAllByAddress(String address) {
    // TODO: implement generateFindAllByAddress
    throw UnimplementedError();
  }

  @override
  List generateFindAllByCity(String city) {
    // TODO: implement generateFindAllByCity
    throw UnimplementedError();
  }

  @override
  List generateFindAllByComplemento(String complemento) {
    // TODO: implement generateFindAllByComplemento
    throw UnimplementedError();
  }

  @override
  List generateFindAllByDistrict(String district) {
    // TODO: implement generateFindAllByDistrict
    throw UnimplementedError();
  }

  @override
  List generateFindAllByEmail(String email) {

    throwIf(email == "", new Exception("Não é possível gerar statement SQL. Parâmetro email não pode ser vazio."));
    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE EMAIL = ?", [email]];
    print("printando em mariadbvisitorgeneratefindemail $email");
    return statement;
  }


  @override
  List generateFindAllByMemoryId(int memoryId) {
    // TODO: implement generateFindAllByMemoryId
    throw UnimplementedError();
  }

  @override
  List generateFindAllByNumber(int number) {
    // TODO: implement generateFindAllByNumber
    throw UnimplementedError();
  }

  @override
  List generateFindAllByPersonId(int personId) {
    // TODO: implement generateFindAllByPersonId
    throw UnimplementedError();
  }

  @override
  List generateFindAllByPhone(String phone) {
    // TODO: implement generateFindAllByPhone
    throw UnimplementedError();
  }

  @override
  List generateFindAllByPostalCode(String postalCode) {
    // TODO: implement generateFindAllByPostalCode
    throw UnimplementedError();
  }

  @override
  List generateFindAllByState(String state) {
    // TODO: implement generateFindAllByState
    throw UnimplementedError();
  }



}