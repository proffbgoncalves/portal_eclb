import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/composite/visitation_stage_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/composite/visitation_stage_entity_object_impl.dart';
import 'package:portal_eclb/model/entity/patrimony/person/notable_person_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/person/notable_person_entity_object_impl.dart';
import 'package:portal_eclb/model/entity/person/visitor/visitor_entity_object_impl.dart';

import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_stage_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/person/notable_person_dao.dart';

import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/visitation_stage_dto.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/notable_person_dto.dart';

import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main(){
  group("VisitationStageEntityObjectMockTest", (){

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

    test("TestInsertVisitationStageMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitationStageDAO dao = new MockVisitationStageDAO();
      when(factory.createVisitationStageDAO(databaseSessionManager)).thenReturn(dao);

      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitationStageDTO dto = new VisitationStageDTO(
            id: 0,
            name: "patrimonio",
            visitationItineraryId: 0
        );
        VisitationStageEntityObject impl = new VisitationStageEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);
        when(dao.insert(dto)).thenAnswer((_) async => true);
        expect(await impl.insert(), isTrue);

        expect(impl.id, 0);
        expect(await databaseSessionManager.commit(), isTrue);

      }catch(e){
        await databaseSessionManager.rollback();
        rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });


    test("TestDeleteVisitationStageMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitationStageDAO dao = new MockVisitationStageDAO();
      when(factory.createVisitationStageDAO(databaseSessionManager)).thenReturn(dao);

      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitationStageDTO dto = new VisitationStageDTO(
            id: 0,
            name: "patrimonio",
            visitationItineraryId: 0
        );
        VisitationStageEntityObject impl = new VisitationStageEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);
        when(dao.delete(dto.id as Object)).thenAnswer((_) async => true);
        expect(await impl.delete(), isTrue);

        expect(impl.id, 0);
        expect(await databaseSessionManager.commit(), isTrue);

      }catch(e){
        await databaseSessionManager.rollback();
        rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });

    test("TestUpdateVisitationStageMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitationStageDAO dao = new MockVisitationStageDAO();
      when(factory.createVisitationStageDAO(databaseSessionManager)).thenReturn(dao);

      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitationStageDTO dto = new VisitationStageDTO(
            id: 1,
            name: "patrimonio",
            visitationItineraryId: 0
        );
        VisitationStageEntityObject impl = new VisitationStageEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);
        when(dao.update(dto)).thenAnswer((_) async => true);
        expect(await impl.update(), isTrue);

        expect(impl.id, 1);
        expect(await databaseSessionManager.commit(), isTrue);

      }catch(e){
        await databaseSessionManager.rollback();
        rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });

    test("TestGetByIdVisitationStageMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitationStageDAO dao = new MockVisitationStageDAO();
      when(factory.createVisitationStageDAO(databaseSessionManager)).thenReturn(dao);

      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitationStageDTO dto = new VisitationStageDTO(
            id: 0,
            name: "patrimonio",
            visitationItineraryId: 0
        );
        when(dao.findById(0)).thenAnswer((_) async => dto);

        VisitationStageEntityObject? visitationStageEntityObject = await VisitationStageEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 0);
        expect(visitationStageEntityObject!.id, equals(0));


        expect(await databaseSessionManager.commit(), isTrue);

      }catch(e){
        await databaseSessionManager.rollback();
        rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });



  });
}