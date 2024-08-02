import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

 abstract interface class NotablePersonDataMapper implements DataMapper{
  List generateFindByPatrimonyPersonId(int patrimonyPersonId);

}