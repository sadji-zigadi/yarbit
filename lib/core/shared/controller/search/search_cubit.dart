import 'package:bloc/bloc.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/core/utils/string_extensions.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  String searchQuery = '';
  String wilaya = '';
  String commune = '';
  CategoryEntity? category;

  SearchCubit() : super(SearchInitial());

  void reset({required List<dynamic> items}) {
    emit(SearchLoading());

    emit(SearchReset(items));
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  void updateWilaya(String wilaya) {
    this.wilaya = wilaya;
  }

  void updateCommune(String commune) {
    this.commune = commune;
  }

  void updateCategory(CategoryEntity? category) {
    this.category = category;
  }

  void filterCompanies({required List<CompanyEntity> companies}) {
    emit(SearchLoading());

    List<CompanyEntity> newList = companies;

    // Apply name filter
    if (searchQuery.isNotEmpty) {
      newList = newList
          .where(
              (c) => c.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Apply category filter
    if (category != null) {
      newList =
          newList.where((c) => c.category.name == category!.name).toList();
    }

    // Apply address filter
    if (wilaya.isNotEmpty) {
      newList = newList.where((c) {
        if (commune.isNotEmpty) {
          return c.address['wilaya'] == wilaya.serialize() &&
              c.address['commune'] == commune;
        } else {
          return c.address['wilaya'] == wilaya.serialize();
        }
      }).toList();
    }

    companies = newList;
    emit(SearchSuccess(newList));
  }
}
