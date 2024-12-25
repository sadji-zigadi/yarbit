import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color foregroundColor;
  const LoadingWidget({
    this.backgroundColor = AppColors.main,
    this.foregroundColor = Colors.white,
    super.key,
    this.height = 50,
    this.width = double.maxFinite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
