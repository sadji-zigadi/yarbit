import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/core/routes/app_router.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CompanyWidget extends StatelessWidget {
  final CompanyEntity company;
  final AutoSizeGroup group;
  const CompanyWidget({required this.company, required this.group, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(CompanyDetailRoute(company: company));
      },
      child: SizedBox(
        width: 80,
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: company.logoUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: AutoSizeText(
                company.name,
                style: AppTextStyles.bodySmall,
                maxLines: 2,
                group: group,
                overflow: TextOverflow.ellipsis,
                minFontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
