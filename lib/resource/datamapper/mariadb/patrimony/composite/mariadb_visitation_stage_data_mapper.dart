import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/composite/abstract_visitation_stage_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/default_visitation_stage_dto.dart';


final class MariadbVisitationStageDataMapper extends AbstractVisitationStageDataMapper {
  @override
  List generateList(Iterable resultSet) {
    throwIf(resultSet.length == 0, Exception("Visitation stages cannot be generated."));

    resultSet as Results;
    List visitationStages = [];

    for (ResultRow row in resultSet) {
      DefaultVisitationStageDTO dto = DefaultVisitationStageDTO(
          id: row[0],
          name: row[1],
          visitationItineraryId: row[2]
      );
      visitationStages.add(dto);
    }
    return visitationStages;
  }

  @override
  Object? generateObject(Iterable resultSet) {
    throwIf(resultSet.length == 0, Exception("Visitation stage cannot be generated."));
    resultSet as Results;

    return DefaultVisitationStageDTO(
        id: resultSet.first[0],
        name: resultSet.first[1],
        visitationItineraryId: resultSet.first[2]
    );
  }
}
