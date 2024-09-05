abstract class CartState {}

class CartInitial extends CartState {}
class GetCartSuccessState extends CartState {}
class GetCartErrorState extends CartState {
  final String error;

  GetCartErrorState({required this.error});
}
class GetCartLoadingState extends CartState {}
