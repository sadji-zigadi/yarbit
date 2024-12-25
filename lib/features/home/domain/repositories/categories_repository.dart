import '../../../../core/failure/failure.dart';
import '../entities/category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
