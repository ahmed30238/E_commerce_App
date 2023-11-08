// import 'package:bloc/bloc.dart';
// import 'package:e_commerce_app/presentation/screens/home_screen/pagination_controler/cubit/pagination_state.dart';
// import 'package:flutter/material.dart';

// class PaginationCubit extends Cubit<PaginationState> {
//   PaginationCubit() : super(PaginationInitial());
//   ScrollController scrollController = ScrollController();

//   bool loadMore = false;
//   void paginationMethod() {
//     if (scrollController.position.maxScrollExtent ==
//         scrollController.position.pixels) {
//       loadMore = true;
//       if(){}
//     }
//   }
// }

// /**
//  *    if (productsModel!.links.next != "") {
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
//             isLoadingMore = false;
//             update();
//           });
//         } 
//  */
