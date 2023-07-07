import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:quick_log/quick_log.dart';

class PusherController extends GetxController {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  Logger logger = const Logger("Pusher Logger");
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

  void onEvent(PusherEvent event) {
    logger.debug("onEvent: $event");
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
    await pusher.unsubscribe(
        channelName: "user_id");
    await pusher.disconnect();

    logger.fine("pusherDiconnect");
  }

  Future<void> pusherReConnect() async {
    await pusher.subscribe(
        channelName: "user_id");
    await pusher.connect();

    logger.fine("pusherReConnect");
  }
}
