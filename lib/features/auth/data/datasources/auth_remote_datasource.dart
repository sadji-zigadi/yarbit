import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/utils/string_extensions.dart';

import '../models/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDatasource {
  Future<ClientModel> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<ClientModel> logIn({
    required String email,
    required String password,
  });
  Future<void> setDetails({
    required String wilaya,
    required String commune,
    required String phoneNum,
  });
  Future<void> forgetPassword({required String email});
  Future<void> signOut();
  Future<void> editName(String name);
  Future<void> editPhoneNumber(String phoneNumber);
  Future<void> editEmail(String email);
  Future<void> editPassword(String password);
  Future<String> editImage(File image);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  AuthRemoteDatasourceImpl(
    this._auth,
    this._firestore,
    this._storage,
  );

  @override
  Future<ClientModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credentials.user!.updateDisplayName(name);
    final user = ClientModel(
      id: credentials.user!.uid,
      email: email,
      name: name,
    );
    await _firestore.collection('clients').doc(user.id).set(user.toMap());

    return user;
  }

  @override
  Future<ClientModel> logIn({
    required String email,
    required String password,
  }) async {
    final credentials = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userId = credentials.user!.uid;
    final res = await _firestore.collection('clients').doc(userId).get();

    return ClientModel.fromMap(map: res.data()!);
  }

  @override
  Future<void> setDetails({
    required String wilaya,
    required String commune,
    required String phoneNum,
  }) async {
    final userId = _auth.currentUser?.uid;
    await _firestore.collection('clients').doc(userId).update(
      {
        'address': {
          'wilaya': wilaya.serialize(),
          'commune': commune,
        },
        'phone number': phoneNum,
      },
    );
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> editEmail(String email) async {
    final user = _auth.currentUser;

    await user?.verifyBeforeUpdateEmail(email);
  }

  @override
  Future<void> editName(String name) async {
    final user = _auth.currentUser;
    await _firestore
        .collection('clients')
        .doc(user?.uid)
        .update({'name': name});
    await user?.updateDisplayName(name);
  }

  @override
  Future<void> editPassword(String password) async {
    final user = _auth.currentUser;
    await user?.updatePassword(password);
  }

  @override
  Future<void> editPhoneNumber(String phonenum) async {
    final user = _auth.currentUser;
    await _firestore
        .collection('clients')
        .doc(user?.uid)
        .update({'phone number': phonenum});
  }

  @override
  Future<String> editImage(File image) async {
    final user = _auth.currentUser;
    final ref = _storage.ref().child('profile_images/${user?.uid}');
    await ref.putFile(image);
    final url = await ref.getDownloadURL();

    await user?.updatePhotoURL(url);

    await _firestore
        .collection('clients')
        .doc(user?.uid)
        .update({'picture url': url});

    return url;
  }
}
