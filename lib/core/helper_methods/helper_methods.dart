import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

navigateAndRemove({required BuildContext context, required String path}) {
  Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
}

navigateTo({required BuildContext context, required String path}) {
  Navigator.pushNamed(context, path);
}

SharedPreferences? prefs;

Future<void> showImagePicker({
  required BuildContext context,
  XFile? cameraImage,
  VoidCallback? onGalleryTapped,
  VoidCallback? onCameraTapped,
}) async {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      actions: [
        CupertinoButton(
          onPressed: onGalleryTapped,
          child: const Text("Gallery"),
        ),
        CupertinoButton(
          onPressed: onCameraTapped,
          child: const Text("Camera"),
        ),
      ],
      cancelButton: CupertinoButton(
        child: const Text("cancel"),
        onPressed: () => Navigator.pop(context),
      ),
    ),
  );
}
