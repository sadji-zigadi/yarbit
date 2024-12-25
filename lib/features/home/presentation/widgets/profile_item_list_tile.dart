import '../../../../core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileItemListTile extends StatelessWidget {
  final Icon prefixIcon;
  final String title;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onPressed;
  const ProfileItemListTile({
    super.key,
    required this.prefixIcon,
    required this.title,
    this.isFirst = false,
    this.isLast = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: isFirst
              ? const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                )
              : isLast
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    )
                  : null,
          border: Border(
            top: const BorderSide(
              color: AppColors.tertiary,
              width: 1,
            ),
            right: const BorderSide(
              color: AppColors.tertiary,
              width: 1,
            ),
            left: const BorderSide(
              color: AppColors.tertiary,
              width: 1,
            ),
            bottom: isLast
                ? const BorderSide(color: AppColors.tertiary, width: 1)
                : BorderSide.none,
          ),
        ),
        child: ListTile(
          leading: prefixIcon,
          title: Text(
            title,
            style: AppTextStyles.body,
          ),
          trailing: Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(0.0),
            child: const Icon(
              Iconsax.arrow_right_3,
              color: Color(0xFF9BA5B7),
            ),
          ),
        ),
      ),
    );
  }
}
