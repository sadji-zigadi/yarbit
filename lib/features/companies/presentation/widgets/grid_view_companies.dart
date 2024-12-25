import 'package:client/core/shared/entities/company_entity.dart';

import 'company_card.dart';
import 'package:flutter/material.dart';

class GridViewCompanies extends StatelessWidget {
  final List<CompanyEntity> companies;
  const GridViewCompanies({
    required this.companies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: companies.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 200,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => CompanyCard(company: companies[index]),
    );
  }
}
