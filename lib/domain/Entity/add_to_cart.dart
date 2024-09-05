import 'package:equatable/equatable.dart';

class AddToCartEntity extends Equatable {
  final bool status;
  final String message;
  // final AddCartDataEntity data;

  const AddToCartEntity({
    required this.status,
    required this.message,
    // required this.data,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        // data,
      ];
}

class AddCartDataEntity {
  int id;
  int quantity;
  CartProductEntity product;
  AddCartDataEntity({
    required this.id,
    required this.quantity,
    required this.product,
  });
}

class CartProductEntity {
  int id;
  double price;
  double oldPrice;
  int discount;
  String image;
  String name;
  String description;
  CartProductEntity({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });
}
