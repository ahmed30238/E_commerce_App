import 'package:e_commerce_app/domain/Entity/add_to_cart.dart';

class AddToCartModel extends AddToCartEntity {
  const AddToCartModel({
    required super.status,
    required super.message,
    // required super.data,
  });

  factory AddToCartModel.fromjson(Map<String, dynamic> json) => AddToCartModel(
        status: json["status"],
        message: json["message"],
        // data: AddCartDataModel.fromjson(json["data"]),
      );
}

class AddCartDataModel extends AddCartDataEntity {
  AddCartDataModel(
      {required super.id, required super.quantity, required super.product});
  factory AddCartDataModel.fromjson(Map<String, dynamic> json) =>
      AddCartDataModel(
        id: json["id"],
        quantity: json["quantity"],
        product: CartProductModel.fromjson(json["product"]),
      );
}

class CartProductModel extends CartProductEntity {
  CartProductModel(
      {required super.id,
      required super.price,
      required super.oldPrice,
      required super.discount,
      required super.image,
      required super.name,
      required super.description});
  factory CartProductModel.fromjson(Map<String, dynamic> json) =>
      CartProductModel(
        id: json["id"],
        price: json["price"].toDouble(),
        oldPrice: json["old_price"].toDouble(),
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
      );
}
