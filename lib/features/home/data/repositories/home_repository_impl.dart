import '../../../../core/failure/failure.dart';
import '../../../../core/utils/network_info.dart';
import '../datasources/home_remote_datasource.dart';
import '../../domain/repositories/home_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _remote;
  final NetworkInfo _networkInfo;

  HomeRepositoryImpl(this._networkInfo, this._remote);

  @override
  Future<Either<Failure, List<String>>> getPictures() async {
    if (await _networkInfo.isConnected) {
      try {
        final List<String> pictures = await _remote.getPictures();

        return Right(pictures);
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
