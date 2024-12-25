import 'package:client/core/shared/widgets/network_image_custom.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PicturesWidget extends StatelessWidget {
  final PageController _controller = PageController();
  final List<String> pictures;
  PicturesWidget({super.key, required this.pictures});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: PageView(
              controller: _controller,
              children: pictures
                  .map((picture) => NetworkImageCustom(url: picture))
                  .toList(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: SmoothPageIndicator(
              controller: _controller,
              count: pictures.length,
              effect: const WormEffect(
                dotHeight: 6,
                dotWidth: 6,
                dotColor: Colors.white,
                activeDotColor: AppColors.main,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
