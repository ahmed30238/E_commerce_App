import 'package:e_commerce_app/domain/Entity/banners_entity.dart';

class BannersModel extends BannersEntity{
  const BannersModel(
    super.id,
    super.image,
  );

  factory BannersModel.fromjson(Map<String, dynamic> json) => BannersModel(
        json['id'],
        json['image'],
      );
}
