import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemModel {
  String image;
  String title;
  String body;

  ItemModel(
    this.image,
    this.title,
    this.body,
  );
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<ItemModel> data = [
    ItemModel(
      AppStrings.onBoardingimg1,
      AppStrings.onBoardingTitle1,
      AppStrings.onBoardingBody1,
    ),
    ItemModel(
      AppStrings.onBoardingimg2,
      AppStrings.onBoardingTitle2,
      AppStrings.onBoardingBody2,
    ),
    ItemModel(
      AppStrings.onBoardingimg3,
      AppStrings.onBoardingTitle3,
      AppStrings.onBoardingBody3,
    ),
  ];

  bool isLast = false;

  var indController = PageController();
/*
 bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CachHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeMode());
      }).catchError((error) {
        print(error.toString());
      });
*/
  void onSubmit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onBoarding', true).then((value) {
      // if (value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onSubmit,
            child: Text(
              AppStrings.skip,
              style: Theme.of(context).textTheme.bodyLarge!,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == data.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
                controller: indController,
                itemBuilder: (context, index) => buildBoardingItem(data[index]),
                itemCount: data.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: indController,
                  count: data.length,
                  effect: const ExpandingDotsEffect(
                    spacing: 3,
                    expansionFactor: 2,
                    activeDotColor: Colors.purple,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    indController.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear,
                    );
                    if (isLast) {
                      onSubmit();
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(ItemModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            model.image,
            height: 500,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      );
}
