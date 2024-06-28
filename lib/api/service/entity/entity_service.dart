import 'package:portal_eclb/api/service/service.dart';
import 'package:shelf/shelf.dart';

abstract interface class EntityService implements Service {

  Future<Response> insert(Request request);

  Future<Response> delete(Request request);

  Future<Response> update(Request request);

  Future<Response> getById(Request request);

  Future<Response> getAll(Request request);

  Future<Response> count(Request request);
}