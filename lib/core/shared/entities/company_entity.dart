import 'package:client/core/shared/models/company_model.dart';
import 'package:client/core/utils/entity_structure.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';

import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable
    with EntityStructure<CompanyEntity, CompanyModel> {
  final String id;
  final String name;
  final String email;
  final String phoneNum;
  final Map<String, dynamic> address;
  final List<dynamic> services;
  final CategoryEntity category;
  final String description;
  final double rating;
  final String bannerUrl;
  final String logoUrl;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.address,
    required this.services,
    required this.category,
    required this.description,
    required this.rating,
    required this.bannerUrl,
    required this.logoUrl,
  });

  @override
  CompanyEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNum,
    String? bannerUrl,
    String? logoUrl,
    Map<String, dynamic>? address,
    List<dynamic>? services,
    CategoryEntity? category,
    String? description,
    double? rating,
  }) {
    return CompanyEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNum: phoneNum ?? this.phoneNum,
      address: address ?? this.address,
      services: services ?? this.services,
      category: category ?? this.category,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  @override
  CompanyModel mapToModel() {
    return CompanyModel(
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

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNum,
        address,
        category,
        description,
        bannerUrl,
        logoUrl,
      ];
}
