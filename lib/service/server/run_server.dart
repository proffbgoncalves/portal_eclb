import 'dart:convert';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/type_of_patrimony_entity_object_impl.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/abstract_database_session_manager.dart';
import 'package:portal_eclb/resource/session/database_session_manager.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Middleware corsHeaders() {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, Content-Type',
  };

  return (innerHandler) {
    return (request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }
      final response = await innerHandler(request);
      return response.change(headers: corsHeaders);
    };
  };
}


Future<void> main() async {

  EnvironmentConfiguration environmentConfiguration = await EnvironmentConfiguration.fromFile("C:\\Users\\fbarr\\StudioProjects\\portal_eclb\\.env");
  DatabaseSessionManager databaseSessionManager = new MariaDBDatabaseSessionManager(environmentConfiguration);
  DAOFactory daoFactory = new MariaDBDAOFactory(environmentConfiguration);

  DependencyInjector dependencyInjector = DependencyInjector.getInstance();
  dependencyInjector.registerDatabaseSessionManager(environmentConfiguration.get("dbms"), databaseSessionManager);
  dependencyInjector.registerDAOFactory(environmentConfiguration.get("dbms"), daoFactory);


  var app = Router();

  app.get('/api/admin/config/types_of_patrimonies/<limit>/<offset>', (Request request, String limit, String offset) async {
    List<Map<String, dynamic>> list;

    DatabaseSessionManager manager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await manager.open();

      List<TypeOfPatrimonyEntityObject> typesOfPatrimonies = await TypeOfPatimonyEntityObjectImpl.getAll(manager, environmentConfiguration, int.parse(limit), int.parse(offset));

      list = typesOfPatrimonies.map((e) {
        return {
          "id" : e.id,
          "description": e.description
        };
      },).toList();

    } catch(error) {
      rethrow;
    } finally {
      await manager.close();
    }

    return Response.ok(jsonEncode(list), headers: {'Content-Type': 'application/json'});
  });

  app.get("/api/admin/config/types_of_patrimonies/count", (Request request) async {

    DatabaseSessionManager manager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);

    try {
      await manager.open();
      int count = await TypeOfPatimonyEntityObjectImpl.count(manager, environmentConfiguration);
      Map<String, int> value = {"count": count};
      return Response.ok(jsonEncode(value), headers: {'Content-Type': 'application/json'});
    } catch (error) {
      rethrow;
    } finally {
      await manager.close();
    }
  });

  app.delete("/api/admin/config/type_of_patrimony/<id>", (Request request, String id) async {

    DatabaseSessionManager manager = AbstractDatabaseSessionManager.getInstance(environmentConfiguration);
    try {
      await manager.open();
      await manager.startTransaction();

      TypeOfPatrimonyEntityObject entity = await TypeOfPatimonyEntityObjectImpl.getById(manager, environmentConfiguration, int.parse(id));
      await entity.delete();

      await manager.commit();
    } catch(error) {
      await manager.rollback();
      rethrow;
    } finally {
      await manager.close();
    }

    return Response.ok("jsonEncode(list)", headers: {'Content-Type': 'application/json'});
  });


  app.get('/user/<user>', (Request request, String user) {
    return Response.ok('hello $user');
  });

  final handler = Pipeline().addMiddleware(logRequests()).addMiddleware(corsHeaders()).addHandler(app);

  var server = await serve(handler, 'localhost', 8080);

}