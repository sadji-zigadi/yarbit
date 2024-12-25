import 'package:cached_network_image/cached_network_image.dart';
import '../../../../features/auth/presentation/widgets/loading_widget.dart';
import '../../../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NetworkImageCustom extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final Color loadingForeground;
  final Color loadingBackground;
  final Widget? errorWidget;
  final bool isLoading;
  final double? height;
  final double? width;
  const NetworkImageCustom({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.loadingForeground = AppColors.main,
    this.loadingBackground = Colors.white,
    this.errorWidget,
    this.isLoading = true,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return url == null
        ? errorWidget ?? const Center(child: Icon(Icons.error))
        : CachedNetworkImage(
            imageUrl: url!,
            width: width,
            height: height,
            fit: fit,
            errorWidget: (context, url, error) {
              return errorWidget ?? const Center(child: Icon(Icons.error));
            },
            placeholder: isLoading
                ? (context, url) {
                    return LoadingWidget(
                      foregroundColor: loadingForeground,
                      backgroundColor: loadingBackground,
                      height: double.maxFinite,
                      width: double.maxFinite,
                    );
                  }
                : null,
          );
  }
}
