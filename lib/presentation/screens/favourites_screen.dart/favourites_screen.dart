import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/favourite_item_cart.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/states.dart';
import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) async {},
        builder: (context, state) {
          if (state is GetFavouriteLoadingState) {
            // ignore: use_build_context_synchronously
            if (HomeCubit.get(context)
                .getFavouritesEntity!
                .favouriteData!
                .favouriteItemData!
                .isNotEmpty) {
              // ignore: use_build_context_synchronously
              HomeCubit.get(context).getFavourites(sl());
            }
          }
          var cubit = HomeCubit.get(context);
          return cubit.getFavouritesEntity != null &&
                  cubit.getFavouritesEntity!.favouriteData!.favouriteItemData!
                      .isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => favouriteCartItem(
                    context: context,
                    model: cubit.getFavouritesEntity!.favouriteData!
                        .favouriteItemData![index].favouriteProduct,
                  ),
                  separatorBuilder: (context, index) => 10.ph,
                  itemCount: cubit.getFavouritesEntity!.favouriteData!
                      .favouriteItemData!.length,
                )
              :  Center(
                  child: Text(AppStrings.noFavourites,style: Theme.of(context).textTheme.bodyLarge,),
                );
        },
      );
    });
  }
}
