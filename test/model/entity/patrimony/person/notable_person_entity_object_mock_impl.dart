import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/person/notable_person_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/person/notable_person_entity_object_impl.dart';

import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/notable_person_dao.dart';

import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/notable_person_dto.dart';

import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main(){
  group("NotablePersonEntityObjectMockTest", (){

    setUp(() async{
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");

      if(!dependencyInjector.hasEnvironmentConfiguration()){
        dependencyInjector.registerEnvironmentConfiguration(environmentConfiguration);
      }

      DatabaseSessionManager databaseSessionManager = new MockDatabaseSessionManager();
      if(!dependencyInjector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))){
        dependencyInjector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);
      }

      DAOFactory factory = new MockDAOFactory();
      if(!dependencyInjector.hasDAOFactory(environmentConfiguration.get("dbms"))){
        dependencyInjector.registerDAOFactory(environmentConfiguration.get("dbms"), factory);
      }

      when(databaseSessionManager.clone()).thenReturn(databaseSessionManager);
      when(databaseSessionManager.close()).thenAnswer((_) async => {});
      when(databaseSessionManager.rollback()).thenAnswer((_) async => {});
      when(databaseSessionManager.open()).thenAnswer((_) async => true);
      when(databaseSessionManager.startTransaction()).thenAnswer((_) async => true);
      when(databaseSessionManager.commit()).thenAnswer((_) async => true);



    });

    test("TestInsertNotablePersonMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      NotablePersonDAO dao = new MockNotablePersonDAO();
      when(factory.createNotablePersonDAO(databaseSessionManager)).thenReturn(dao);

      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        NotablePersonDTO dto = new NotablePersonDTO(
            patrimonyPersonId: 0
        );
        NotablePersonEntityObject impl = new NotablePersonEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);
        when(dao.insert(dto)).thenAnswer((_) async => true);
        expect(await impl.insert(), isTrue);

        expect(impl.patrimonyPersonId, 0);
        expect(await databaseSessionManager.commit(), isTrue);

      }catch(e){
        await databaseSessionManager.rollback();
        rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });

    test("TestDeleteNotablePersonMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      NotablePersonDAO dao = new MockNotablePersonDAO();
      when(factory.createNotablePersonDAO(databaseSessionManager)).thenReturn(dao);

      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        NotablePersonDTO dto = new NotablePersonDTO(
            patrimonyPersonId: 0
        );
        NotablePersonEntityObject impl = new NotablePersonEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);
        when(dao.delete(dto.patrimonyPersonId as Object)).thenAnswer((_) async => true);
        expect(await impl.delete(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);

      }catch(e){
        await databaseSessionManager.rollback();
        rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });



    test("TestUpdateNotablePersonMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      NotablePersonDAO dao = new MockNotablePersonDAO();
      when(factory.createNotablePersonDAO(databaseSessionManager)).thenReturn(dao);

      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        NotablePersonDTO dto = new NotablePersonDTO(
            patrimonyPersonId: 1
        );
        when(dao.update(dto) ).thenAnswer((_) async => true);
        NotablePersonEntityObject impl = new NotablePersonEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);


        expect(await impl.update(), isTrue);

        expect(impl.patrimonyPersonId, 1);
        expect(await databaseSessionManager.commit(), isTrue);

      }catch(e){
        await databaseSessionManager.rollback();
        rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });

    test("TestGetByIdNotablePersonMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      NotablePersonDAO dao = new MockNotablePersonDAO();
      when(factory.createNotablePersonDAO(databaseSessionManager)).thenReturn(dao);

      try{
        expect(await databaseSessionManager.open(), isTrue);

        NotablePersonDTO dto = new NotablePersonDTO(
            patrimonyPersonId: 0
        );
        when(dao.findById(0)).thenAnswer((_) async => dto);

        NotablePersonEntityObject? person = await NotablePersonEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 0);
        expect(person!.patrimonyPersonId, equals(0));


      }catch(e){
        await databaseSessionManager.rollback();
        rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });


  });
}