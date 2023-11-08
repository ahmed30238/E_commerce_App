import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/core/extensions/locale_context.dart';
import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:e_commerce_app/core/extensions/widget_extension.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/presentation/category_details/category_details.dart';
import 'package:e_commerce_app/presentation/components/products_cart.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/states.dart';
import 'package:e_commerce_app/presentation/screens/zoom_image/z.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var paginationVm = Get.put(PaginationVm()); // in case of using pagination
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
                          (e) => InkWell(
                            onTap: () => Navigator.push(
                                context,
                                pageAnimator(
                                    ZoomImage(image: e.image, imageId: e.id))),
                            child:
                            //  e.image.contains('student.valuxapps.com')
                            //     ?
                                 CachedNetworkImage(
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey.shade800,
                                      highlightColor: Colors.grey.shade700,
                                      child: Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    imageUrl: e.image,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                // : const SizedBox(),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                  10.ph,
                  context.largeText(AppStrings.category, fontSize: 20),
                  10.ph,
                  //! Category Section
                  SizedBox(
                    height: 100.h,
                    child: cubit.categoryModel != null
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CategoryItem(
                              cubit: cubit,
                              index: index,
                              model: cubit.categoryModel!,
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
                  context.largeText(AppStrings.newProducts, fontSize: 20),
                  // Text(
                  //   AppStrings.newProducts,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge!
                  //       .copyWith(fontSize: 20),
                  // ),
                  context.mediumText(text: "text", fontSize: 20),
                  //! Products Section
                  10.ph,
                  GridView.count(
                    // controller: vm.scrollController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: .7,
                    children: cubit.homeModel != null
                        ? List.generate(
                            cubit.homeModel!.data.products.length,
                            (index) => productsCart(
                              context,
                              cubit.homeModel!.data.products[index],
                            ),
                          )
                        : List.generate(
                            6,
                            (index) =>
                                const CircularProgressIndicator().center(),
                          ),
                  ),

                  //! in case of using pagination
                  // GetBuilder<PaginationVm>(
                  //   init: paginationVm,
                  //   builder: (vm) => GridView.count(
                  //     controller: vm.scrollController,
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 1,
                  //     mainAxisSpacing: 1,
                  //     childAspectRatio: .566,
                  //     children: cubit.homeModel != null
                  //         ? List.generate(
                  //             cubit.homeModel!.data.products.length,
                  //             (index) => productsCart(
                  //                   context,
                  //                   cubit.homeModel!.data.products[index],
                  //                 ))
                  //         : List.generate(
                  //             6,
                  //             (index) => const Center(
                  //                 child: CircularProgressIndicator())),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.cubit,
    required this.index,
    required this.model,
  });

  final HomeCubit cubit;
  final int index;
  final CategoryEntity model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        pageAnimator(
          CategoryDetails(
            catModel: model,
            index: index,
          ),
        ),
      ),
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          image: DecorationImage(
            image: cubit.categoryModel!.categoryData.categoryObject[index].image
                    .contains('student.valuxapps.com')
                ? NetworkImage(
                    cubit.categoryModel!.categoryData.categoryObject[index]
                        .image,
                  )
                : const AssetImage("") as ImageProvider,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black.withOpacity(.8),
            height: 30.h,
            width: 100.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                cubit.categoryModel!.categoryData.categoryObject[index].name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
