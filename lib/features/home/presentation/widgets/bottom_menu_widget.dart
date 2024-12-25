import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomMenuWidget extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback onPressed;
  final double height;
  const BottomMenuWidget({
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onPressed,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 100.w,
      padding: const EdgeInsets.symmetric(
        vertical: 65,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              AutoSizeText(
                title,
                style: AppTextStyles.h3,
                maxLines: 1,
              ),
              const SizedBox(height: 32),
              Text(
                content,
                style: AppTextStyles.custom4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
