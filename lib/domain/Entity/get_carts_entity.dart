import 'package:e_commerce_app/domain/Entity/products_entity.dart';

class GetCartEntity {
  bool status;
  GetCartsDataEntity data;
  GetCartEntity({
    required this.status,
    required this.data,
  });
}

class GetCartsDataEntity {
  List<CartItemsEntity> cartItems;
  int subTotal;
  int total;
  GetCartsDataEntity({
    required this.cartItems,
    required this.subTotal,
    required this.total,
  });
}

class CartItemsEntity {
  int id;
  int quantity;
  ProductsEntity product;

  CartItemsEntity({
    required this.id,
    required this.quantity,
    required this.product,
  });
}
