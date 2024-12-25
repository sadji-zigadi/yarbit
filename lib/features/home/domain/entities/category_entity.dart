import '../../../../core/utils/entity_structure.dart';
import '../../data/models/category_model.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable
    with EntityStructure<CategoryEntity, CategoryModel> {
  final String id;
  final String name;

  const CategoryEntity({
    required this.id,
    required this.name,
  });

  @override
  CategoryEntity copyWith({
    String? id,
    String? name,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  CategoryModel mapToModel() {
    return CategoryModel(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
