import 'dart:math';
import 'dart:developer' as dev;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/core/shared/controller/search/search_cubit.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/features/companies/presentation/controllers/categories/categories_cubit.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class LogicCategoryCardWidget extends StatefulWidget {
  final IconData? icon;
  final Image? image;
  final CategoryEntity category;
  final AutoSizeGroup group;
  final List<CompanyEntity> companies;

  const LogicCategoryCardWidget({
    super.key,
    this.icon,
    this.image,
    required this.category,
    required this.group,
    required this.companies,
  });

  @override
  State<LogicCategoryCardWidget> createState() =>
      _LogicCategoryCardWidgetState();
}

class _LogicCategoryCardWidgetState extends State<LogicCategoryCardWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        bool isSelected = false;
        if (state is CategoriesLoaded) {
          isSelected = state.selectedCategory == widget.category;
        }

        return GestureDetector(
          onTap: () {
            if (isSelected) {
              context.read<CategoriesCubit>().resetSelectedCategory();
              context.read<SearchCubit>().updateCategory(null);
              context
                  .read<SearchCubit>()
                  .filterCompanies(companies: widget.companies);
            } else {
              context.read<CategoriesCubit>().selectCategory(widget.category);
              context.read<SearchCubit>().updateCategory(widget.category);
              dev.log(context.read<SearchCubit>().category!.name);
              context
                  .read<SearchCubit>()
                  .filterCompanies(companies: widget.companies);
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = min(constraints.maxWidth, constraints.maxHeight);
              return Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.main.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: isSelected
                        ? AppColors.main
                        : Colors.black.withOpacity(0.2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.icon == null ? widget.image! : Icon(widget.icon),
                      AutoSizeText(
                        widget.category.name,
                        group: widget.group,
                        style: AppTextStyles.custom2.copyWith(
                          color: isSelected ? AppColors.main : Colors.black,
                        ),
                        maxLines: 2,
                        minFontSize: 10,
                        textAlign: TextAlign.center,
                        wrapWords: false,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
