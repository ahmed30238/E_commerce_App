import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/products_cart.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/states.dart';
import 'package:e_commerce_app/core/extensions/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getCategories();
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! banners section
                  CarouselSlider(
                    items: cubit.bannersModel
                        .map(
                          (e) => CachedNetworkImage(
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade800,
                              highlightColor: Colors.grey.shade700,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            imageUrl: e.image,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      aspectRatio: 16 / 9,
                      viewportFraction: .9,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                  10.ph,
                  Text(
                    AppStrings.category,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 20),
                  ),
                  10.ph,

                  //! Category Section
                  SizedBox(
                    height: 100,
                    child: cubit.categoryModel != null
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                    imageUrl: cubit.categoryModel!.categoryData
                                        .categoryObject[index].image,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey.shade800,
                                      highlightColor: Colors.grey.shade700,
                                      child: Container(
                                        color: Colors.black,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(.8),
                                    height: 30,
                                    width: 120,
                                    child: FittedBox(
                                      child: Text(
                                        cubit.categoryModel!.categoryData
                                            .categoryObject[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            separatorBuilder: (context, index) => 3.pw,
                            itemCount: cubit.categoryModel!.categoryData
                                .categoryObject.length,
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  10.ph,
                  Text(
                    AppStrings.newProducts,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 20),
                  ),

                  //! Products Section
                  10.ph,
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: .566,
                    children: cubit.homeModel != null
                        ? List.generate(
                            cubit.homeModel!.data.products.length,
                            (index) => productsCart(
                                  context,
                                  cubit.homeModel!.data.products[index],
                                ))
                        : List.generate(
                            6,
                            (index) => const Center(
                                child: CircularProgressIndicator())),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
