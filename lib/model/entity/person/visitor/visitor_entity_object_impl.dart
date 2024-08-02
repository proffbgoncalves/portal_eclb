import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/person/visitor/visitor_entity_object.dart';
import 'package:portal_eclb/model/person/visitor/visitor.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/person/visitor/visitor_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/person/visitor/visitor_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

class VisitorEntityObjectImpl extends AbstractEntityObject implements VisitorEntityObject{

  //privar construtor por causa do singleton

  Visitor _dto;
  //PersonEntityObject? _person;
  //MemoryEntityObject? _memory;

  //métodos das chaves estrangeiras
  /*

  @override
  Future<PersonEntityObject?> get person async {
    if (this._person == null) {
      this._person = await PersonEntityObjectImpl.getById(this.databaseSessionManager, this.environmentConfiguration, this.personId!);
    }
    return this._person;
  }

  @override
  Future<MemoryEntityObject?> get memory async {
    if (this._memory == null) {
      this._memory = await MemoryEntityObjectImpl.getById(this.databaseSessionManager, this.environmentConfiguration, this.memoryId!);
    }
    return this._memory;
  }
   */

  VisitorEntityObjectImpl._(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  factory VisitorEntityObjectImpl(
      DatabaseSessionManager databaseSessionManager,
      EnvironmentConfiguration enviromentConfiguration,
      int? personId,
      String? address,
      int? number,
      String? complemento,
      String? district,
      String? city,
      String? state,
      String? postalCode,
      String? phone,
      String? email,
      int? memoryId,
      ){
    VisitorDTO dto = new VisitorDTO(
        personId: personId,
        address: address,
        number: number,
        complemento: complemento,
        district: district,
        city: city,
        state:  state,
        postalCode: postalCode,
        phone:phone,
        email: email,
        memoryId : memoryId);

    return new VisitorEntityObjectImpl._(databaseSessionManager, enviromentConfiguration, dto);
  }

  factory VisitorEntityObjectImpl._createFromDTO(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, Visitor dto) {
    VisitorEntityObjectImpl instance = new VisitorEntityObjectImpl._(databaseSessionManager, environmentConfiguration, dto);
    return instance;
  }


  @override
  Future<bool> delete() async {
    throwIf(_dto.personId == null, new Exception("It is not possible to delete the entity. personId is null"));
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitorDAO visitorDAO = factory.createVisitorDAO(databaseSessionManager);
    try{
      return await visitorDAO.delete(_dto.personId as Object);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<bool> insert() async{
    throwIf(this._dto.address == null || _dto.address!.isEmpty, new Exception("Address attribute is null or empty"));
    throwIf(this._dto.number == null || _dto.number == 0, new Exception("Number attribute is null or invalid"));
    throwIf(this._dto.district == null || _dto.district!.isEmpty, new Exception("District attribute is null or empty"));
    throwIf(this._dto.city == null || _dto.city!.isEmpty, new Exception("City attribute is null or empty"));
    throwIf(this._dto.state == null || _dto.state!.isEmpty, new Exception("State attribute is null or empty"));
    throwIf(this._dto.postalCode == null || _dto.postalCode!.isEmpty, new Exception("PostalCode attribute is null or empty"));
    throwIf(this._dto.phone == null || _dto.phone!.isEmpty, new Exception("Phone attribute is null or empty"));
    throwIf(this._dto.email == null || _dto.email!.isEmpty, new Exception("Email attribute is null or empty"));

    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitorDAO visitorDAO = factory.createVisitorDAO(databaseSessionManager);

    try{
      return await visitorDAO.insert(this._dto as Object);
    }catch(e){
      if(e.toString().contains("Duplicate Entry")){
        throw new Exception("Visitor já existe");
      }
      else{
        print("relançando em VisitorEntutyObjectInsert $e");
        rethrow;
      }
    }
  }

  @override
  Future<bool> update() async{
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitorDAO visitorDAO = factory.createVisitorDAO(databaseSessionManager);
    try{
      return await visitorDAO.update(this._dto as Object);
    }catch(e){
      rethrow;
    }
  }


  static Future<VisitorEntityObject?> getById(DatabaseSessionManager databaseSessionManager,
      EnvironmentConfiguration environmentConfiguration, int id) async{
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitorDAO visitorDAO = factory.createVisitorDAO(databaseSessionManager);

    try{
      Object? object = await visitorDAO.findById(id);
      if(object == null){
        print("Deu null no getById");
        return null;
      }

      Visitor dto = object as Visitor;
      VisitorEntityObject visitor =  VisitorEntityObjectImpl._createFromDTO(databaseSessionManager, environmentConfiguration, dto);
      return visitor;

    }catch(e){
      rethrow;
    }
  }
  static Future<VisitorEntityObject?> getByEmail(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, String email) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    VisitorDAO dao = factory.createVisitorDAO(databaseSessionManager);

    try {
      Visitor? dto = await dao.findByEmail(email);
      print("dto ${dto.runtimeType}");
      if (dto == null) {
        print("Deu merda no getbyemail");
        return null;
      }
      VisitorEntityObject entity = VisitorEntityObjectImpl._createFromDTO(databaseSessionManager, environmentConfiguration, dto);
      return entity;
    } catch (e) {
      print("Deu merda no getbyemail $e");
      rethrow;
    }
  }

  @override
  int? get memoryId => this._dto.memoryId;
  @override
  set memoryId(int? value) {
    throw new Exception("Identity can not be redefined.");
  }

  @override
  String? get email => this._dto.email;
  @override
  set email(String? value) {
    this._dto.email = value;
  }

  @override
  String? get phone => this._dto.phone;
  @override
  set phone(String? value) {
    this._dto.phone = value;
  }

  @override
  String? get postalCode => this._dto.postalCode;
  @override
  set postalCode(String? value) {
    this._dto.postalCode = value;
  }

  @override
  String? get state => this._dto.state;
  @override
  set state(String? value) {
    this._dto.state = value;
  }

  @override
  String? get city => this._dto.city;
  @override
  set city(String? value) {
    this._dto.city = value;
  }

  @override
  String? get district => this._dto.district;
  @override
  set district(String? value) {
    this._dto.district = value;
  }

  @override
  String? get complemento => this._dto.complemento;
  @override
  set complemento(String? value) {
    this._dto.complemento = value;
  }

  @override
  int? get number => this._dto.number;
  @override
  set number(int? value) {
    this._dto.number = value;
  }

  @override
  String? get address => this._dto.address;
  @override
  set address(String? value) {
    this._dto.address = value;
  }

  @override
  int? get personId => this._dto.personId;
  @override
  set personId(int? value) {
    throw new Exception("Identity can not be redefined.");
  }
}