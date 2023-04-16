// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AddOrDeleteFavouritesEntity extends Equatable {
  final bool status;
  final String message;

  const AddOrDeleteFavouritesEntity(this.status, this.message);

  @override
  List<Object> get props => [status, message];
}
