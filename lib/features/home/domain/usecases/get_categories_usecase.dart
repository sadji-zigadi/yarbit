import '../../../../core/failure/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesUsecase {
  final CategoriesRepository _repository;

  const GetCategoriesUsecase(this._repository);

  Future<Either<Failure, List<CategoryEntity>>> call() async =>
      await _repository.getCategories();
}
