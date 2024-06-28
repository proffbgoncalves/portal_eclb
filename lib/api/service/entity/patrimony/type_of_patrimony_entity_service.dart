import 'dart:convert';

import 'package:portal_eclb/api/service/abstract_service.dart';
import 'package:portal_eclb/api/service/entity/entity_service.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object_impl.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';


final class TypeOfPatrimonyEntityService extends AbstractService implements EntityService {


  TypeOfPatrimonyEntityService() : super("/api/service/entity/patrimony/type_of_patrimony");

  @override
  void createRoutes(Router route) {

    route.add("get", this.serviceURI + "/get_all/<limit>/<offset>", this.getAll);
    route.add("get", this.serviceURI + "/get_by_id/<id>", this.getById);
    route.add("get", this.serviceURI + "/count", this.count);

    route.add("delete", this.serviceURI + "/delete/<id>", this.delete);

    route.add("post", this.serviceURI + "/insert", this.insert);

    route.add("put", this.serviceURI + "/update/<id>", this.update);


  }

  @override
  Future<Response> delete(Request request) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
    DatabaseSessionManager databaseSessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await databaseSessionManager.open();
      await databaseSessionManager.startTransaction();

      int id = int.parse(request.params["id"].toString());
      TypeOfPatrimonyEntityObject? entity = await TypeOfPatimonyEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, id);

      if (entity == null) {
        throw new Exception("Tipo de patrimônio não encontrado.");
      }

      await entity.delete();

      await databaseSessionManager.commit();
    } catch(error) {
      await databaseSessionManager.rollback();
      Map<String, String> errorMessage = {
        "message" : error.toString()
      };
      return Response.internalServerError(body: jsonEncode(errorMessage), headers: {'Content-Type': 'application/json'});
    } finally {
      await databaseSessionManager.close();
    }
    Map<String, String> successMessage = {
      "message" : "Tipo de patrimônio foi excluído com sucesso."
    };
    return Response.ok(jsonEncode(successMessage), headers: {'Content-Type': 'application/json'});
  }

  @override
  Future<Response> getAll(Request request) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
    DatabaseSessionManager databaseSessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    List data = [];
    try {
      await databaseSessionManager.open();

      int limit = int.parse(request.params["limit"].toString());
      int offset = int.parse(request.params["offset"].toString());

      List<TypeOfPatrimony> typesOfPatrimonies = await TypeOfPatimonyEntityObjectImpl.getAll(databaseSessionManager, environmentConfiguration, limit, offset);

      data = typesOfPatrimonies.map((e) {
        return {
          "id" : e.id,
          "description" : e.description
        };
      },).toList();
    } catch(error) {
      Map<String, String> errorMessage = {
        "message" : error.toString()
      };
      return Response.internalServerError(body: jsonEncode(errorMessage), headers: {'Content-Type': 'application/json'});
    } finally {
      await databaseSessionManager.close();
    }
    return Response.ok(jsonEncode(data), headers: {'Content-Type': 'application/json'});
  }

  @override
  Future<Response> getById(Request request) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
    DatabaseSessionManager databaseSessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    Map<String, dynamic> data = {};
    try {
      await databaseSessionManager.open();

      int id = int.parse(request.params["id"].toString());
      TypeOfPatrimonyEntityObject? entityObject = await TypeOfPatimonyEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, id);

      if (entityObject == null) {
        throw new Exception("Tipo de patrimônio não encontrado.");
      }

      data = {
        "id" : entityObject.id,
        "description" : entityObject.description
      };

    } catch (error) {
      Map<String, String> errorMessage = {
        "message" : error.toString()
      };
      return Response.internalServerError(body: jsonEncode(errorMessage), headers: {'Content-Type': 'application/json'});
    } finally {
      await databaseSessionManager.close();
    }

    return Response.ok(jsonEncode(data), headers: {'Content-Type': 'application/json'});
  }

  @override
  Future<Response> insert(Request request) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
    DatabaseSessionManager databaseSessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await databaseSessionManager.open();
      await databaseSessionManager.startTransaction();

      String payload = await request.readAsString();
      dynamic data = jsonDecode(payload);

      TypeOfPatimonyEntityObjectImpl entityObject = new TypeOfPatimonyEntityObjectImpl(databaseSessionManager, environmentConfiguration, data["description"]);
      await entityObject.insert();

      await databaseSessionManager.commit();
    } catch(error) {
      await databaseSessionManager.rollback();
      Map<String, String> errorMessage = {
        "message" : error.toString()
      };
      return Response.internalServerError(body: jsonEncode(errorMessage), headers: {'Content-Type': 'application/json'});
    } finally {
      await databaseSessionManager.close();
    }
    Map<String, String> successMessage = {
      "message" : "Tipo de patrimônio inserido com sucesso."
    };
    return Response.ok(jsonEncode(successMessage), headers: {'Content-Type': 'application/json'});
  }

  @override
  Future<Response> update(Request request) async {
    DependencyInjector dependencyInjector = DependencyInjector.getInstance();
    EnvironmentConfiguration environmentConfiguration = dependencyInjector.getEnvironmentConfigurarion();
    DatabaseSessionManager databaseSessionManager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await databaseSessionManager.open();
      await databaseSessionManager.startTransaction();

      int id = int.parse(request.params["id"].toString());

      TypeOfPatrimonyEntityObject? entityObject = await TypeOfPatimonyEntityObjectImpl.getById(databaseSessionManager, environmentConfiguration, id);

      if (entityObject == null) {
        throw new Exception("Tipo de patrimônio não foi encontrado.");
      }

      String payload = await request.readAsString();
      dynamic data = jsonDecode(payload);

      entityObject?.description = data["description"];

      await entityObject?.update();

      await databaseSessionManager.commit();
    } catch(error) {
      await databaseSessionManager.rollback();
      Map<String, String> errorMessage = {
        "message" : error.toString()
      };
      return Response.internalServerError(body: jsonEncode(errorMessage), headers: {'Content-Type': 'application/json'});
    } finally {
      await databaseSessionManager.close();
    }
    Map<String, String> successMessage = {
      "message" : "Tipo de patrimônio atualizado com sucesso."
    };
    return Response.ok(jsonEncode(successMessage), headers: {'Content-Type': 'application/json'});
  }

  @override
  Future<Response> count(Request request) {
    // TODO: implement count
    throw UnimplementedError();
  }

}