part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final List<CategoryEntity> visibleCategories;

  const CategoriesLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.visibleCategories,
  });

  @override
  List<Object> get props => [
        categories,
        visibleCategories,
      ];
}

final class CategoriesFaiure extends CategoriesState {
  final String message;

  const CategoriesFaiure(this.message);

  @override
  List<Object> get props => [message];
}
