import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme =  ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade800,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
          ),
          hintColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade700,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade700,
            elevation: 10,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          cardColor: Colors.grey.shade500,
          
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder()),
          primarySwatch: Colors.deepOrange,
        );