import '../../../../core/utils/model_structure.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity with ModelStructure<CategoryEntity> {
  const CategoryModel({
    required super.id,
    required super.name,
  });

  factory CategoryModel.fromMap({required Map<String, dynamic> map}) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  CategoryEntity mapToEntity() {
    return CategoryEntity(
      id: id,
      name: name,
    );
  }
}
