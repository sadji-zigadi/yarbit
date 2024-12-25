import 'package:flutter/material.dart';

import '../failure/failure.dart';
import 'language_functions.dart';

String errorMsg(
  BuildContext context, {
  Failure? failure,
  String? code,
}) {
  if (code == null) {
    switch (failure!.code) {
      case 'offline-failure':
        return trans(context).offlineFailure;
      case 'server-failure':
        return trans(context).serverFailure;
      case 'cache-failure':
        return trans(context).cacheFailure;
      case 'user-not-found':
        return trans(context).userNotFound;
      case 'wrong-password':
        return trans(context).wrongPassword;
      case 'email-already-in-use':
        return trans(context).emailAlreadyExists;
      case 'invalid-email':
        return trans(context).invalidEmail;
      case 'user-disabled':
        return trans(context).userDisabled;
      case 'operation-not-allowed':
        return trans(context).operationNotAllowed;
      case 'weak-password':
        return trans(context).weakPassword;
      case 'invalid-credential':
        return trans(context).invalidCredential;
      default:
        return trans(context).defaultFailure;
    }
  } else {
    switch (code) {
      case 'offline-failure':
        return trans(context).offlineFailure;
      case 'server-failure':
        return trans(context).serverFailure;
      case 'cache-failure':
        return trans(context).cacheFailure;
      case 'user-not-found':
        return trans(context).userNotFound;
      case 'wrong-password':
        return trans(context).wrongPassword;
      case 'email-already-in-use':
        return trans(context).emailAlreadyExists;
      case 'invalid-email':
        return trans(context).invalidEmail;
      case 'user-disabled':
        return trans(context).userDisabled;
      case 'operation-not-allowed':
        return trans(context).operationNotAllowed;
      case 'weak-password':
        return trans(context).weakPassword;
      case 'invalid-credential':
        return trans(context).invalidCredential;
      default:
        return trans(context).defaultFailure;
    }
  }
}
