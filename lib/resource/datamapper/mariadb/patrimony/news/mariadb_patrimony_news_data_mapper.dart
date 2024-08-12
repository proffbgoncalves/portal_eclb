import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/news/abstract_patrimony_news_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/news/patrimony_news_dto.dart';

final class MariaDBPatrimonyNewsDataMapper extends AbstractPatrimonyNewsDataMapper {

  @override
  List generateList(Iterable resultSet) {
    throwIf(resultSet.isEmpty, new Exception("Patrimony news cannot be generated."));

    Results results = resultSet as Results;

    List patrimonyNewsList = [];

    for (ResultRow row in results) {
      PatrimonyNewsDTO dto = new PatrimonyNewsDTO(
          id: row[0],
          title: row[1],
          description: row[2],
          patrimonyId: row[3],
          typeOfPatrimonyNewsId: row[4]
      );
      patrimonyNewsList.add(dto);
    }
    return patrimonyNewsList;
  }

  @override
  Object generateObject(Iterable resultSet) {
    throwIf(resultSet.isEmpty, new Exception("Patrimony news cannot be generated."));

    Results results = resultSet as Results;
    return new PatrimonyNewsDTO(
        id: results.first[0],
        title: results.first[1],
        description: results.first[2],
        patrimonyId: results.first[3],
        typeOfPatrimonyNewsId: results.first[4]
    );
  }

  @override
  List generateCountStatement() {
    return ["SELECT COUNT(*) FROM PATRIMONYNEWS"];
  }
}
