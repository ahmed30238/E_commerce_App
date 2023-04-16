import 'package:equatable/equatable.dart';

class BannersEntity extends Equatable {
  final int id;
  final String image;

  const BannersEntity(
    this.id,
    this.image,
  );

  @override
  List<Object> get props => [
        id,
        image,
      ];
}
