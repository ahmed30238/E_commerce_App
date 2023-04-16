import 'package:e_commerce_app/domain/Entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.status,
    required super.categoryData, // object
  });

  factory CategoryModel.fromjson(Map<String, dynamic> json) => CategoryModel(
        status: json['status'],
        categoryData: CategoryDataModel.fromjson(json['data']),
      );
}

class CategoryDataModel extends CategoryData {
  const CategoryDataModel({required super.categoryObject});
  factory CategoryDataModel.fromjson(Map<String, dynamic> json) =>
      CategoryDataModel(
        categoryObject: List<CategoryObjectModel>.from(
          (json['data'] as List).map(
            (e) => CategoryObjectModel.fromjson(e),
          ),
        ),
      );
}

class CategoryObjectModel extends CategoryObject {
  const CategoryObjectModel(
    super.id,
    super.name,
    super.image,
  );

  factory CategoryObjectModel.fromjson(Map<String, dynamic> json) =>
      CategoryObjectModel(
        json['id'],
        json['name'],
        json['image'],
      );
}
