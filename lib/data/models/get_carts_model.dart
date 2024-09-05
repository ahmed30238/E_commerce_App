import 'package:e_commerce_app/data/models/products_model.dart';
import 'package:e_commerce_app/domain/Entity/get_carts_entity.dart';

class GetCartsModel extends GetCartEntity {
  GetCartsModel({required super.status, required super.data});
  factory GetCartsModel.fromjson(Map<String, dynamic> json) => GetCartsModel(
        status: json["status"],
        data: GetCartsDataModel.fromjson(json["data"]),
      );
}

class GetCartsDataModel extends GetCartsDataEntity {
  GetCartsDataModel({
    required super.cartItems,
    required super.subTotal,
    required super.total,
  });
  factory GetCartsDataModel.fromjson(Map<String, dynamic> json) =>
      GetCartsDataModel(
        cartItems: List<CartItemsModel>.from(
          (json["cart_items"] as List).map((e) => CartItemsModel.fromjson(e)),
        ),
        subTotal: json["sub_total"],
        total: json["total"],
      );
}

class CartItemsModel extends CartItemsEntity {
  CartItemsModel({
    required super.id,
    required super.quantity,
    required super.product,
  });
  factory CartItemsModel.fromjson(Map<String, dynamic> json) => CartItemsModel(
        id: json["id"],
        quantity: json["quantity"],
        product: ProductsModel.fromjson(json["product"]),
      );
}
