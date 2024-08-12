import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/transferency/dto/person/user/user_dto.dart';

void main() {

  group('UserDTOTest', () {

    test('testCreateUserDTO verificando valores null', () {

      final user = UserDTO();

      expect(user.personId, isNull);
      expect(user.login, isNull);
      expect(user.password, isNull);
      expect(user.function, isNull);
    });

    test('testCreateUserDTO', () {

      final user = UserDTO(
          personId: 1,
          login: 'devmoreir4',
          password: '12345',
          function: 'dev'
      );

      expect(user.personId, 1);
      expect(user.login, 'devmoreir4');
      expect(user.password, '12345');
      expect(user.function, 'dev');
    });

    test('testGetterAndSetterForPersonID', () {

      final user = UserDTO();

      user.personId = 10;

      expect(user.personId, 10);
    });

    test('testGetterAndSetterForLogin', () {

      final user = UserDTO();

      user.login = 'new_devmoreir4';

      expect(user.login, 'new_devmoreir4');
    });

    test('testGetterAndSetterForPassword', () {

      final user = UserDTO();

      user.password = 'new_password_123';

      expect(user.password, 'new_password_123');
    });

    test('testGetterAndSetterForFunction', () {

      final user = UserDTO();

      user.function = 'new_function';

      expect(user.function, 'new_function');
    });
  });
}
