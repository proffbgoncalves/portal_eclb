import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/person/notable_person_entity_object.dart';
import 'package:portal_eclb/model/patrimony/person/notable_person.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/notable_person_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/notable_person_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

class NotablePersonEntityObjectImpl extends AbstractEntityObject implements NotablePersonEntityObject{
  NotablePerson _dto;

  /*
  PatrimonyPerson? _patrimonyPerson;

  @override
  Future<PatrimonyPersonEntityObject?> get patrimonyPerson async {
    if (this._patrimonyPerson == null) {
      this._patrimonyPerson = await PatrimonyPersonEntityObjectImpl.getById(this.databaseSessionManager, this.environmentConfiguration, this.personId!);
    }
    return this._patrimonyPerson;
  }

   */

  NotablePersonEntityObjectImpl._(
      super.databaseSessionManager,
      super.environmentConfiguration,
      this._dto);

  factory NotablePersonEntityObjectImpl(
      DatabaseSessionManager databaseSessionManager,
      EnvironmentConfiguration environmentConfiguration,
      int? patrimonyPersonId) {
    NotablePersonDTO dto = new NotablePersonDTO(patrimonyPersonId: patrimonyPersonId);
    return new NotablePersonEntityObjectImpl._(
        databaseSessionManager, environmentConfiguration, dto);
  }

  factory NotablePersonEntityObjectImpl._createFromDTO(
      DatabaseSessionManager databaseSessionManager,
      EnvironmentConfiguration environmentConfiguration,
      NotablePerson dto) {
    NotablePersonEntityObjectImpl instance = new NotablePersonEntityObjectImpl._(
        databaseSessionManager, environmentConfiguration, dto);
    return instance;
  }



  @override
  Future<bool> delete() async {
    throwIf(this._dto.patrimonyPersonId == null, new Exception(
        "It is not possible to delete the entity. patrimonyPersonId is null"));
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    NotablePersonDAO notablePersonDAO = factory.createNotablePersonDAO(databaseSessionManager);
    try {
      return await notablePersonDAO.delete(this._dto.patrimonyPersonId as Object);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> insert() async {
    throwIf(this._dto.patrimonyPersonId == null, new Exception("PatrimonyPersonId is null"));

    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    NotablePersonDAO notablePersonDAO = factory.createNotablePersonDAO(databaseSessionManager);

    try {
      return await notablePersonDAO.insert(this._dto as Object);
    } catch (e) {
      if (e.toString().contains("Duplicate Entry")) {
        throw new Exception("NotablePerson already exists");
      } else {
        print("Relançando em NotablePersonEntityObjectInsert $e");
        rethrow;
      }
    }
  }

  @override
  Future<bool> update() async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    NotablePersonDAO notablePersonDAO = factory.createNotablePersonDAO(databaseSessionManager);
    try {
      return await notablePersonDAO.update(this._dto.patrimonyPersonId as Object);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NotablePersonEntityObject?> getById(
      DatabaseSessionManager databaseSessionManager,
      EnvironmentConfiguration environmentConfiguration,
      int id) async {
    DAOFactory factory = AbstractDAOFactory.getInstance(environmentConfiguration);
    NotablePersonDAO notablePersonDAO = factory.createNotablePersonDAO(databaseSessionManager);

    try {
      Object? object = await notablePersonDAO.findById(id);
      if (object == null) {
        print("Deu null no getById");
        return null;
      }

      NotablePerson dto = object as NotablePerson;
      NotablePersonEntityObject notablePerson = NotablePersonEntityObjectImpl._createFromDTO(
          databaseSessionManager, environmentConfiguration, dto);
      return notablePerson;
    } catch (e) {
      rethrow;
    }
  }

  @override
  int? get patrimonyPersonId => this._dto.patrimonyPersonId;

  @override
  set patrimonyPersonId(int? value) {
    throw new Exception("Identity can not be redefined.");
  }

}