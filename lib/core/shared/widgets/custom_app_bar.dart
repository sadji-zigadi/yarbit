import 'package:client/core/theme/app_colors.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final String text;
  final List<Widget>? customActions;
  final VoidCallback? onPressed;
  final bool isLeading;
  CustomAppBar({
    required this.text,
    this.customActions,
    this.onPressed,
    this.isLeading = false,
    super.key,
  }) : super(
          title: Text(text),
          actions: customActions,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.custom1.withOpacity(0.18),
              height: 1.0,
            ),
          ),
          leading: isLeading
              ? IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Iconsax.arrow_left_2,
                    color: Colors.black,
                  ),
                )
              : null,
        );
}
