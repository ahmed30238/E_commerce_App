import 'package:e_commerce_app/domain/Entity/products_entity.dart';

class ProductsModel extends ProductsEntity{
 const ProductsModel(
    super.id,
    super.price,
    super.old_price,
    super.discount,
    super.name,
    super.image,
    super.in_favorites,
    super.in_cart,
  );

  factory ProductsModel.fromjson(Map<String, dynamic> json) => ProductsModel(
        json['id'],
        json['price'].toDouble(),
        json['old_price'].toDouble(),
        json['discount'],
        json['name'],
        json['image'],
        json['in_favorites'],
        json['in_cart'],
      );
}

