import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final bool status;
  final CategoryData categoryData;
  const CategoryEntity({
    required this.status,
    required this.categoryData,
  });

  @override
  List<Object> get props => [status, categoryData];
}

class CategoryData extends Equatable {
  final List<CategoryObject> categoryObject;
  const CategoryData({
    required this.categoryObject,
  });

  @override
  List<Object> get props => [categoryObject];
}

class CategoryObject extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryObject(this.id, this.name, this.image);

  @override
  List<Object> get props => [
        id,
        name,
        image,
      ];
}
