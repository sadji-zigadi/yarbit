import '../../../../core/failure/failure.dart';
import '../../../../core/utils/network_info.dart';
import '../datasources/categories_remote_datasource.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final NetworkInfo _networkInfo;
  final CategoriesRemoteDatasource _remote;

  CategoriesRepositoryImpl(this._networkInfo, this._remote);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    if (await _networkInfo.isConnected) {
      try {
        final categories = await _remote.getCategories();

        return Right(categories);
      } on FirebaseException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
