import 'package:e_commerce_app/core/extensions/locale_context.dart';
import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayOutScreen extends StatefulWidget {
  const LayOutScreen({super.key});

  @override
  State<LayOutScreen> createState() => _LayOutScreenState();
}

class _LayOutScreenState extends State<LayOutScreen> {
  void defineShared() async {
    HomeCubit.get(context).getBanners();
    HomeCubit.get(context).getProducts();
    HomeCubit.get(context).getFavourites();
  }

  @override
  void initState() {
    super.initState();
    defineShared();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(context.loc!.title),
            actions: [
              // IconButton(
              //   onPressed: () {
              //     AppCubit.get(context).toggleTheme();
              //   },
              //   icon: const Icon(
              //     Icons.dark_mode_outlined,
              //   ),
              // ),
              IconButton(
                onPressed: () async {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.searchScreen,
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 15,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavigationBarItems,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
