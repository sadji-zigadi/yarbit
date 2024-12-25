import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/core/theme/app_text_styles.dart';
import 'package:client/core/utils/language_functions.dart';
import 'package:client/features/home/presentation/widgets/bottom_menu_widget.dart';
import 'package:client/features/orders/domain/entities/order_entity.dart';
import 'package:client/features/orders/presentation/controllers/orders/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderListTileWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderListTileWidget({
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEBEFF3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          _buildPicture(),
          const SizedBox(width: 15),
          _buildName(),
          const SizedBox(width: 15),
          _buildBtns(context),
        ],
      ),
    );
  }

  Widget _buildPicture() {
    return CachedNetworkImage(
      imageUrl: order.companyPictureUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.companyName,
            style: AppTextStyles.custom3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            order.companyServices[0],
            style: AppTextStyles.custom4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _buildBtns(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(0.0),
          width: 20,
          height: 20,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (newContext) => BottomMenuWidget(
                  title: trans(newContext).confirmDeleteOrder,
                  content: trans(newContext).confirmDeleteOrderText,
                  buttonText: trans(context).confirm,
                  onPressed: () {
                    context.read<OrdersCubit>().removeOrder(order: order);
                    context.router.maybePop();
                  },
                  height: 50.h,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
              );
            },
            icon: const Icon(
              Iconsax.trash,
              size: 18,
              color: Color(0xFF292D32),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          width: 75,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (newContext) => BottomMenuWidget(
                  title: trans(newContext).confirmCall,
                  content: trans(newContext).confirmCallText,
                  buttonText: trans(context).call,
                  onPressed: () async {
                    final url = Uri.parse('tel:${order.companyPhoneNumber}');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                    context.router.maybePop();
                  },
                  height: 50.h,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.call,
                  size: 12,
                ),
                const SizedBox(width: 8),
                Text(
                  trans(context).call.toLowerCase(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
