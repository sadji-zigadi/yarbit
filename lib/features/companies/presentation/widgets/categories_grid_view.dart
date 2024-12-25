import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/core/shared/pages/app_page.dart';
import 'package:client/core/utils/category_icon_function.dart';
import 'package:client/core/utils/language_functions.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';
import 'package:client/features/home/presentation/widgets/plain_category_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoriesGridView extends StatelessWidget {
  final List<CategoryEntity> categories;
  final Function(CategoryEntity category)? onCategorySelected;

  const CategoriesGridView({
    required this.categories,
    this.onCategorySelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final group = AutoSizeGroup();
    return GridView.builder(
      itemCount: min(8, categories.length) + 1,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 16,
        mainAxisExtent: 80,
      ),
      itemBuilder: (BuildContext context, int index) =>
          index != min(8, categories.length)
              ? GestureDetector(
                  onTap: () => onCategorySelected?.call(categories[index]),
                  child: PlainCategoryCardWidget(
                    image: getCategoryIcon(
                      category: categories[index],
                      size: 27,
                    ),
                    title: categories[index].name,
                    group: group,
                  ),
                )
              : GestureDetector(
                  onTap: () => tabsRouter.setActiveIndex(1),
                  child: PlainCategoryCardWidget(
                    icon: Iconsax.add,
                    title: trans(context).more,
                    group: group,
                  ),
                ),
    );
  }
}
