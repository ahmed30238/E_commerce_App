import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/favourite_item_cart.dart';
import 'package:e_commerce_app/presentation/controller/search_controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/search_controller/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (cotext, state) {},
      builder: (context, state) {
        final TextEditingController searchController = TextEditingController();

        var cubit = SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            child: Column(
              children: [
                SafeArea(
                  child: TextFormField(
                    controller: searchController,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return AppStrings.searchSomething;
                      }
                      return null;
                    },
                    onFieldSubmitted: (String val) async {
                      cubit.postSearch(searchController.text,
                          prefs?.getString('token') ?? '');
                      searchController.clear();
                    },
                    decoration: InputDecoration(
                      label: const Text(
                        AppStrings.search,
                      ),
                      suffix: const Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                10.ph,
                if (state is SearchLoadingState)
                  const LinearProgressIndicator(),
                30.ph,
                if (state is SearchSuccessState)
                  Expanded(
                    child: cubit.searchEntity!.data.dataObject.isEmpty
                        ? Center(
                            child: Text(
                              "No results",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => favouriteCartItem(
                                context: context,
                                model: SearchCubit.get(context)
                                    .searchEntity!
                                    .data
                                    .dataObject[index],
                                hasOldPrice: false),
                            separatorBuilder: (context, index) => 3.ph,
                            itemCount: SearchCubit.get(context)
                                .searchEntity!
                                .data
                                .dataObject
                                .length,
                          ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
