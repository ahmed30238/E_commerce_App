import 'package:e_commerce_app/domain/Entity/search_entity.dart';

class SearchModel extends SearchEntity {
  const SearchModel(super.status, super.data);
  factory SearchModel.fromjson(Map<String, dynamic> json) => SearchModel(
        json['status'],
        SearchDataModel.fromjson(json['data']),
      );
}

class SearchDataModel extends SearchData {
  const SearchDataModel(super.current_page, super.dataObject);

  factory SearchDataModel.fromjson(Map<String, dynamic> json) =>
      SearchDataModel(
        json['current_page'],
        List<SearchDataObjectModel>.from(
          (json['data'] as List).map(
            (e) => SearchDataObjectModel.fromjson(e),
          ),
        ),
      );
}

class SearchDataObjectModel extends SearchDataObject {
  const SearchDataObjectModel(
    super.id,
    super.price,
    super.image,
    super.name,
    super.description,
    super.images,
    super.in_favorites,
    super.in_cart,
  );
  factory SearchDataObjectModel.fromjson(Map<String, dynamic> json) =>
      SearchDataObjectModel(
        json['id'],
        json['price'].toInt(),
        json['image'],
        json['name'],
        json['description'],
        List<String>.from((json['images']as List).map((e) => e)),
        json['in_favorites'],
        json['in_cart'],
      );
}
