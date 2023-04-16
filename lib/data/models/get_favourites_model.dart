import 'package:e_commerce_app/domain/Entity/get_favourites_entity.dart';

class GetFavouritesModel extends GetFavouritesEntity {
  const GetFavouritesModel({
    required super.status,
    required super.favouriteData,
  });

  factory GetFavouritesModel.fromjson(Map<String, dynamic> json) =>
      GetFavouritesModel(
        status: json['status'],
        favouriteData: FavouriteDataModel.fromjson(json['data']),
      );
}

class FavouriteDataModel extends FavouriteData {
  const FavouriteDataModel({
    required super.favouriteItemData,
  });

  factory FavouriteDataModel.fromjson(Map<String, dynamic> json) =>
      FavouriteDataModel(
        favouriteItemData: List<FavouriteItemDataModel>.from(
            (json['data'] as List)
                .map((e) => FavouriteItemDataModel.fromjson(e))),
      );
}

class FavouriteItemDataModel extends FavouriteItemData {
  const FavouriteItemDataModel(super.id, super.favouriteProduct);

  factory FavouriteItemDataModel.fromjson(Map<String, dynamic> json) =>
      FavouriteItemDataModel(
        json['id'],
        FavouriteProductModel.fromjson(json['product']),
      );
}

class FavouriteProductModel extends FavouriteProduct {
  const FavouriteProductModel(
    super.id,
    super.price,
    super.old_price,
    super.discount,
    super.name,
    super.image,
    super.description,
  );

  factory FavouriteProductModel.fromjson(Map<String, dynamic> json) =>
      FavouriteProductModel(
        json['id'],
        json['price'].toDouble(),
        json['old_price'].toDouble(),
        json['discount'],
        json['name'],
        json['image'],
        json['description'],
      );
}
