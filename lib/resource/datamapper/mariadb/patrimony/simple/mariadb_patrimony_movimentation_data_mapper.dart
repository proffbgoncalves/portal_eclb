import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/simple/patrimony_movimentation.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/simple/abstract_patrimony_movimentation_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/simple/patrimony_movimentation_dto.dart';

final class MariaDBPatrimonyMovimentationDataMapper extends AbstractPatrimonyMovimentationDataMapper {

  @override
  List generateList(Iterable resultSet) {
    if (resultSet.isEmpty) {
      throw new Exception("PatrimonyMovimentation list cannot be generated.");
    }

    Results results = resultSet as Results;

    List<PatrimonyMovimentation> movimentationList = [];

    for (var row in results) {
      PatrimonyMovimentation movimentation = new PatrimonyMovimentationDTO(
          id: row[0],
          date: row[1],
          origin: row[2],
          destination: row[3],
          description: row[4],
          simplePatrimonyId: row[5]
      );
      movimentationList.add(movimentation);
    }
    return movimentationList;
  }

  @override
  Object generateObject(Iterable resultSet) {
    if (resultSet.isEmpty) {
      throw new Exception("PatrimonyMovimentation object cannot be generated.");
    }

    Results results = resultSet as Results;
    PatrimonyMovimentation movimentation = new PatrimonyMovimentationDTO(
        id: results.first[0],
        date: results.first[1],
        origin: results.first[2],
        destination: results.first[3],
        description: results.first[4],
        simplePatrimonyId: results.first[5]
    );
    return movimentation;
  }

  @override
  List generateCountStatement() {
    return ["SELECT COUNT(*) FROM PATRIMONYMOVIMENTATION"];
  }
}
