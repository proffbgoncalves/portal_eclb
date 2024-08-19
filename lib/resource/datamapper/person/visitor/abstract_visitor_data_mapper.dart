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

    List statement = [
      "INSERT INTO `eclb_dev`.VISITORS (PERSONID, ADDRESS, NUMBER, COMPLEMENTO, DISTRICT, CITY,"
          " STATE, POSTALCODE, PHONE, EMAIL, MEMORYID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",

      [dto.personId, dto.address, dto.number, dto.complemento, dto.district, dto.city, dto.state,
        dto.postalCode, dto.phone, dto.email, dto.memoryId]];

    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    throwIf(!(dto is Visitor), new Exception("DTO parameter is not an instance of Visitor"));

    dto = dto as Visitor;

    if(dto.personId == null ||!(dto.personId is int) || dto.personId! < 0){
      throw new Exception("Não é possível gerar statement SQL. Atributo personId não é valido.");
    }

    List statement = ["UPDATE `eclb_dev`.VISITORS SET "

        "ADDRESS = ?, NUMBER = ?, COMPLEMENTO = ?, DISTRICT = ?, CITY = ?, STATE = ?,"
        "POSTALCODE = ?, PHONE = ?, EMAIL = ? WHERE PERSONID = ?",
      [ dto.address, dto.number, dto.complemento, dto.district, dto.city, dto.state,
      dto.postalCode, dto.phone, dto.email, dto.personId]];
    return statement;
  }

  @override
  List generateFindAllStatement([int limit =0, int offset = 0]) {
    if(limit > 0 && offset >= 0){

      return ["SELECT * FROM `eclb_dev`.VISITORS LIMIT ? OFFSET ?", [limit, offset]];
    } else if(limit == 0 && offset == 0){
      return ["SELECT * FROM `eclb_dev`.VISITORS"];

    }else{
      throw new Exception("Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos");
    }
  }


  @override
  List generateFindAllByAddress(String address) {
    throwIf(address == "", new Exception("Não é possível gerar statement SQL. Parâmetro address não pode ser vazio."));

    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE ADDRESS = ?",[address]];

    return statement;
  }

  @override
  List generateFindAllByCity(String city) {
    throwIf(city == "", new Exception("Não é possível gerar statement SQL. Parâmetro city não pode ser vazio."));

    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE CITY = ?",[city]];

    return statement;
  }

  @override
  List generateFindAllByComplemento(String complemento) {
    if(complemento == "" || complemento.isEmpty){
      List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE COMPLEMENTO IS NULL"];
     return statement;
    }

    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE COMPLEMENTO = ?", [complemento]];
    return statement;
  }

  @override
  List generateFindAllByDistrict(String district) {
    throwIf(district == "", new Exception("Não é possível gerar statement SQL. Parâmetro district não pode ser vazio."));

    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE DISTRICT = ?",[district]];

    return statement;
  }

  @override
  List generateFindAllByEmail(String email) {

    throwIf(email == "", new Exception("Não é possível gerar statement SQL. Parâmetro email não pode ser vazio."));
    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE EMAIL = ?", [email]];

    return statement;
  }


  @override
  List generateFindAllByMemoryId(int memoryId) {
    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE MEMORYID = ?", [memoryId]];

    return statement;
  }

  @override
  List generateFindAllByNumber(int number) {
    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE NUMBER = ?", [number]];

    return statement;
  }

  @override
  List generateFindAllByPersonId(int personId) {
    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE PERSONID = ?", [personId]];
    return statement;
  }

  @override
  List generateFindAllByPhone(String phone) {
    throwIf(phone == "", new Exception("Não é possível gerar statement SQL. Parâmetro phone não pode ser vazio."));

    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE PHONE = ?",[phone]];

    return statement;
  }

  @override
  List generateFindAllByPostalCode(String postalCode) {
    throwIf(postalCode == "", new Exception("Não é possível gerar statement SQL. Parâmetro postalCode não pode ser vazio."));

    List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE POSTALCODE = ?",[postalCode]];

    return statement;
  }

  @override
  List generateFindAllByState(String state) {
    throwIf(state == "", new Exception("Não é possível gerar statement SQL. Parâmetro state não pode ser vazio."));

      List statement = ["SELECT * FROM `eclb_dev`.VISITORS WHERE STATE  = ?",[state]];

    return statement;
  }



}