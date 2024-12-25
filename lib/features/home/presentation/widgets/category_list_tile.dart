import '../../../../core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryListTile extends StatelessWidget {
  final Icon prefixIcon;
  final String title;
  const CategoryListTile({
    super.key,
    required this.prefixIcon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: AppTextStyles.body,
      ),
      leading: prefixIcon,
      trailing: const Icon(Iconsax.arrow_up_2),
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
    );
  }
}
