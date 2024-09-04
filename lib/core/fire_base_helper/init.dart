import 'dart:developer';

import 'package:e_commerce_app/core/global/app_enums/enums.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class NotificationHelper {
  NotificationHelper._();

  static final NotificationHelper instance = NotificationHelper._();
  late FirebaseMessaging messaging;
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<String?> getFcmToken() async {
    String? token = '';
    try {
      token = await messaging.getToken();
      prefs?.setString(AppEnum.fcmToken.name, token ?? "");
    } catch (error) {
      log(error.toString());
    }
    return token;
  }
}
