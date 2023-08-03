import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  final CategoryEntity catModel;
  final int index;
  const CategoryDetails({
    super.key,
    required this.catModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var model = catModel.categoryData.categoryObject[index];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.cyan,
            child: Text(model.name),
          )
        ],
      ),
    );
  }
}
