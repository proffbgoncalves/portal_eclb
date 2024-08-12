import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/media/media.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/abstract_media_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/media/media_dto.dart';

final class MariaDBMediaDataMapper extends AbstractMediaDataMapper {

  List generateList(Iterable resultSet) {
    if (resultSet.isEmpty) {
      throw new Exception("Media list cannot be generated.");
    }

    Results results = resultSet as Results;

    List<Media> mediaList = [];

    for (var row in results) {
      Media media = new MediaDTO(
          id: row[0],
          name: row[1],
          description: row[2],
          file: row[3],
          extension: row[4],
          patrimonyId: row[5],
          typesOfMediaId: row[6]
      );
      mediaList.add(media);
    }
    return mediaList;
  }

  Object generateObject(Iterable resultSet) {
    if (resultSet.isEmpty) {
      throw new Exception("Media object cannot be generated.");
    }

    Results results = resultSet as Results;
    Media media = new MediaDTO(
        id: results.first[0],
        name: results.first[1],
        description: results.first[2],
        file: results.first[3],
        extension: results.first[4],
        patrimonyId: results.first[5],
        typesOfMediaId: results.first[6]
    );
    return media;
  }

  @override
  List generateCountStatement() {
    return ["SELECT COUNT(*) FROM MEDIA"];
  }

}
