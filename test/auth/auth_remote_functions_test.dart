// ignore_for_file: subtype_of_sealed_class

import 'dart:io';

import 'package:client/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:client/features/auth/data/models/client_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocking.dart';

void main() {
  late MockFirebaseAuth auth;
  late MockFirebaseFirestore firestore;
  late MockFirebaseStorage storage;
  late AuthRemoteDatasourceImpl remote;

  setUp(() {
    auth = MockFirebaseAuth();
    firestore = MockFirebaseFirestore();
    storage = MockFirebaseStorage();
    remote = AuthRemoteDatasourceImpl(
      auth,
      firestore,
      storage,
    );
  });

  test(
    'Given name, email and password, When signUp is called, Then a user model should be returned',
    () async {
      // Arrange
      const String uid = 'uid';
      const String name = 'name';
      const String email = 'email';
      const String password = 'password';
      final userCredentials = MockUserCredential();
      final user = MockUser();
      final docRef = MockDocumentReference();
      final collectRef = MockCollectionReference();

      when(
        () => auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => userCredentials);

      when(() => userCredentials.user).thenReturn(user);
      when(() => user.updateDisplayName(name)).thenAnswer((_) async {});
      when(() => user.uid).thenReturn(uid);
      when(() => firestore.collection('clients')).thenAnswer(
        (_) => collectRef,
      );
      when(() => collectRef.doc(uid)).thenReturn(docRef);
      when(() => docRef.set(any())).thenAnswer((_) async {});

      // Act
      final result = await remote.signUp(
        name: name,
        email: email,
        password: password,
      );

      // Assert
      expect(result, isA<ClientModel>());
    },
  );

  test(
    'Given email and password, When logIn is called, Then a user model should be returned',
    () async {
      // Arrange
      const String uid = 'uid';
      const String email = 'email';
      const String name = 'name';
      const Map<String, dynamic> address = {
        'wilaya': 'wilaya',
        'commune': 'commune',
      };
      const String password = 'password';
      final userCredentials = MockUserCredential();
      final user = MockUser();
      final collectRef = MockCollectionReference();
      final docRef = MockDocumentReference();
      final docSnap = MockDocumentSnapshot();

      when(() => auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) async => userCredentials);
      when(() => userCredentials.user).thenReturn(user);
      when(() => user.uid).thenReturn(uid);
      when(() => firestore.collection('clients')).thenAnswer((_) => collectRef);
      when(() => collectRef.doc(uid)).thenAnswer((_) => docRef);
      when(() => docRef.get()).thenAnswer((_) async => docSnap);
      when(() => docSnap.data()).thenReturn({
        'id': uid,
        'email': email,
        'name': name,
        'address': address,
        'picture url': 'picture url',
      });

      // Act
      final result = await remote.logIn(
        email: email,
        password: password,
      );

      // Assert
      expect(result, isA<ClientModel>());
    },
  );
  test(
    'Given wilaya, commune and phone number, When setDetails is called, Then no return value',
    () async {
      // Arrange
      const String uid = 'uid';
      const String wilaya = 'wilaya';
      const String commune = 'commune';
      const String phoneNum = 'phoneNum';
      final user = MockUser();
      final collectRef = MockCollectionReference();
      final docRef = MockDocumentReference();

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.uid).thenReturn(uid);
      when(() => firestore.collection('clients')).thenAnswer((_) => collectRef);
      when(() => collectRef.doc(uid)).thenReturn(docRef);
      when(() => docRef.update(any())).thenAnswer((_) async {});

      // Act
      await remote.setDetails(
        wilaya: wilaya,
        commune: commune,
        phoneNum: phoneNum,
      );

      // Assert
      verify(() => docRef.update({
            'address': {
              'wilaya': wilaya,
              'commune': commune,
            },
            'phone number': phoneNum,
          })).called(1);
    },
  );

  test(
    'Given email, When forgetPassword is called, Then no return value',
    () async {
      // Arrange
      const String email = 'email';

      when(() => auth.sendPasswordResetEmail(email: email))
          .thenAnswer((_) async {});

      // Act
      await remote.forgetPassword(email: email);

      // Assert
      verify(() => auth.sendPasswordResetEmail(email: email));
    },
  );

  test(
    'Given no value, When signOut is invoked, Then no return value',
    () async {
      // Arrange
      when(() => auth.signOut()).thenAnswer((_) async {});

      // Act
      await remote.signOut();

      // Assert
      verify(() => auth.signOut());
    },
  );

  test(
    'Given a name, When editName is invoked, Then no value is returned',
    () async {
      // Arrange
      const String name = 'name';
      final user = MockUser();
      final docRef = MockDocumentReference();
      final colRef = MockCollectionReference();

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.uid).thenReturn('uid');
      when(() => firestore.collection('clients')).thenAnswer((_) => colRef);
      when(() => colRef.doc('uid')).thenAnswer((_) => docRef);
      when(() => docRef.update({'name': name})).thenAnswer((_) async {});
      when(() => user.updateDisplayName(name)).thenAnswer((_) async {});

      // Act
      await remote.editName(name);

      // Assert
      verify(() => docRef.update({'name': name})).called(1);
      verify(() => user.updateDisplayName(name)).called(1);
    },
  );

  test(
    'Given a password, When editPassword is invoked, Then no value is returned',
    () async {
      // Arrange
      final user = MockUser();

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.updatePassword('password')).thenAnswer((_) async {});

      // Act
      await remote.editPassword('password');

      // Assert
      verify(() => user.updatePassword('password')).called(1);
    },
  );

  test(
    'Given a phone number, When editPhoneNumber is invoked, Then no value is returned',
    () async {
      // Arrange
      final user = MockUser();
      final docRef = MockDocumentReference();
      final colRef = MockCollectionReference();

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.uid).thenReturn('uid');
      when(() => firestore.collection('clients')).thenAnswer((_) => colRef);
      when(() => colRef.doc('uid')).thenAnswer((_) => docRef);
      when(() => docRef.update({'phone number': 'phone number'}))
          .thenAnswer((_) async {});

      // Act
      await remote.editPhoneNumber('phone number');

      // Assert
      verify(() => docRef.update({'phone number': 'phone number'})).called(1);
    },
  );

  test(
    'Given an image, When editImage is invoked, Then a picture url is returned',
    () async {
      // Arrange
      final image = File('');
      final user = MockUser();
      final ref = MockReference();
      final uploadTask = MockUploadTask();
      final colRef = MockCollectionReference();
      final docRef = MockDocumentReference();

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.uid).thenReturn('client_id');
      when(() => storage.ref()).thenReturn(ref);
      when(() => ref.child('profile_images/client_id')).thenReturn(ref);
      when(() => ref.putFile(image)).thenAnswer((_) => uploadTask);
      when(() => ref.getDownloadURL()).thenAnswer((_) async => 'url');
      when(() => user.updatePhotoURL('url')).thenAnswer((_) async {});
      when(() => firestore.collection('clients')).thenAnswer((_) => colRef);
      when(() => colRef.doc('client_id')).thenAnswer((_) => docRef);
      when(() => docRef.update({'picture url': 'picture url'}))
          .thenAnswer((_) async {});

      // Act
      final pictureUrl = await remote.editImage(image);

      // Assert
      expect(pictureUrl, isA<String>());
    },
  );
}
