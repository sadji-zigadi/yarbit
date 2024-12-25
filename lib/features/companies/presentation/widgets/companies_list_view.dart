import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/features/companies/presentation/widgets/company_widget.dart';
import 'package:flutter/material.dart';

class CompaniesListView extends StatelessWidget {
  final List<CompanyEntity> companies;
  const CompaniesListView({required this.companies, super.key});

  @override
  Widget build(BuildContext context) {
    final group = AutoSizeGroup();
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: companies.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return CompanyWidget(
            company: companies[index],
            group: group,
          );
        },
      ),
    );
  }
}
