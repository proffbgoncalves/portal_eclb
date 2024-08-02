import 'package:portal_eclb/model/patrimony/composite/visitation_stage.dart';

final class VisitationStageDTO implements VisitationStage{
  int? _id;
  String? _name;
  int? _visitationItineraryId;


  VisitationStageDTO({int? id,
    String? name,
    int? visitationItineraryId,
  }):
      _id = id,
      _name = name,
      _visitationItineraryId = visitationItineraryId;

  int? get visitationItineraryId => _visitationItineraryId;
  set visitationItineraryId(int? value) {
    _visitationItineraryId = value;
  }

  String? get name => _name;
  set name(String? value) {
    _name = value;
  }

  int? get id => _id;
  set id(int? value) {
    _id = value;
  }
}

