import 'package:e_commerce_app/domain/Entity/products_entity.dart';
import 'package:e_commerce_app/presentation/components/products_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatelessWidget {
  final ProductsEntity productModel;

  const ProductDetails({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ProductDesign(
        height: 400,
        homeModel: productModel,
      ),
    );
  }
}
