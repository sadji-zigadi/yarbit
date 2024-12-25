import 'package:hive/hive.dart';

import '../../../../core/utils/hive_functions.dart';
import '../models/client_model.dart';

abstract class AuthLocalDatasource {
  Future<void> cacheUser(ClientModel client);
  Future<void> cacheDetails({
    required String wilaya,
    required String commune,
    required String phoneNum,
  });
  Future<bool> isAuth();
  Future<void> deleteCache();
  Future<ClientModel> getCachedUser();
  Future<void> cacheName(String name);
  Future<void> cachePhoneNumber(String phoneNumber);
  Future<void> cacheEmail(String email);
  Future<void> cacheImage(String pictureUrl);
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final HiveInterface _hive;

  AuthLocalDatasourceImpl(this._hive);

  @override
  Future<void> cacheUser(ClientModel user) async {
    await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (box) async {
        await box.clear();
        await box.put('user', user);
      },
    );
  }

  @override
  Future<void> cacheDetails({
    required String wilaya,
    required String commune,
    required String phoneNum,
  }) async {
    await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (box) async {
        final ClientModel user = box.get('user');

        await box.put(
          'user',
          user.copyWith(
            address: {
              'wilaya': wilaya,
              'commune': commune,
            },
            phoneNum: phoneNum,
          ).mapToModel(),
        );
      },
    );
  }

  @override
  Future<bool> isAuth() async {
    bool isAuth = false;
    await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (box) async {
        final user = box.get('user', defaultValue: null);
        if (user != null) {
          isAuth = true;
        }
      },
    );

    return isAuth;
  }

  @override
  Future<void> deleteCache() async {
    await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (userBox) async {
        await userBox.clear();
      },
    );
  }

  @override
  Future<ClientModel> getCachedUser() async {
    return await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (box) async {
        final ClientModel user = await box.get('user');
        return user;
      },
    );
  }

  @override
  Future<void> cacheEmail(String email) async {
    await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (box) async {
        final ClientModel user = box.get('user');
        await box.clear();
        await box.put(
          'user',
          user.copyWith(email: email).mapToModel(),
        );
      },
    );
  }

  @override
  Future<void> cacheName(String name) async {
    await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (box) async {
        final ClientModel user = box.get('user');
        await box.clear();
        await box.put(
          'user',
          user.copyWith(name: name).mapToModel(),
        );
      },
    );
  }

  @override
  Future<void> cachePhoneNumber(String phoneNumber) async {
    await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (box) async {
        final ClientModel user = box.get('user');
        await box.clear();
        await box.put(
          'user',
          user.copyWith(phoneNum: phoneNumber),
        );
      },
    );
  }

  @override
  Future<void> cacheImage(String pictureUrl) async {
    await withBox(
      hive: _hive,
      boxName: 'user',
      operation: (box) async {
        ClientModel user = box.get('user');
        await box.clear();
        await box.put(
          'user',
          user.copyWith(pictureUrl: pictureUrl),
        );
      },
    );
  }
}
