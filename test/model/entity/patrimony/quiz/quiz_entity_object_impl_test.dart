import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/quiz/quiz_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/quiz/quiz_patrimony.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/quiz/quiz_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/quiz/quiz_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';
import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main() {


  group("QuizEntityObjectImplTest", ()  {
    setUp(() async {

      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      if (!dependencyInjector.hasEnvironmentConfiguration()) {
        dependencyInjector.registerEnvironmentConfiguration(environmentConfiguration);
      }
      DatabaseSessionManager databaseSessionManager = new MockDatabaseSessionManager();
      if (!dependencyInjector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))) {
        dependencyInjector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);
      }

      DAOFactory daoFactory = new MockDAOFactory();
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


    test("testInsertQuiz", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuizDAO dao = MockQuizDAO();
      when(daoFactory.createQuizDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        QuizDTO dto = QuizDTO(id: 1, description: "Quiz 1");
        when(dao.insert(dto)).thenAnswer((_) async => true);
        QuizEntityObjectImpl impl = new QuizEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.insert(), isTrue);
        expect(impl.id, greaterThan(0));
        expect(impl.description, "Quiz 1");
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });


    test("testDeleteQuizEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuizDAO dao = new MockQuizDAO();
      when(daoFactory.createQuizDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        QuizDTO dto = new QuizDTO(id: 120);
        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);
        QuizEntityObjectImpl impl = new QuizEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        expect(await impl.delete(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });


    test("testUpdadeQuiz", () async {

      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuizDAO dao = new MockQuizDAO();
      when(daoFactory.createQuizDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);
        QuizDTO dto = QuizDTO(id: 12, description: "Quiz 12");
        QuizEntityObjectImpl impl = new QuizEntityObjectImpl(databaseSessionManager, environmentConfiguration, dto);
        when(dao.update(dto)).thenAnswer((_) async => true);
        expect(await impl.update(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch(error) {
        await databaseSessionManager.rollback();
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }

    });


    test("testGetByIdQUIZEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuizDAO dao = new MockQuizDAO();
      when(daoFactory.createQuizDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);
        QuizDTO dto = new QuizDTO(id: 1, description: "Quiz 1");
        when(dao.findById(1)).thenAnswer((_) async => dto);
        QuizPatrimony quizPatrimony = (await QuizEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 1));
        expect(quizPatrimony.id, equals(1));
        expect(quizPatrimony.description, "Quiz 1");
      } catch(error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });


    test("testGetAllQuizEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));
      QuizDAO dao = new MockQuizDAO();
      when(daoFactory.createQuizDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open(), isTrue);
        List<QuizPatrimony> listForMock = [
          new QuizDTO(id: 1, description: "Quiz 1"),
          new QuizDTO(id: 2, description: "Quiz 2")
        ];
        when(dao.findAll(5, 0)).thenAnswer((_) async => listForMock);
        List<QuizPatrimony> quizpatrimonys = (await QuizEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, 5, 0)) as List<QuizPatrimony>;
        expect(quizpatrimonys[0].id, equals(1));
        expect(quizpatrimonys[0].description, equals("Quiz 1"));
        expect(quizpatrimonys[1].id, equals(2));
        expect(quizpatrimonys[1].description, equals("Quiz 2"));
      } catch (error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });
  });
}