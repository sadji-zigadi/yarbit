import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<String>>> getPictures();
}
