import 'package:auto_route/auto_route.dart';
import 'package:client/core/routes/app_router.dart';

import '../../../../core/shared/entities/company_entity.dart';
import '../../../../core/shared/widgets/network_image_custom.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CompanyCard extends StatelessWidget {
  final CompanyEntity company;
  const CompanyCard({required this.company, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(CompanyDetailRoute(company: company));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImg(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildImg() {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
          child: NetworkImageCustom(
            url: company.logoUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          company.name,
          style: AppTextStyles.bodyHeavy,
        ),
        Text(
          company.category.name,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentBlack),
        ),
      ],
    );
  }
}
