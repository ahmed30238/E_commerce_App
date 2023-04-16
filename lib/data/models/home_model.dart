import 'package:e_commerce_app/data/models/products_model.dart';
import 'package:e_commerce_app/domain/Entity/home_entity.dart';

class HomeModel extends HomeEntity {
 const HomeModel({
    required super.status, // bool
    required super.data, // object DataEntity
  });

  factory HomeModel.fromjson(Map<String, dynamic> json) => HomeModel(
        status: json['status'],
        data: DataModel.fromjson(
          json['data'],
        ),
      );
}

class DataModel extends DataEntity {
 const DataModel({
    required super.products, // List
  });
  factory DataModel.fromjson(Map<String, dynamic> json) => DataModel(
        products: List<ProductsModel>.from(
          (json['products'] as List).map(
            (e) => ProductsModel.fromjson(e),
          ),
        ),
      );
}
