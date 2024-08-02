import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/composite/visitation_stage_dto.dart';

void main(){

  group("TestsVisitationStageDTO", (){


    test("CreateWithNullValues", (){


      final visitation = VisitationStageDTO();
      expect(visitation.id, isNull);
      expect(visitation.name, isNull);
      expect(visitation.visitationItineraryId, isNull);

    });
    test("CreateWithValues", (){
      final visitation2 = VisitationStageDTO(
        id: 0,
        name: "patrimonio",
        visitationItineraryId: 0
      );

      expect(visitation2.id, 0);
      expect(visitation2.name, "patrimonio");
      expect(visitation2.visitationItineraryId, 0);
    });

    test("TestAtribuicaoValores", (){
      final visitation3 = VisitationStageDTO();

      visitation3.id = 0;
      visitation3.name = "patrimonio";
      visitation3.visitationItineraryId = 0;

      expect(visitation3.id, 0);
      expect(visitation3.name, "patrimonio");
      expect(visitation3.visitationItineraryId, 0);
    });
  });

}