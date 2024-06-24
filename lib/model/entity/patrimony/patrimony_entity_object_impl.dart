import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/patrimony_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/patrimony.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/patrimony_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/pratrimony_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

class PatrimonyEntityObjectImpl extends AbstractEntityObject implements PatrimonyEntityObject {

  TypeOfPatrimonyEntityObject? _typeOfPatrimony;

  Patrimony _dto;

  PatrimonyEntityObjectImpl._(super._databaseSessionManager, super.environmentConfiguration, this._dto);

  ///Este é um Factory Method que substitui o construtor original. O construtor
  ///original é privado. No entanto, é necessário que todo EntityObject seja
  ///inicializado com um DTO. O DTO é quem encapsula os dados de um EntityObject.
  ///Assim, não é necessária a criação de atributos referentes as coluna da
  ///tabela alvo (Patrimonies) nesta classe.
  ///
  factory PatrimonyEntityObjectImpl(DatabaseSessionManager databaseSessionManager,
      EnvironmentConfiguration configuration, String name, String description,
      int unescoClassification, int typeOfPatrimonyId, int hasLocation, {int? id, String? country,
        int? compositePatrimonyId, String? state, String? city, String? district,
        String? address, int? postalCode, double? longitude, double? latitude,
        double? altitude}) {

    PatrimonyDTO dto = new PatrimonyDTO(
        id: id, name: name, description: description, unescoClassification: unescoClassification,
        typeOfPatrimonyId: typeOfPatrimonyId, compositePatrimonyId: compositePatrimonyId,
        hasLocation: hasLocation, country: country, state: state, city: city, district: district,
        address: address, postalCode: postalCode, longitude: longitude, latitude: latitude,
        altitude: altitude
    );
     return new PatrimonyEntityObjectImpl._(databaseSessionManager, configuration, dto);
  }

  int? get typeOfPatrimonyId => this._dto.typeOfPatrimonyId;

  set typeOfPatrimonyId(int? value) {
    this._dto.typeOfPatrimonyId = value;
  }

  int? get unescoClassification => this._dto.unescoClassification;

  set unescoClassification(int? value) {
    this._dto.unescoClassification = value;
  }

  String? get description => this._dto.description;

  set description(String? value) {
    this._dto.description = value;
  }

  String? get country => this._dto.country;

  set country(String? value) {
    this._dto.country = value;
  }

  String? get name => this._dto.name;

  set name(String? value) {
    this._dto.name = value;
  }

  int? get id => this._dto.id;

  set id(int? value) {
    throw new Exception("Identity can not be redefined.");
  }

  double? get altitude => this._dto.altitude;

  set altitude(double? value) {
    this._dto.altitude = value;
  }

  double? get latitude => this._dto.latitude;

  set latitude(double? value) {
    this._dto.latitude = value;
  }

  double? get longitude => this._dto.longitude;

  set longitude(double? value) {
    this._dto.longitude = value;
  }

  int? get postalCode => this._dto.postalCode;

  set postalCode(int? value) {
    this._dto.postalCode = value;
  }

  String? get address => this._dto.address;

  set address(String? value) {
    this._dto.address = value;
  }

  String? get district => this._dto.district;

  set district(String? value) {
    this._dto.district = value;
  }

  String? get city => this._dto.city;

  set city(String? value) {
    this._dto.city = value;
  }

  String? get state => this._dto.state;

  set state(String? value) {
    this._dto.state = value;
  }

  int? get hasLocation => this._dto.hasLocation;

  set hasLocation(int? value) {
    this._dto.hasLocation = value;
  }

  int? get compositePatrimonyId => this._dto.compositePatrimonyId;

  set compositePatrimonyId(int? value) {
    this._dto.compositePatrimonyId = value;
  }

  @override
  Future<bool> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> insert() async {

    throwIf(this._dto.name == "", new Exception("Name attribute is empty."));
    throwIf(this._dto.description == "", new Exception("Description attribute is empty."));
    throwIf(!(this._dto.unescoClassification! >= 0 && this._dto.unescoClassification! <= 2), new Exception("UnescoClassification attribute has invalid value."));
    throwIf(this._dto.typeOfPatrimonyId! <= 0, new Exception("TypeOfPatrimonyId attribute has invalid value."));
    throwIf(!(this._dto.hasLocation! == 0 || this._dto.hasLocation! == 1), new Exception("HasLocation attribute has invalid value."));

    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    PatrimonyDAO patrimonyDAO = factory.createPatrimonyDAO(databaseSessionManager);

    try {
      return patrimonyDAO.insert(this._dto);
    } catch (erro) {
      rethrow;
    }

  }

  @override
  Future<bool> update() {
    // TODO: implement update
    throw UnimplementedError();
  }

  static Future<PatrimonyEntityObject> getById(DatabaseSessionManager databaseSessionManager,EnvironmentConfiguration environmentConfiguration, int id) async  {
    throwIf(id <= 0, new Exception("Id parameter has an invalid value."));

    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    PatrimonyDAO patrimonyDAO = factory.createPatrimonyDAO(databaseSessionManager);

    try {
      Patrimony patrimony = (await patrimonyDAO.findById(id)) as Patrimony;

      return PatrimonyEntityObjectImpl._(databaseSessionManager, environmentConfiguration, patrimony);
    } catch (erro) {
      rethrow;
    }
  }

  @override
  // TODO: implement typeOfPatrimony
  Future<TypeOfPatrimonyEntityObject?> get typeOfPatrimony async {
    if (this._typeOfPatrimony == null) {
      this._typeOfPatrimony = await TypeOfPatimonyEntityObjectImpl.getById(this.databaseSessionManager, this.environmentConfiguration, this.typeOfPatrimonyId!);
    }
    return this._typeOfPatrimony;
  }

}