import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/states.dart';

import 'package:e_commerce_app/presentation/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayOutScreen extends StatefulWidget {
  const LayOutScreen({super.key});

  @override
  State<LayOutScreen> createState() => _LayOutScreenState();
}

class _LayOutScreenState extends State<LayOutScreen> {
  void defineShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? '';
    // ignore: use_build_context_synchronously
    HomeCubit.get(context).getBanners();
    // ignore: use_build_context_synchronously
    HomeCubit.get(context).getProducts(token);
    // ignore: use_build_context_synchronously
    HomeCubit.get(context).getFavourites(token);
    // TODO invoking Setting
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
            title: Text(AppStrings.appName),
            actions: [
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeThemeMode();
                },
                icon: const Icon(
                  Icons.dark_mode_outlined,
                ),
              ),
              IconButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
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
