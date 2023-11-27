import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions/listWidgetsextension.dart';
import 'package:e_commerce_app/core/extensions/locale_context.dart';
import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/domain/Entity/products_entity.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/states.dart';
import 'package:e_commerce_app/presentation/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget productsCart(
  context,
  ProductsEntity homeModel,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        pageAnimator(
          ProductDetails(productModel: homeModel),
        ),
      );
    },
    child: ProductDesign(
      homeModel: homeModel,
    ),
  );
}

class ProductDesign extends StatelessWidget {
  final ProductsEntity homeModel;
  final double? height;

  const ProductDesign({
    super.key,
    required this.homeModel,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: 25.circualrRadius),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height ?? 120.h,
            width: double.infinity,
            child: homeModel.image.contains('student.valuxapps.com')
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: homeModel.image,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade800,
                      highlightColor: Colors.grey.shade700,
                      child: Container(
                        color: Colors.black,
                        width: 100.w,
                        height: 100.h,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : const SizedBox(),
          ),
          Padding(
            padding: 5.hPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: context.largeText(
                      homeModel.name,
                      fontSize: 17.sp,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                BlocConsumer<HomeCubit, HomeStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = HomeCubit.get(context);
                    return Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        iconSize: 25,
                        onPressed: () async {
                          cubit.changeFavouriteState(
                            homeModel.id,
                            TokenUtil.getTokenFromMemory(),
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
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                Text(
                  '${homeModel.price.toInt()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15.sp),
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
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: CustomElevatedButton(
              width: 100.w,
              height: 20.h,
              onTap: () {},
              text: AppStrings.addToCart,
              textColor: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ]
      ),
    );
  }
}
