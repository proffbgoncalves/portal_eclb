import 'package:portal_eclb/api/server/portal_eclb_api_server.dart';
import 'package:portal_eclb/api/service/entity/patrimony/type_of_patrimony_entity_service.dart';

Future<void> main() async {

  PortalECLBAPIServer server = new PortalECLBAPIServer("localhost", 8080);

  server.configureEnvironment(".env");

  server.registerService(new TypeOfPatrimonyEntityService());

  server.run();

}