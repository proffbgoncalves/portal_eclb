import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/patrimony/person/notable_person_dto.dart';

void main(){
  group("TestNotablePersonDto", (){


    test("CreateWIthNullValues", (){
      NotablePersonDTO  person = new NotablePersonDTO();
      expect(person.patrimonyPersonId, isNull);
    });

    test("CreateDtoWithValues", (){
      final person2 = new NotablePersonDTO(
        patrimonyPersonId: 0
      );
      expect(person2.patrimonyPersonId, 0);
    });
    
    test("AtribuicaoTest", (){
      final person3 = new NotablePersonDTO();

      person3.patrimonyPersonId = 1;
      expect(person3.patrimonyPersonId, 1);
    });
  });
}
