import 'package:auto_route/auto_route.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/core/shared/widgets/custom_app_bar.dart';
import 'package:client/core/shared/widgets/network_image_custom.dart';
import 'package:client/core/theme/app_text_styles.dart';
import 'package:client/core/utils/language_functions.dart';
import 'package:client/core/utils/snackbar.dart';
import 'package:client/features/orders/presentation/controllers/order/order_cubit.dart';
import 'package:client/features/home/presentation/widgets/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../injection_container.dart' as ic;

@RoutePage()
class CompanyDetailPage extends StatelessWidget implements AutoRouteWrapper {
  final CompanyEntity company;
  const CompanyDetailPage({required this.company, super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OrderCubit>(
      create: (context) => ic.sl<OrderCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      appBar: CustomAppBar(
        text: trans(context).company,
        onPressed: () {
          context.router.maybePop();
        },
        isLeading: true,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPicture(),
        _buildName(context),
        _buildDescription(context),
        _buildServices(context),
        const Spacer(),
        _buildButton(context),
      ],
    );
  }

  Widget _buildPicture() {
    return NetworkImageCustom(
      url: company.bannerUrl,
      height: 28.h,
      width: double.maxFinite,
    );
  }

  Widget _buildName(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF333333).withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company.name,
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 4),
              Text(
                '${company.address['wilaya']}, ${company.address['commune']}',
                style: AppTextStyles.body
                    .copyWith(color: const Color(0xFF292D32).withOpacity(0.65)),
              ),
            ],
          ),
          _buildRate(context),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trans(context).description,
            style: AppTextStyles.custom3,
          ),
          const SizedBox(height: 8),
          Text(
            company.description,
            style: AppTextStyles.custom4,
          ),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trans(context).services,
            style: AppTextStyles.custom3,
          ),
          const SizedBox(height: 8),
          ...List.generate(
            company.services.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: Text(
                company.services[index],
                style: AppTextStyles.custom4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRate(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Color(0xFFFFD250),
        ),
        const SizedBox(width: 4),
        Text(
          company.rating == -1
              ? trans(context).newMessage
              : company.rating.toStringAsFixed(2),
          style: AppTextStyles.custom5,
        )
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) async {
          if (state is OrderSuccess) {
            showSnackBar(
              context,
              message: trans(context).orderPlacedSuccessfully,
            );

            context.router.maybePop();

            final url = Uri.parse('tel:${company.phoneNum}');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          } else if (state is OrderFailure) {
            showSnackBar(
              context,
              message: state.message,
            );
          }
        },
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (newContext) => BottomMenuWidget(
                title: trans(newContext).confirm,
                content: trans(newContext).confirmOrderText,
                buttonText: trans(context).call,
                height: 50.h,
                onPressed: () {
                  context.read<OrderCubit>().createOrder(
                        context,
                        companyId: company.id,
                        companyServices: company.services,
                        companyName: company.name,
                        companyPhoneNumber: company.phoneNum,
                        companyLogoUrl: company.logoUrl,
                      );
                },
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
            );
          },
          child: Text(trans(context).call),
        ),
      ),
    );
  }
}
