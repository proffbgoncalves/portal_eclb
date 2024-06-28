import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/person/type_of_acting_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/person/type_of_acting_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';


void main(){
  
  group("TypeOfActingEntityObjectTest", (){
    
    setUp(() async{
      
      DependencyInjector injector = DependencyInjector.getInstance();
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      MariaDBDatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);
      
      if (!injector.hasDatabaseSessionManager(environmentConfiguration.get("dbms"))){
        injector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);
      }
      if (!injector.hasDAOFactory(environmentConfiguration.get("dbms"))){
        injector.registerDAOFactory(environmentConfiguration.get("dbms"), new MariaDBDAOFactory(environmentConfiguration));
      }
      
      try {
        await databaseSessionManager.open();
        await databaseSessionManager.startTransaction();
        await databaseSessionManager.execute("DELETE FROM TYPESOFACTINGS");
        await databaseSessionManager.execute("INSERT INTO TYPESOFACTINGS (DESCRIPTION) VALUES (?)",["Natural"]);
        await databaseSessionManager.execute("INSERT INTO TYPESOFACTINGS (DESCRIPTION) VALUES (?)",["Imaterial"]);
        await databaseSessionManager.execute("INSERT INTO TYPESOFACTINGS (DESCRIPTION) VALUES (?)",["Cultural"]);
        await databaseSessionManager.commit();
      }catch(e){
        await databaseSessionManager.rollback();
        throw e;
      }finally{
        await databaseSessionManager.close();
      }

    });

    test("testCreateAndInsertTypeOfACtingEntityObject", () async{

      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");


      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);
      TypeOfActingEntityObject entity = new TypeOfActingEntityObjectImpl(sessionManager, environmentConfiguration,"Teste");
      expect(entity.description, equals("Teste"));

      try{

        await sessionManager.open();
        await sessionManager.startTransaction();

        await entity.insert();
        expect(entity.id, greaterThan(0));

        await sessionManager.commit();
      }catch (e){
        await sessionManager.rollback();
        throw e;
      }finally{
        await sessionManager.close();
      }
    });
    
    test("testGetByDescriptionTypeOfActingEntityObject", () async{
      EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
      DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

      try{
        await sessionManager.open();

        TypeOfActingEntityObject entity = await TypeOfActingEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Imaterial");
        expect(entity.description, equals("Imaterial"));
        expect(entity.id, greaterThan(0));
      }catch (e){
        throw e;
      }finally{
        await sessionManager.close();
      }

    });

  });

  test("testDeleteTypeOFActingEntityObject", () async{
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try{
      await sessionManager.open();
      await sessionManager.startTransaction();

      TypeOfActingEntityObject entity = await TypeOfActingEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Imaterial");

      expect(entity.description, equals("Imaterial"));
      expect(await entity.delete(), isTrue);

      await sessionManager.commit();
    }catch (e){
      await sessionManager.rollback();
      throw e;
    }finally{
      await sessionManager.close();
    }
  });

  test("testUpdateTypeOfActingEntityObject", ()async{
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await sessionManager.open();
      await sessionManager.startTransaction();

      TypeOfActingEntityObject entity = await TypeOfActingEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Natural");

      expect(entity.description, equals("Natural"));

      entity.description = "Teste de Atualização";

      expect(await entity.update(), isTrue);

      await sessionManager.commit();

      entity = await TypeOfActingEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Teste de Atualização");
      expect(entity.description, equals("Teste de Atualização"));
    }catch (e){
      await sessionManager.rollback();
      throw e;
    }finally {
      await sessionManager.close();
    }

  });

  test("testFindByTypeActingEntityObject", ()async{
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try{

      await sessionManager.open();

      TypeOfActingEntityObject entity = (await TypeOfActingEntityObjectImpl.getByDescription(sessionManager, environmentConfiguration, "Cultural")) as TypeOfActingEntityObject;
      expect(entity.description, equals("Cultural"));
      expect(entity.id, greaterThan(0));

      TypeOfActingEntityObject otherEntity = (await TypeOfActingEntityObjectImpl.getById(sessionManager, environmentConfiguration, entity.id!)) as TypeOfActingEntityObject;
      expect(entity.description, equals("Cultural"));
    }catch (e){
      throw e;
    }finally{
      await sessionManager.close();
    }
  });

  test("testFindAllTypeOfActingEntityObject", ()async{
    EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile(".env_dev");
    DatabaseSessionManager sessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try{
      await sessionManager.open();

      List<TypeOfActingEntityObject> entities = await TypeOfActingEntityObjectImpl.getAll(sessionManager, environmentConfiguration);
      expect(entities.length, equals(2));


      expect(entities[0].description, equals("Cultural"));
      expect(entities[0].id, greaterThan(0));
      expect(entities[1].description, equals("Teste de Atualização"));
      expect(entities[1].id, greaterThan(0));
    }catch (e){
      throw e;
    }finally {
      await sessionManager.close();
    }
  });
}