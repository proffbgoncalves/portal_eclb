import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/person/visitor/visitor_entity_object.dart';
import 'package:portal_eclb/model/entity/person/visitor/visitor_entity_object_impl.dart';
import 'package:portal_eclb/model/person/visitor/visitor.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/person/visitor/visitor_dao.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/transferency/dto/person/visitor/visitor_dto.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

import '../../../../mocks/portal_eclb_mocks.mocks.dart';

void main(){
  group("VisitorEntityObjectMockTest", (){

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

    test("TestInsertVisitorMock", () async{


      //estrutura padrão pra trabalhar com banco de dados
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms")); 

      VisitorDAO dao = new MockVisitorDAO();
      when(factory.createVisitorDAO(databaseSessionManager)).thenReturn(dao);
      
      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitorDTO dto = new VisitorDTO(
            personId: 0,
            memoryId: 0,
            address: "rua",
            state: "rio",
            city: "bji",
            number: 100,
            complemento: "ali",
            district: "centro",
            phone: "2299",
            postalCode: "100",
            email: "@gmail.com"
        );
        VisitorEntityObjectImpl impl = new VisitorEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);
        when(dao.insert(dto)).thenAnswer((_) async => true);
        expect(await impl.insert(), isTrue);
        
        expect(impl.city, "bji");
        expect(await databaseSessionManager.commit(), isTrue);

      }catch(e){
      await databaseSessionManager.rollback();
      rethrow;

      }finally{
        await databaseSessionManager.close();

      }

    });
    
    test("TestDeleteMockVisitor", () async{
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitorDAO dao = new MockVisitorDAO();

      when(factory.createVisitorDAO(databaseSessionManager)).thenReturn(dao);
      try{
        expect(await databaseSessionManager.open(), isTrue);            
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitorDTO dto = new VisitorDTO(
            personId: 0,
            memoryId: 0,
            address: "rua",
            state: "rio",
            city: "bji",
            number: 100,
            complemento: "ali",
            district: "centro",
            phone: "2299",
            postalCode: "100",
            email: "@gmail.com"
        );
        VisitorEntityObjectImpl impl = new VisitorEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);
        
        when(dao.delete(dto.personId as Object)).thenAnswer((_) async => true);
        expect(await impl.delete(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (e){
      await databaseSessionManager.rollback();
      rethrow;


      } finally{
      await databaseSessionManager.close();
      }
    });

    test("TestUpdateMockVisitor", () async{
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory factory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitorDAO dao = new MockVisitorDAO();

      when(factory.createVisitorDAO(databaseSessionManager)).thenReturn(dao);
      try{
        expect(await databaseSessionManager.open(), isTrue);
        expect(await databaseSessionManager.startTransaction(), isTrue);

        VisitorDTO dto = new VisitorDTO(
            personId: 0,
            memoryId: 0,
            address: "rua",
            state: "rio",
            city: "bji",
            number: 100,
            complemento: "ali",
            district: "centro",
            phone: "2299",
            postalCode: "100",
            email: "@gmail.com"
        );
        VisitorEntityObjectImpl impl = new VisitorEntityObjectImpl.createFromDTO(databaseSessionManager, environmentConfiguration, dto);

        when(dao.update(dto) ).thenAnswer((_) async => true);
        expect(await impl.update(), isTrue);
        expect(await databaseSessionManager.commit(), isTrue);
      } catch (e){
        await databaseSessionManager.rollback();
        rethrow;


      } finally{
        await databaseSessionManager.close();
      }
    });

    test("testGetByIdVisitorEntityObjectImpl", () async {
      DependencyInjector dependencyInjector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
      DatabaseSessionManager databaseSessionManager = dependencyInjector.getDatabaseSessionManager(environmentConfiguration.get("dbms"));
      DAOFactory daoFactory = dependencyInjector.getDAOFactory(environmentConfiguration.get("dbms"));

      VisitorDAO dao = new MockVisitorDAO();

      when(daoFactory.createVisitorDAO(databaseSessionManager)).thenReturn(dao);

      try {
        expect(await databaseSessionManager.open() , isTrue);

        VisitorDTO dto = new VisitorDTO(
            personId: 0,
            memoryId: 0,
            address: "rua",
            state: "rio",
            city: "bji",
            number: 100,
            complemento: "ali",
            district: "centro",
            phone: "2299",
            postalCode: "100",
            email: "@gmail.com"
        );
        when(dao.findById(0)).thenAnswer((_) async => dto);

        VisitorEntityObject? visitor = await VisitorEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, 0);
        expect(visitor!.personId, equals(0));
        expect(visitor.city, "bji");

      } catch(error) {
        rethrow;
      } finally {
        await databaseSessionManager.close();
      }
    });

  });
}