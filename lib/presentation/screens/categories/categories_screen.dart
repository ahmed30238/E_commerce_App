import 'package:e_commerce_app/presentation/components/category_item.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = HomeCubit.get(context);
        return cubit.categoryModel!=null? ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => categoryItem(
              context, cubit.categoryModel!.categoryData.categoryObject[index]),
          separatorBuilder: (context, index) => const SizedBox(
            height: 3,
          ),
          itemCount: cubit.categoryModel!.categoryData.categoryObject.length,
        ):const Center(child:  LinearProgressIndicator());
      },
    );
  }
}
