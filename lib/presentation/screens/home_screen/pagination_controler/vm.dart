// import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
// import 'package:e_commerce_app/data/models/home_model.dart';
// import 'package:e_commerce_app/domain/Entity/home_entity.dart';
// import 'package:e_commerce_app/domain/Entity/products_entity.dart';
// import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PaginationVm extends GetxController {
//   BuildContext? context;
//   List<ProductsEntity> dataList = [];
//   HomeEntity? productsModel;

//   HomeCubit cubit = HomeCubit.get(context);

//   @override
//   void onInit() {
//     productsPagination();
//     super.onInit();
//   }

//   ScrollController scrollController = ScrollController();
//   bool isLoadMore = false;

//   void productsPagination() {
//     scrollController.addListener(() {
//       if (scrollController.position.maxScrollExtent ==
//           scrollController.position.pixels) {
//         isLoadMore = true;
//         if (productsModel!.links.next != "") {
//           cubit
//               .getProducts(
//             prefs?.getString("token") ?? "",
//             page: productsModel.links.next
//                 .replaceAll('"', '')
//                 .split("?page")
//                 .last,
//           )
//               .then((value) {
//             productsModel = HomeModel.fromjson(value.response?.data);
//             for (var element in productsModel!.data.products) {
//               dataList.add(element);
//             }
//             isLoadMore = false;
//             update();
//           });
//         } else {
//           isLoadMore = false;
//           update();
//         }
//       }
//     });
//   }
// }
