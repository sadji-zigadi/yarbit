import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/core/shared/controller/search/search_cubit.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/core/theme/app_text_styles.dart';
import 'package:client/core/utils/category_icon_function.dart';
import 'package:client/core/utils/language_functions.dart';
import 'package:client/features/companies/presentation/controllers/categories/categories_cubit.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';
import 'package:client/features/companies/presentation/controllers/companies/companies_cubit.dart';
import 'package:client/features/companies/presentation/widgets/category_check_box.dart';
import 'package:client/features/companies/presentation/widgets/logic_category_card_widget.dart';
import 'package:client/features/home/presentation/widgets/plain_category_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

class CategoriesWidget extends StatefulWidget {
  final List<CategoryEntity> selectedCategories;
  final List<CategoryEntity> categories;
  final List<CompanyEntity> companies;

  const CategoriesWidget({
    required this.selectedCategories,
    required this.companies,
    required this.categories,
    super.key,
  });

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    final group = AutoSizeGroup();

    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...widget.selectedCategories.map(
            (category) => LogicCategoryCardWidget(
              image: getCategoryIcon(
                category: category,
                size: 27,
              ),
              category: category,
              group: group,
              companies: widget.companies,
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (newContext) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<CategoriesCubit>(),
                    ),
                    BlocProvider.value(
                      value: context.read<SearchCubit>(),
                    ),
                    BlocProvider.value(
                      value: context.read<CompaniesCubit>(),
                    ),
                  ],
                  child: _buildModalSheetMenu(newContext, context),
                ),
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
              );
            },
            child: PlainCategoryCardWidget(
              icon: Iconsax.add,
              title: trans(context).more,
              group: AutoSizeGroup(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModalSheetMenu(BuildContext newContext, BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 26, left: 16),
            child: Text(
              trans(newContext).categories,
              style: AppTextStyles.custom0,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            itemCount: widget.categories.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CategoryCheckBox(
                category: widget.categories[index],
              );
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<SearchCubit>()
                    .filterCompanies(companies: widget.companies);
                newContext.router.maybePop();
              },
              child: Text(trans(newContext).apply),
            ),
          ),
        ],
      ),
    );
  }
}
