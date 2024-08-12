import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

abstract interface class UserDataMapper implements DataMapper {

  List generateFindByLoginStatement(String login);

  List generateFindByFunctionStatement(String function);
}