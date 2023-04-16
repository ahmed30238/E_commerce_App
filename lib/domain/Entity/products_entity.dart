import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final int id;
  final double price;
  final double old_price;
  final int discount;
  final String name;
  final String image;
  final bool in_favorites;
  final bool in_cart;

  const ProductsEntity(
    this.id,
    this.price,
    this.old_price,
    this.discount,
    this.name,
    this.image,
    this.in_favorites,
    this.in_cart,
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
      in_favorites,
      in_cart,
    ];
  }
}
