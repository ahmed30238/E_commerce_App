// ignore: file_names
import 'package:e_commerce_app/domain/Entity/add&delete_favourites_entity.dart';

class AddOrDeleteFavouritesModel extends AddOrDeleteFavouritesEntity {
  const AddOrDeleteFavouritesModel(super.status, super.message);

  factory AddOrDeleteFavouritesModel.fromjson(Map<String, dynamic> json) =>
      AddOrDeleteFavouritesModel(
        json['status'],
        json['message'],
      );
}
