// Mocks generated by Mockito 5.4.4 from annotations
// in portal_eclb/test/mocks/portal_eclb_mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i12;
import 'package:portal_eclb/model/person/visitor/visitor.dart' as _i14;
import 'package:portal_eclb/resource/dao/dao_factory.dart' as _i13;
import 'package:portal_eclb/resource/dao/patrimony/composite/visitation_stage_dao.dart'
    as _i9;
import 'package:portal_eclb/resource/dao/patrimony/event/type_of_event_dao.dart'
    as _i7;
import 'package:portal_eclb/resource/dao/patrimony/media/type_of_media_dao.dart'
    as _i6;
import 'package:portal_eclb/resource/dao/patrimony/patrimony_dao.dart' as _i4;
import 'package:portal_eclb/resource/dao/patrimony/person/notable_person_dao.dart'
    as _i10;
import 'package:portal_eclb/resource/dao/patrimony/person/type_of_acting_dao.dart'
    as _i5;
import 'package:portal_eclb/resource/dao/patrimony/type_of_patrimony_dao.dart'
    as _i3;
import 'package:portal_eclb/resource/dao/person/visitor/visitor_dao.dart'
    as _i8;
import 'package:portal_eclb/resource/session/database_session_manager.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeObject_0 extends _i1.SmartFake implements Object {
  _FakeObject_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDatabaseSessionManager_1 extends _i1.SmartFake
    implements _i2.DatabaseSessionManager {
  _FakeDatabaseSessionManager_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTypeOfPatrimonyDAO_2 extends _i1.SmartFake
    implements _i3.TypeOfPatrimonyDAO {
  _FakeTypeOfPatrimonyDAO_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePatrimonyDAO_3 extends _i1.SmartFake implements _i4.PatrimonyDAO {
  _FakePatrimonyDAO_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTypeOfActingDAO_4 extends _i1.SmartFake
    implements _i5.TypeOfActingDAO {
  _FakeTypeOfActingDAO_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTypeOfMediaDAO_5 extends _i1.SmartFake
    implements _i6.TypeOfMediaDAO {
  _FakeTypeOfMediaDAO_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTypeOfEventDAO_6 extends _i1.SmartFake
    implements _i7.TypeOfEventDAO {
  _FakeTypeOfEventDAO_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeVisitorDAO_7 extends _i1.SmartFake implements _i8.VisitorDAO {
  _FakeVisitorDAO_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeVisitationStageDAO_8 extends _i1.SmartFake
    implements _i9.VisitationStageDAO {
  _FakeVisitationStageDAO_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNotablePersonDAO_9 extends _i1.SmartFake
    implements _i10.NotablePersonDAO {
  _FakeNotablePersonDAO_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DatabaseSessionManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseSessionManager extends _i1.Mock
    implements _i2.DatabaseSessionManager {
  MockDatabaseSessionManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isOpened => (super.noSuchMethod(
        Invocation.getter(#isOpened),
        returnValue: false,
      ) as bool);

  @override
  bool get isOnTransaction => (super.noSuchMethod(
        Invocation.getter(#isOnTransaction),
        returnValue: false,
      ) as bool);

  @override
  _i11.Future<bool> open() => (super.noSuchMethod(
        Invocation.method(
          #open,
          [],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);

  @override
  _i11.Future<dynamic> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i11.Future<dynamic>.value(),
      ) as _i11.Future<dynamic>);

  @override
  _i11.Future<Object> execute(
    String? sql, [
    List<dynamic>? values,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            sql,
            values,
          ],
        ),
        returnValue: _i11.Future<Object>.value(_FakeObject_0(
          this,
          Invocation.method(
            #execute,
            [
              sql,
              values,
            ],
          ),
        )),
      ) as _i11.Future<Object>);

  @override
  _i11.Future<Iterable<dynamic>?> executeQuery(
    String? sql, [
    List<Object>? values,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #executeQuery,
          [
            sql,
            values,
          ],
        ),
        returnValue: _i11.Future<Iterable<dynamic>?>.value(),
      ) as _i11.Future<Iterable<dynamic>?>);

  @override
  _i11.Future<bool> commit() => (super.noSuchMethod(
        Invocation.method(
          #commit,
          [],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);

  @override
  _i11.Future<dynamic> rollback() => (super.noSuchMethod(
        Invocation.method(
          #rollback,
          [],
        ),
        returnValue: _i11.Future<dynamic>.value(),
      ) as _i11.Future<dynamic>);

  @override
  String getType() => (super.noSuchMethod(
        Invocation.method(
          #getType,
          [],
        ),
        returnValue: _i12.dummyValue<String>(
          this,
          Invocation.method(
            #getType,
            [],
          ),
        ),
      ) as String);

  @override
  _i11.Future<dynamic> startTransaction() => (super.noSuchMethod(
        Invocation.method(
          #startTransaction,
          [],
        ),
        returnValue: _i11.Future<dynamic>.value(),
      ) as _i11.Future<dynamic>);

  @override
  _i2.DatabaseSessionManager clone() => (super.noSuchMethod(
        Invocation.method(
          #clone,
          [],
        ),
        returnValue: _FakeDatabaseSessionManager_1(
          this,
          Invocation.method(
            #clone,
            [],
          ),
        ),
      ) as _i2.DatabaseSessionManager);
}

/// A class which mocks [DAOFactory].
///
/// See the documentation for Mockito's code generation for more information.
class MockDAOFactory extends _i1.Mock implements _i13.DAOFactory {
  MockDAOFactory() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TypeOfPatrimonyDAO createTypeOfPatrimonyDAO(
          _i2.DatabaseSessionManager? databaseSessionManager) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTypeOfPatrimonyDAO,
          [databaseSessionManager],
        ),
        returnValue: _FakeTypeOfPatrimonyDAO_2(
          this,
          Invocation.method(
            #createTypeOfPatrimonyDAO,
            [databaseSessionManager],
          ),
        ),
      ) as _i3.TypeOfPatrimonyDAO);

  @override
  _i4.PatrimonyDAO createPatrimonyDAO(
          _i2.DatabaseSessionManager? databaseSessionManager) =>
      (super.noSuchMethod(
        Invocation.method(
          #createPatrimonyDAO,
          [databaseSessionManager],
        ),
        returnValue: _FakePatrimonyDAO_3(
          this,
          Invocation.method(
            #createPatrimonyDAO,
            [databaseSessionManager],
          ),
        ),
      ) as _i4.PatrimonyDAO);

  @override
  _i5.TypeOfActingDAO createTypeOfActingDAO(
          _i2.DatabaseSessionManager? databaseSessionManager) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTypeOfActingDAO,
          [databaseSessionManager],
        ),
        returnValue: _FakeTypeOfActingDAO_4(
          this,
          Invocation.method(
            #createTypeOfActingDAO,
            [databaseSessionManager],
          ),
        ),
      ) as _i5.TypeOfActingDAO);

  @override
  _i6.TypeOfMediaDAO createTypeOfMediaDAO(
          _i2.DatabaseSessionManager? databaseSessionManager) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTypeOfMediaDAO,
          [databaseSessionManager],
        ),
        returnValue: _FakeTypeOfMediaDAO_5(
          this,
          Invocation.method(
            #createTypeOfMediaDAO,
            [databaseSessionManager],
          ),
        ),
      ) as _i6.TypeOfMediaDAO);

  @override
  _i7.TypeOfEventDAO createTypeOfEventDAO(
          _i2.DatabaseSessionManager? databaseSessionManager) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTypeOfEventDAO,
          [databaseSessionManager],
        ),
        returnValue: _FakeTypeOfEventDAO_6(
          this,
          Invocation.method(
            #createTypeOfEventDAO,
            [databaseSessionManager],
          ),
        ),
      ) as _i7.TypeOfEventDAO);

  @override
  _i8.VisitorDAO createVisitorDAO(
          _i2.DatabaseSessionManager? databaseSessionManager) =>
      (super.noSuchMethod(
        Invocation.method(
          #createVisitorDAO,
          [databaseSessionManager],
        ),
        returnValue: _FakeVisitorDAO_7(
          this,
          Invocation.method(
            #createVisitorDAO,
            [databaseSessionManager],
          ),
        ),
      ) as _i8.VisitorDAO);

  @override
  _i9.VisitationStageDAO createVisitationStageDAO(
          _i2.DatabaseSessionManager? databaseSessionManager) =>
      (super.noSuchMethod(
        Invocation.method(
          #createVisitationStageDAO,
          [databaseSessionManager],
        ),
        returnValue: _FakeVisitationStageDAO_8(
          this,
          Invocation.method(
            #createVisitationStageDAO,
            [databaseSessionManager],
          ),
        ),
      ) as _i9.VisitationStageDAO);

  @override
  _i10.NotablePersonDAO createNotablePersonDAO(
          _i2.DatabaseSessionManager? databaseSessionManager) =>
      (super.noSuchMethod(
        Invocation.method(
          #createNotablePersonDAO,
          [databaseSessionManager],
        ),
        returnValue: _FakeNotablePersonDAO_9(
          this,
          Invocation.method(
            #createNotablePersonDAO,
            [databaseSessionManager],
          ),
        ),
      ) as _i10.NotablePersonDAO);
}

/// A class which mocks [TypeOfEventDAO].
///
/// See the documentation for Mockito's code generation for more information.
class MockTypeOfEventDAO extends _i1.Mock implements _i7.TypeOfEventDAO {
  MockTypeOfEventDAO() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<bool> insert(Object? dto) => (super.noSuchMethod(
        Invocation.method(
          #insert,
          [dto],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);

  @override
  _i11.Future<bool> update(Object? dto) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [dto],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);

  @override
  _i11.Future<bool> delete(Object? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);

  @override
  _i11.Future<Object?> findById(Object? id) => (super.noSuchMethod(
        Invocation.method(
          #findById,
          [id],
        ),
        returnValue: _i11.Future<Object?>.value(),
      ) as _i11.Future<Object?>);

  @override
  _i11.Future<List<dynamic>> findAll([
    int? limit,
    int? offset,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAll,
          [
            limit,
            offset,
          ],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<int> count() => (super.noSuchMethod(
        Invocation.method(
          #count,
          [],
        ),
        returnValue: _i11.Future<int>.value(0),
      ) as _i11.Future<int>);
}

/// A class which mocks [VisitorDAO].
///
/// See the documentation for Mockito's code generation for more information.
class MockVisitorDAO extends _i1.Mock implements _i8.VisitorDAO {
  MockVisitorDAO() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<_i14.Visitor?> findByPersonId(int? personId) =>
      (super.noSuchMethod(
        Invocation.method(
          #findByPersonId,
          [personId],
        ),
        returnValue: _i11.Future<_i14.Visitor?>.value(),
      ) as _i11.Future<_i14.Visitor?>);

  @override
  _i11.Future<List<dynamic>> findAllByAddress(String? address) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAllByAddress,
          [address],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<List<dynamic>> findAllByNumber(int? number) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAllByNumber,
          [number],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<List<dynamic>> findAllByComplemento(String? complemento) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAllByComplemento,
          [complemento],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<List<dynamic>> findAllByDistrict(String? district) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAllByDistrict,
          [district],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<List<dynamic>> findAllByCity(String? city) => (super.noSuchMethod(
        Invocation.method(
          #findAllByCity,
          [city],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<List<dynamic>> findAllByState(String? state) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAllByState,
          [state],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<List<dynamic>> findAllByPostalCode(String? postalCode) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAllByPostalCode,
          [postalCode],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<List<dynamic>> findAllByPhone(String? phone) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAllByPhone,
          [phone],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<_i14.Visitor?> findByEmail(String? email) => (super.noSuchMethod(
        Invocation.method(
          #findByEmail,
          [email],
        ),
        returnValue: _i11.Future<_i14.Visitor?>.value(),
      ) as _i11.Future<_i14.Visitor?>);

  @override
  _i11.Future<_i14.Visitor?> findByMemoryId(int? memoryId) =>
      (super.noSuchMethod(
        Invocation.method(
          #findByMemoryId,
          [memoryId],
        ),
        returnValue: _i11.Future<_i14.Visitor?>.value(),
      ) as _i11.Future<_i14.Visitor?>);

  @override
  _i11.Future<bool> insert(Object? dto) => (super.noSuchMethod(
        Invocation.method(
          #insert,
          [dto],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);

  @override
  _i11.Future<bool> update(Object? dto) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [dto],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);

  @override
  _i11.Future<bool> delete(Object? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);

  @override
  _i11.Future<Object?> findById(Object? id) => (super.noSuchMethod(
        Invocation.method(
          #findById,
          [id],
        ),
        returnValue: _i11.Future<Object?>.value(),
      ) as _i11.Future<Object?>);

  @override
  _i11.Future<List<dynamic>> findAll([
    int? limit,
    int? offset,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #findAll,
          [
            limit,
            offset,
          ],
        ),
        returnValue: _i11.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i11.Future<List<dynamic>>);

  @override
  _i11.Future<int> count() => (super.noSuchMethod(
        Invocation.method(
          #count,
          [],
        ),
        returnValue: _i11.Future<int>.value(0),
      ) as _i11.Future<int>);
}
