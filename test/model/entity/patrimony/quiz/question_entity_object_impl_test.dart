import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/quiz/question_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/quiz/question_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/quiz/question.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/quiz/question_dao.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/quiz/question_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';


import '../../../../mocks/portal_eclb_mocks.mocks.dart';



void main() {
  group("QuestionEntityObjectTest", () {
    setUp(() async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      if (!dependencyInjector.hasEnvironmentConfiguration()) {
        dependencyInjector.registerEnvironmentConfiguration(environmentConfiguration);
      }
      DatabaseSessionManager databaseSessionManager = MockDatabaseSessionManager();
      if (!dependencyInjector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))) {
        dependencyInjector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);
      }

      DAOFactory daoFactory = MockDAOFactory();
      if (!dependencyInjector.hasDAOFactory(environmentConfiguration.get("dbms"))) {
        dependencyInjector.registerDAOFactory(environmentConfiguration.get("dbms"), daoFactory);
      }
      when(databaseSessionManager.clone()).thenReturn(databaseSessionManager);
      when(databaseSessionManager.close()).thenAnswer((_) async => {});
      when(databaseSessionManager.rollback()).thenAnswer((_) async => {});
      when(databaseSessionManager.open()).thenAnswer((_) async => true);
      when(databaseSessionManager.startTransaction()).thenAnswer((_) async => true);
      when(databaseSessionManager.commit()).thenAnswer((_) async => true);
    });

    test("testCreateAndInsertQuestionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuestionDAO dao = MockQuestionDAO();
      when(daoFactory.createQuestionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        QuestionDTO dto = QuestionDTO(questionID: 1, enunciation: "Sample Question");
        when(dao.insert(dto)).thenAnswer((_) async => true);
        QuestionEntityObjectImpl impl = QuestionEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.insert(), isTrue);
        impl.questionID = 1;
        expect(impl.questionID, greaterThan(0));
        expect(impl.enunciation, "Sample Question");
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testDeleteQuestionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuestionDAO dao = MockQuestionDAO();
      when(daoFactory.createQuestionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        QuestionDTO dto = QuestionDTO(questionID: 120);
        when(dao.delete(dto.questionID as Object)).thenAnswer((_) async => true);
        QuestionEntityObjectImpl impl = QuestionEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.delete(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testUpdateQuestionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuestionDAO dao = MockQuestionDAO();
      when(daoFactory.createQuestionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        QuestionDTO dto = QuestionDTO(questionID: 12, enunciation: "Updated Question");
        QuestionEntityObjectImpl impl = QuestionEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        when(dao.update(dto)).thenAnswer((_) async => true);
        expect(await impl.update(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testGetByIdQuestionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuestionDAO dao = MockQuestionDAO();
      when(daoFactory.createQuestionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        QuestionDTO dto = QuestionDTO(questionID: 1, enunciation: "Sample Question");
        when(dao.findById(1)).thenAnswer((_) async => dto);
        Question question = await QuestionEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1);
        expect(question.questionID, equals(1));
        expect(question.enunciation, "Sample Question");
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

    test("testFindAllQuestionEntityObject", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuestionDAO dao = MockQuestionDAO();
      when(daoFactory.createQuestionDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        List<Question> listForMock = [
          QuestionDTO(questionID: 1, enunciation: "Question 1"),
          QuestionDTO(questionID: 2, enunciation: "Question 2")
        ];
        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);
        List questions = await QuestionEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0);
        expect(questions[0].questionID, equals(1));
        expect(questions[0].enunciation, "Question 1");
        expect(questions[1].questionID, equals(2));
        expect(questions[1].enunciation, "Question 2");
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}
