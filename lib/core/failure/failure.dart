abstract class Failure {
  final String code;

  Failure(this.code);
}

class OfflineFailure extends Failure {
  OfflineFailure([super.code = 'offline-failure']);
}

class ServerFailure extends Failure {
  ServerFailure([super.code = 'server-failure']);
}

class CacheFailure extends Failure {
  CacheFailure([super.code = 'cache-failure']);
}
