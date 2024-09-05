import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/domain/Entity/get_carts_entity.dart';
import 'package:e_commerce_app/domain/use_cases/get_carts_usecase.dart';
import 'package:e_commerce_app/presentation/controller/cart_cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.getCartUsecase) : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  GetCartUsecase getCartUsecase;
  GetCartEntity? getCartEntity;
  getCarts() async {
    emit(GetCartLoadingState());
    var res = await getCartUsecase.call(const NoParameter());
    res.fold((l) {
      emit(
        GetCartErrorState(
          error: l.message,
        ),
      );
    }, (r) {
      getCartEntity = r;
      emit(GetCartSuccessState());
    });
  }
}
