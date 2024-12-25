import 'package:auto_route/auto_route.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.tertiary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Iconsax.arrow_left4,
          color: AppColors.icons,
        ),
      ),
      onPressed: () {
        context.router.maybePop();
      },
    );
  }
}
