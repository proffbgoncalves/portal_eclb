import 'package:get_it/get_it.dart'; // igual
import 'package:portal_eclb/model/entity/abstract_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/quiz/question_entity_object.dart';
import 'package:portal_eclb/model/patrimony/quiz/question.dart';
import 'package:portal_eclb/resource/dao/abstract_dao_factory.dart'; // igual
import 'package:portal_eclb/resource/dao/dao_factory.dart'; // igual
import 'package:portal_eclb/resource/dao/patrimony/quiz/question_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart'; // igual
import 'package:portal_eclb/transferency/dto/patrimony/quiz/question_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../dependency/dependecy_injector.dart';


class QuestionEntityObjectImpl extends AbstractEntityObject implements QuestionEntityObject {

  Question _dto;

  QuestionEntityObjectImpl(super.databaseSessionManager, super.environmentConfiguration, this._dto);

  @override
  Future<bool> delete() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory factory = dependencyInjector.getDAOFactory(this.environmentConfiguration.get("dbms"));
    QuestionDAO dao = factory.createQuestionDAO(databaseSessionManager);

    try {
      return await dao.delete(this._dto.questionID as Object);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> insert() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
    QuestionDAO dao = daoFactory.createQuestionDAO(databaseSessionManager);
    try {
      return await dao.insert(this._dto);
    } catch(error) {
      rethrow;
    }
  }

  @override
  Future<bool> update() async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
    QuestionDAO dao = daoFactory.createQuestionDAO(databaseSessionManager);

    try {
      return await dao.update(this._dto);
    } catch (error) {
      rethrow;
    }
  }

  int? get questionID {
    return this._dto.questionID;
  }

  void set questionID(int? questionID) {
    throw UnimplementedError();
  }

  String? get enunciation {
    return this._dto.enunciation;
  }

  void set enunciation(String? enunciation) {
    this._dto.enunciation = enunciation;
  }

  static Future<Question> getById(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, int id) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    QuestionDAO dao = daoFactory.createQuestionDAO(databaseSessionManager);

    try {
      return (await dao.findById(id)) as Question;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List> getAll(DatabaseSessionManager databaseSessionManager, EnvironmentConfiguration environmentConfiguration, [int limit = 0, int offset = 0]) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

    QuestionDAO dao = daoFactory.createQuestionDAO(databaseSessionManager);

    try {
      return await dao.findAll(limit, offset);
    } catch (error) {
      rethrow;
    }
  }


  @override
  int? quizId;
}
