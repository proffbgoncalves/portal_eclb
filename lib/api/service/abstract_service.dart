import 'package:portal_eclb/api/service/service.dart';

abstract class AbstractService implements Service {

  String _serviceURI;

  AbstractService(this._serviceURI);

  String get serviceURI => _serviceURI;
}