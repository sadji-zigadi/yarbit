import 'package:client/core/shared/controller/search/search_cubit.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/theme/app_text_styles.dart';
import 'package:client/features/companies/presentation/controllers/categories/categories_cubit.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCheckBox extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCheckBox({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        bool isSelected = false;
        if (state is CategoriesLoaded) {
          isSelected = state.selectedCategory == category;
        }

        return GestureDetector(
          onTap: () {
            context.read<CategoriesCubit>().selectCategory(category);
            context.read<SearchCubit>().updateCategory(category);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.20),
                ),
              ),
            ),
            child: ListTile(
              title: Text(
                category.name,
                style: AppTextStyles.custom6,
              ),
              trailing: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.main : Colors.white,
                  border: Border.all(
                    width: 1,
                    color: AppColors.accentBlack.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
