import 'package:get_it/get_it.dart';
import 'package:portal_eclb/api/service/service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

abstract class AbstractAPIServer {

  String _ipAddress;
  int _port;

  Map<String, Service> _services = {};

  Pipeline _mainPipeline = new Pipeline();
  late Pipeline _logRequestsPipeline;
  late Pipeline _corsHeadersPipeline;

  Future<void> configureEnvironment(String filename);

  AbstractAPIServer(this._ipAddress, this._port) {
    this._logRequestsPipeline = this._mainPipeline.addMiddleware(logRequests());
    this._corsHeadersPipeline = this._logRequestsPipeline.addMiddleware(this._corsHeaders());
  }

  Future<void> run() async {
    Router router = new Router();

    for (Service service in this._services.values) {
      service.createRoutes(router);
    }

    Handler handler = this._corsHeadersPipeline.addHandler(router);

    await serve(handler, this._ipAddress, this._port);
  }

  Middleware _corsHeaders() {
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
  
  void registerService(Service service) {
    throwIf(this._services.containsKey(service.serviceURI), new Exception("Já existe um serviço registrado em: ${service.serviceURI}"));

    this._services[service.serviceURI] = service;
  }

  void unresgisterService(String serviceURI) {
    throwIf(!this._services.containsKey(serviceURI), new Exception("Não existe serviço registrado em: ${serviceURI}"));

    this._services.remove(serviceURI);
  }

  int coutRegisteredServices() {
    return this._services.length;
  }



}