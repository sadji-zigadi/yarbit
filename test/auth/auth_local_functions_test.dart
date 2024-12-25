import 'package:client/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:client/features/auth/data/models/client_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocking.dart';

void main() {
  late MockHiveInterface hive;
  late AuthLocalDatasourceImpl local;

  setUp(() {
    hive = MockHiveInterface();
    local = AuthLocalDatasourceImpl(hive);
  });

  group(
    'Auth local functions testin',
    () {
      test(
        'Given client model, When cacheClient is invoked, Then no return value',
        () async {
          // Arrange
          ClientModel client = ClientModel(
            id: 'id',
            name: 'name',
            email: 'email',
            address: const {
              'wilaya': 'wilaya',
              'commune': 'commune',
            },
          );
          const String boxName = 'user';
          final box = MockBox();

          when(() => hive.isBoxOpen(boxName)).thenReturn(false);
          when(() => hive.openBox(boxName)).thenAnswer((_) async => box);
          when(() => hive.box(boxName)).thenAnswer((_) => box);
          when(() => box.clear()).thenAnswer((_) async => 1);
          when(() => box.put(any(), any())).thenAnswer((_) async {});
          when(() => box.close()).thenAnswer((_) async {});

          // Act
          await local.cacheUser(client);

          // Assert
          verify(() => hive.isBoxOpen(boxName)).called(2);
          verify(() => hive.openBox(boxName)).called(1);
          verify(() => box.clear()).called(1);
          verify(() => box.put('user', client)).called(1);
        },
      );

      test(
        'Given wilaya, commune and phone number, When cacheDetails is invoked, Then no return value',
        () async {
          // Arrange
          const String wilaya = 'wilaya';
          const String commune = 'commune';
          const String boxName = 'user';
          const String phoneNum = 'phoneNum';
          final MockBox box = MockBox();
          final user = ClientModel(
            id: 'id',
            email: 'email',
            name: 'name',
            address: const {
              'wilaya': 'wilaya',
              'commune': 'commune',
            },
            phoneNum: 'phoneNum',
            pictureUrl: 'pictureUrl',
          );

          when(() => hive.isBoxOpen(boxName)).thenReturn(false);
          when(() => hive.openBox(boxName)).thenAnswer((_) async => box);
          when(() => hive.box(boxName)).thenAnswer((_) => box);
          when(() => box.get('user')).thenAnswer((_) => user);
          when(() => box.put(any(), any())).thenAnswer((_) async {});
          when(() => box.close()).thenAnswer((_) async {});

          // Act
          await local.cacheDetails(
            wilaya: wilaya,
            commune: commune,
            phoneNum: phoneNum,
          );

          // Assert
          verify(() => hive.isBoxOpen(boxName)).called(2);
          verify(() => hive.openBox(boxName)).called(1);
          verify(() => box.put(
              'user',
              user.copyWith(
                address: {
                  'wilaya': wilaya,
                  'commune': commune,
                },
                phoneNum: phoneNum,
              ).mapToModel())).called(1);
        },
      );

      test(
        'Given no value, When isAuth is invoked, then a boolean value is returned',
        () async {
          // Arrange
          final MockBox box = MockBox();
          const String boxName = 'user';
          final user = ClientModel(
            id: 'id',
            email: 'email',
            name: 'name',
            address: const {
              'wilaya': 'wilaya',
              'commune': 'commune',
            },
            phoneNum: 'phoneNum',
            pictureUrl: 'pictureUrl',
          );

          when(() => hive.isBoxOpen(boxName)).thenReturn(false);
          when(() => hive.openBox(boxName)).thenAnswer((_) async => box);
          when(() => hive.box(boxName)).thenAnswer((_) => box);
          when(() => box.close()).thenAnswer((_) async {});
          when(() => box.get('user')).thenAnswer((_) => user);

          // Act
          final res = await local.isAuth();

          // Assert
          expect(res, isA<bool>());
        },
      );

      test(
        'Given no value, When deleteCache is invoked, then no return value',
        () async {
          // Arrange
          final MockBox box = MockBox();
          const String boxName = 'user';
          when(() => hive.isBoxOpen(boxName)).thenReturn(false);
          when(() => hive.openBox(boxName)).thenAnswer((_) async => box);
          when(() => hive.box(boxName)).thenAnswer((_) => box);
          when(() => box.close()).thenAnswer((_) async {});
          when(() => box.clear()).thenAnswer((_) async => 1);

          // Act
          await local.deleteCache();

          // Assert
          verify(() => hive.isBoxOpen(boxName)).called(2);
          verify(() => hive.openBox(boxName)).called(1);
          verify(() => box.clear()).called(1);
        },
      );

      test(
        'Given no value, When getCachedUser is invoked, Then return a ClientModel',
        () async {
          // Arrange
          final box = MockBox();
          final user = ClientModel(
            id: 'id',
            email: 'email',
            name: 'name',
            phoneNum: 'phoneNum',
          );

          when(() => hive.isBoxOpen('user')).thenReturn(false);
          when(() => hive.openBox('user')).thenAnswer((_) async => box);
          when(() => hive.box('user')).thenAnswer((_) => box);
          when(() => box.close()).thenAnswer((_) async {});
          when(() => box.get('user')).thenReturn(user);

          // Act
          final res = await local.getCachedUser();

          // Assert
          expect(res, isA<ClientModel>());
        },
      );

      test(
        'Given an email, When cacheEmail is invoked, Then no value is returned',
        () async {
          // Arrange
          final box = MockBox();
          final user = ClientModel(
            id: 'id',
            email: 'email',
            name: 'name',
            phoneNum: 'phoneNum',
          );

          when(() => hive.isBoxOpen('user')).thenReturn(false);
          when(() => hive.openBox('user')).thenAnswer((_) async => box);
          when(() => hive.box('user')).thenAnswer((_) => box);
          when(() => box.close()).thenAnswer((_) async {});
          when(() => box.get('user')).thenReturn(user);
          when(() => box.put(any(), any())).thenAnswer((_) async {});
          when(() => box.clear()).thenAnswer((_) async => 1);

          // Act
          await local.cacheEmail('email');

          // Assert
          verify(() => hive.isBoxOpen('user')).called(2);
          verify(() => hive.openBox('user')).called(1);
          verify(() => box.clear()).called(1);
          verify(() => box.get('user')).called(1);
          verify(() =>
                  box.put('user', user.copyWith(email: 'email').mapToModel()))
              .called(1);
        },
      );

      test(
        'Given a name, When cacheName is invoked, Then no value is returned',
        () async {
          // Arrange
          final box = MockBox();
          final user = ClientModel(
            id: 'id',
            email: 'email',
            name: 'name',
            phoneNum: 'phoneNum',
          );

          when(() => hive.isBoxOpen('user')).thenReturn(false);
          when(() => hive.openBox('user')).thenAnswer((_) async => box);
          when(() => hive.box('user')).thenAnswer((_) => box);
          when(() => box.close()).thenAnswer((_) async {});
          when(() => box.get('user')).thenReturn(user);
          when(() => box.put(any(), any())).thenAnswer((_) async {});
          when(() => box.clear()).thenAnswer((_) async => 1);

          // Act
          await local.cacheName('name');

          // Assert
          verify(() => hive.isBoxOpen('user')).called(2);
          verify(() => hive.openBox('user')).called(1);
          verify(() => box.clear()).called(1);
          verify(() => box.get('user')).called(1);
          verify(() =>
                  box.put('user', user.copyWith(name: 'name').mapToModel()))
              .called(1);
        },
      );

      test(
        'Given a phone number, When cachePhoneNumber is invoked, Then no value is returned',
        () async {
          // Arrange
          final box = MockBox();
          final user = ClientModel(
            id: 'id',
            email: 'email',
            name: 'name',
            phoneNum: 'phoneNum',
          );

          when(() => hive.isBoxOpen('user')).thenReturn(false);
          when(() => hive.openBox('user')).thenAnswer((_) async => box);
          when(() => hive.box('user')).thenAnswer((_) => box);
          when(() => box.close()).thenAnswer((_) async {});
          when(() => box.get('user')).thenReturn(user);
          when(() => box.put(any(), any())).thenAnswer((_) async {});
          when(() => box.clear()).thenAnswer((_) async => 1);

          // Act
          await local.cacheName('name');

          // Assert
          verify(() => hive.isBoxOpen('user')).called(2);
          verify(() => hive.openBox('user')).called(1);
          verify(() => box.clear()).called(1);
          verify(() => box.get('user')).called(1);
          verify(() => box.put(
                  'user', user.copyWith(phoneNum: 'phone num').mapToModel()))
              .called(1);
        },
      );

      test(
        'Given a picture url, When cacheImage is invoked, Then no value is returned',
        () async {
          // Arrange
          final box = MockBox();
          final user = ClientModel(
            id: 'id',
            email: 'email',
            name: 'name',
            phoneNum: 'phoneNum',
          );

          when(() => hive.isBoxOpen('user')).thenReturn(false);
          when(() => hive.openBox('user')).thenAnswer((_) async => box);
          when(() => hive.box('user')).thenAnswer((_) => box);
          when(() => box.close()).thenAnswer((_) async {});
          when(() => box.get('user')).thenReturn(user);
          when(() => box.put(any(), any())).thenAnswer((_) async {});
          when(() => box.clear()).thenAnswer((_) async => 1);

          // Act
          await local.cacheName('name');

          // Assert
          verify(() => hive.isBoxOpen('user')).called(2);
          verify(() => hive.openBox('user')).called(1);
          verify(() => box.clear()).called(1);
          verify(() => box.get('user')).called(1);
          verify(() => box.put('user',
              user.copyWith(pictureUrl: 'picture url').mapToModel())).called(1);
        },
      );
    },
  );
}
