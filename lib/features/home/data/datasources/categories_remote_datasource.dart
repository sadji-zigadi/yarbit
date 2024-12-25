import '../models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CategoriesRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
}

class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource {
  final FirebaseFirestore _firestore;

  CategoriesRemoteDatasourceImpl(this._firestore);
  @override
  Future<List<CategoryModel>> getCategories() async {
    return await _firestore.collection('categories').get().then((value) =>
        value.docs.map((e) => CategoryModel.fromMap(map: e.data())).toList());
  }
}
