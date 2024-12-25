import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class PlainCategoryCardWidget extends StatelessWidget {
  final IconData? icon;
  final Image? image;
  final String title;
  final AutoSizeGroup group;
  const PlainCategoryCardWidget({
    this.icon,
    this.image,
    required this.title,
    required this.group,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight);
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.2),
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
                icon == null ? image! : Icon(icon),
                AutoSizeText(
                  title,
                  group: group,
                  style: AppTextStyles.custom2.copyWith(color: Colors.black),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  minFontSize: 10,
                  wrapWords: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
