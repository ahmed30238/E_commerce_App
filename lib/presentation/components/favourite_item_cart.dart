import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget favouriteCartItem({
  required context,
  required dynamic model,
  bool hasOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).height * .20,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade800,
                      highlightColor: Colors.grey.shade700,
                      child: Container(
                        color: Colors.black,
                        width: 100.w,
                        // height: 100.h,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                  hasOldPrice
                      ? Positioned(
                          bottom: 0,
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 247, 2, 23),
                            ),
                            child: Center(
                              child: Text(
                                '${AppStrings.discounts} ${model.discount}\$',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 210, 224, 9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Text(''),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      model.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${model.price.toInt()}\$',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        hasOldPrice
                            ? Text(
                                '${model.old_price.toInt()}\$',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              )
                            : Text(
                                AppStrings.noDiscounts,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                        IconButton(
                          onPressed: () async {
                   
                            HomeCubit.get(context).changeFavouriteState(
                                model.id);
                          },
                          icon: HomeCubit.get(context).favorites.isNotEmpty
                              ? HomeCubit.get(context).favorites[model.id]!
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(Icons.favorite_border)
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        '${model.description}\$',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
