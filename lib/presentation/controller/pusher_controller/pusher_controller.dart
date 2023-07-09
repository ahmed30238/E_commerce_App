import 'dart:convert';

import 'package:e_commerce_app/data/models/home_model.dart';
import 'package:e_commerce_app/domain/Entity/home_entity.dart';
import 'package:e_commerce_app/domain/Entity/products_entity.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:quick_log/quick_log.dart';

class PusherController extends GetxController {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  Logger logger = const Logger("Pusher Logger");
  @override
  void onInit() {
    onConnect();
    pusherReConnect();
    super.onInit();
  }

  void onConnect() async {
    try {
      await pusher.init(
        apiKey: "8c1b3f6b92cdb698a78b",
        cluster: "ap2",
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
      );
      await pusher.subscribe(channelName: 'presence-chatbox');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    logger.info("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    logger.error("onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    logger.fine("onSubscriptionSucceeded: $channelName data: $data");
  }

  HomeEntity? homeModel;
  void onEvent(PusherEvent event) {
    logger.debug("onEvent: $event");

    if (event.eventName == "online-user") {
      var x = json.decode(event.data);
      logger.fine("online $x");
    } else if (event.eventName == "new-message") {
      var x = json.decode(event.data);
      var c = HomeModel.fromjson(x); //assume homemodel as chatModel
      var cp = c.data.products[0];
      updateMessages(
        ProductsEntity(
          cp.id,
          cp.price,
          cp.old_price,
          cp.discount,
          cp.name,
          cp.image,
          cp.in_favorites,
          cp.in_cart,
        ),
      );
    }
  }

  void onSubscriptionError(String message, dynamic e) {
    logger.error("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    logger.error("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    logger.info("onMemberAdded: $channelName member: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    logger.debug("onMemberRemoved: $channelName member: $member");
  }

  Future<void> pusherDiconnect() async {
    await pusher.unsubscribe(channelName: "user_id");
    await pusher.disconnect();

    logger.fine("pusherDiconnect");
  }

  Future<void> pusherReConnect() async {
    await pusher.subscribe(channelName: "user_id");
    await pusher.connect();

    logger.fine("pusherReConnect");
  }

  void updateMessages(ProductsEntity newMessage) {
    homeModel!.data.products.insert(0, newMessage);
    update();
  }
}
