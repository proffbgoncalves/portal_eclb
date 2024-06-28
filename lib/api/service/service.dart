import 'package:shelf_router/shelf_router.dart';

abstract interface class Service {

  void createRoutes(Router router);

  String get serviceURI;
}