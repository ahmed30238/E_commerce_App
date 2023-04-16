import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/domain/Entity/products_entity.dart';

class HomeEntity extends Equatable {
  final bool status;
  final DataEntity data;
  const HomeEntity({
    required this.status,
    required this.data,
  });

  @override
  List<Object> get props => [
        status,
        data,
      ];
}

class DataEntity extends Equatable {
  final List<ProductsEntity> products;
  const DataEntity({
    required this.products,
  });

  @override
  List<Object> get props => [
        products,
      ];
}
