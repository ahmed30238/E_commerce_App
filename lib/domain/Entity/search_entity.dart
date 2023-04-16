// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable {
  final bool status;
  final SearchData data;

  const SearchEntity(this.status, this.data);

  @override
  List<Object> get props => [status, data];
}

class SearchData extends Equatable {
  final int current_page;
  final List<SearchDataObject> dataObject;

  const SearchData(this.current_page, this.dataObject);

  @override
  List<Object> get props => [current_page, dataObject];
}

class SearchDataObject extends Equatable {
  final int id;
  final int price;
  final String image;
  final String name;
  final String description;
  final List<String> images;
  final bool in_favorites;
  final bool in_cart;

  const SearchDataObject(this.id, this.price, this.image, this.name, this.description,
      this.images, this.in_favorites, this.in_cart);

  @override
  List<Object> get props {
    return [
      id,
      price,
      image,
      name,
      description,
      images,
      in_favorites,
      in_cart,
    ];
  }
}
