import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/domain/Entity/products_entity.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/components/flutter_toast.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/states.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/cubit.dart';
import 'package:e_commerce_app/core/extensions/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

Widget productsCart(
  context,
  ProductsEntity homeModel,
) {
  return Card(
    
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25))
    )
    ,
    elevation: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 4.5,
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: homeModel.image,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.grey.shade700,
              child: Container(
                color: Colors.black,
                width: 100,
                height: 100,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(
                  child: FadeIn(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  homeModel.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
              BlocConsumer<HomeCubit, HomeStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = HomeCubit.get(context);
                  return Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      iconSize: 35,
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        cubit.changeFavouriteState(
                          homeModel.id,
                          prefs.getString('token') ?? '',
                        );
                       
                      },
                      icon: cubit.favorites[homeModel.id]!
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Text(
                '${homeModel.price.toInt()}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 20),
              ),
              4.pw,
              homeModel.discount != 0
                  ? Text(
                      '${homeModel.old_price.toInt()}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold),
                    )
                  : const Text(''),
              4.pw,
              homeModel.discount != 0
                  ? Text(
                      '${homeModel.discount} off',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.red,
                          ),
                    )
                  : Text(
                      AppStrings.noDiscounts,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: CustomElevatedButton(
            width: 100.w,
            height: 20.h,
            onTap: () {},
            text: AppStrings.addToCart,
            textColor: Theme.of(context).colorScheme.onBackground,
            borderColor: AppCubit.get(context).isDarkTheme
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    ),
  );
}
