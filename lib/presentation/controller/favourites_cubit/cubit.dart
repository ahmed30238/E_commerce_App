import 'package:e_commerce_app/presentation/controller/favourites_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesCubit extends Cubit<FavouritesStates> {
  FavouritesCubit() : super(FavouritesInitialState());
  static FavouritesCubit get(context) => BlocProvider.of(context);
}
