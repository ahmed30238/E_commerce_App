import 'package:equatable/equatable.dart';

class GetFavouritesEntity extends Equatable {
  final bool status;
  final FavouriteData? favouriteData;
  const GetFavouritesEntity({
    required this.status,
    required this.favouriteData,
  });

  @override
  List<Object> get props => [status, favouriteData!];
}

class FavouriteData extends Equatable {
  final List<FavouriteItemData>? favouriteItemData;
  const FavouriteData({
    required this.favouriteItemData,
  });

  @override
  List<Object> get props => [FavouriteItemData];
}

class FavouriteItemData extends Equatable {
  final int id;
  final FavouriteProduct favouriteProduct;

  const FavouriteItemData(this.id, this.favouriteProduct);

  @override
  List<Object> get props => [id, favouriteProduct];
}

class FavouriteProduct extends Equatable {
  final int id;
  final double price;
  final double old_price;
  final int discount;
  final String name;
  final String image;
  final String description;

  const FavouriteProduct(
    this.id,
    this.price,
    this.old_price,
    this.discount,
    this.name,
    this.image,
    this.description,
  );

  @override
  List<Object> get props {
    return [
      id,
      price,
      old_price,
      discount,
      name,
      image,
      description,
    ];
  }
}
