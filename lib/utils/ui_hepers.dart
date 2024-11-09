import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UIHelpers {
  // Show a GetX Snackbar
  static void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
      margin: const EdgeInsets.all(10),
    );
  }

  // Show a Flutter Toast
  static void showToast({
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int duration = 3,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
      timeInSecForIosWeb: duration,
    );
  }

  // Show a GetX Dialog
  static void showDialogBox({
    required String title,
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    String cancelText = 'Cancel',
    bool showCancelButton = true,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      confirm: TextButton(
        onPressed: () {
          if (onConfirm != null) {
            onConfirm();
          } else {
            Get.back(); // Close the dialog if no action
          }
        },
        child: Text(confirmText),
      ),
      cancel: showCancelButton
          ? TextButton(
              onPressed: () => Get.back(),
              child: Text(cancelText),
            )
          : null,
    );
  }

  // Show a custom loading dialog
  static void showLoading({
    String message = 'Loading...',
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false, // Disable back button
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text(message),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Close any open dialogs
  static void closeDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
