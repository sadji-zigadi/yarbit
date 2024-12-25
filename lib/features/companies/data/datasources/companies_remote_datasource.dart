import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/core/shared/models/company_model.dart';
import 'package:client/features/home/data/models/category_model.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CompaniesRemoteDatasource {
  Future<List<CompanyEntity>> getCompanies();
  Future<List<CompanyEntity>> getPromotedCompanies();
}

class CompaniesRemoteDatasourceImpl implements CompaniesRemoteDatasource {
  final FirebaseFirestore _firestore;

  CompaniesRemoteDatasourceImpl(this._firestore);

  @override
  Future<List<CompanyEntity>> getCompanies() async {
    final companies = <CompanyEntity>[];
    final docs = await _firestore
        .collection('companies')
        .get()
        .then((value) => value.docs);

    for (final doc in docs) {
      final data = doc.data();
      final company = CompanyModel.fromMap(
        map: data,
        category: await _getCategory(categoryId: data['category id']),
        rating: await _calculateRating(companyId: doc.id),
      );

      companies.add(company);
    }

    return companies;
  }

  @override
  Future<List<CompanyEntity>> getPromotedCompanies() async {
    final companies = <CompanyEntity>[];
    final docs =
        await _firestore.collection('promotes').get().then((a) => a.docs);

    for (final b in docs) {
      final data = await _firestore
          .collection('companies')
          .doc(b.data()['company id'])
          .get()
          .then((c) => c.data());
      final company = CompanyModel.fromMap(
        map: data!,
        category: await _getCategory(categoryId: data['category id']),
        rating: await _calculateRating(companyId: data['id']),
      );

      companies.add(company);
    }

    return companies;
  }

  // Handy functions
  Future<CategoryEntity> _getCategory({required String categoryId}) async {
    final data = await _firestore
        .collection('categories')
        .doc(categoryId)
        .get()
        .then((e) => e.data());
    final category = CategoryModel.fromMap(map: data!).mapToEntity();
    return category;
  }

  Future<double> _calculateRating({required String companyId}) async {
    List<double> ratings = [];
    final res = await _firestore
        .collection('ratings')
        .where(
          'company id',
          isEqualTo: companyId,
        )
        .get()
        .then((value) => value.docs);

    if (res.isNotEmpty) {
      for (final doc in res) {
        final double rating = double.parse(doc.data()['rating'].toString());
        ratings.add(rating);
      }

      double sum = 0;

      for (final rating in ratings) {
        sum += rating;
      }

      return sum / ratings.length;
    } else {
      return -1;
    }
  }
}
