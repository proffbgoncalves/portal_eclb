
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/person/visitor/visitor_dto.dart';

void main(){
  group("VisitorDTOTest", (){

    test("createVisitorDTOWithNullValues", (){

      final visitante = VisitorDTO();

      expect( visitante.personId, isNull);
      expect(visitante.memoryId, isNull);
      expect(visitante.address, isNull);
      expect(visitante.city, isNull);
      expect(visitante.district, isNull);
      expect(visitante.email, isNull);
      expect(visitante.complemento, isNull);
      expect(visitante.number, isNull);
      expect(visitante.phone, isNull);
      expect(visitante.district, isNull);
      expect(visitante.state, isNull);
      expect(visitante.postalCode, isNull);
    });

    test("createVisitorDTOWithValues", (){

      final visitante = VisitorDTO(
          personId: 0,
          memoryId: 0,
          address: "rua",
          state: "rio",
          number: 100,
          complemento: "ali",
          district: "centro",
          phone: "2299",
          postalCode: "100",
          email: "@gmail.com"
      );

      expect(visitante.personId, 0);
      expect(visitante.memoryId, 0);
      expect(visitante.address, "rua");
      expect(visitante.state, "rio");
      expect(visitante.number, 100);
      expect(visitante.complemento, "ali");
      expect(visitante.district, "centro");
      expect(visitante.phone, "2299");
      expect(visitante.postalCode, "100");
      expect(visitante.email, "@gmail.com");
    });

    test("TestAtribuicaoValores", (){
      final visitante = VisitorDTO();

      visitante.personId = 0;
      visitante.memoryId= 0;
      visitante.address="rua";
      visitante.state="rio";
      visitante.city = "bji";
      visitante.number= 100;
      visitante.complemento= "ali";
      visitante.district= "centro";
      visitante.phone= "2299";
      visitante.postalCode= "100";
      visitante.email= "@gmail.com";

      expect(visitante.personId, 0);
      expect(visitante.memoryId, 0);
      expect(visitante.address, "rua");
      expect(visitante.state, "rio");
      expect(visitante.number, 100);
      expect(visitante.complemento, "ali");
      expect(visitante.district, "centro");
      expect(visitante.phone, "2299");
      expect(visitante.postalCode, "100");
      expect(visitante.email, "@gmail.com");
    });
  });
}