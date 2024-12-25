import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';

import '../../utils/model_structure.dart';

class CompanyModel extends CompanyEntity with ModelStructure<CompanyEntity> {
  const CompanyModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNum,
    required super.address,
    required super.services,
    required super.category,
    required super.description,
    required super.rating,
    required super.bannerUrl,
    required super.logoUrl,
  });

  factory CompanyModel.fromMap({
    required Map<String, dynamic> map,
    required CategoryEntity category,
    required double rating,
  }) {
    return CompanyModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNum: map['phone number'],
      services: map['services'],
      address: map['address'],
      category: category,
      description: map['description'],
      rating: rating,
      bannerUrl: map['banner url'],
      logoUrl: map['logo url'],
    );
  }

  @override
  CompanyEntity mapToEntity() {
    return CompanyEntity(
      id: id,
      name: name,
      email: email,
      phoneNum: phoneNum,
      address: address,
      services: services,
      category: category,
      description: description,
      rating: rating,
      bannerUrl: bannerUrl,
      logoUrl: logoUrl,
    );
  }
}
