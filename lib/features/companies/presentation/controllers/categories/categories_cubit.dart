import 'package:bloc/bloc.dart';
import 'package:client/core/utils/error_messages.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';
import 'package:client/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUsecase _getCategoriesUsecase;

  CategoriesCubit(this._getCategoriesUsecase) : super(CategoriesInitial());

  List<CategoryEntity> categories = [];
  CategoryEntity? selectedCategory;
  List<CategoryEntity> visibleCategories = [];

  Future<void> getCategories(BuildContext context) async {
    emit(CategoriesLoading());

    final res = await _getCategoriesUsecase();

    res.fold(
      (failure) => emit(CategoriesFaiure(errorMsg(context, failure: failure))),
      (categoriesDb) {
        categories.clear();
        categories = categoriesDb;

        if (categories.isNotEmpty) {
          visibleCategories = categories.take(3).toList();
        }

        emit(CategoriesLoaded(
          categories: categories,
          selectedCategory: selectedCategory,
          visibleCategories: visibleCategories,
        ));
      },
    );
  }

  void selectCategory(CategoryEntity? category) {
    emit(CategoriesLoading());
    selectedCategory = category;

    if (!visibleCategories.any((cat) => cat.name == category?.name)) {
      visibleCategories = [
        selectedCategory!,
        ...visibleCategories.where((cat) => cat.name != category?.name)
      ].take(3).toList();
    }

    emit(CategoriesLoaded(
      categories: categories,
      selectedCategory: selectedCategory!,
      visibleCategories: visibleCategories,
    ));
  }

  void resetSelectedCategory() {
    emit(CategoriesLoading());
    selectedCategory = null;
    emit(CategoriesLoaded(
      categories: categories,
      selectedCategory: selectedCategory,
      visibleCategories: visibleCategories,
    ));
  }
}
