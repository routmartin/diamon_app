import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseToast {
  static void removeAllBaseToast() {
    return Get.closeAllSnackbars();
  }

  static showErorrBaseToast(String message) {
    return Get.showSnackbar(
      GetSnackBar(
        icon: const Icon(Icons.error_outline),
        backgroundColor: const Color.fromARGB(255, 230, 89, 79),
        message: message,
        snackPosition: SnackPosition.TOP,
        isDismissible: false,
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.GROUNDED,
      ),
    );
  }

  static showSuccessBaseToast(String message) {
    return Get.showSnackbar(
      GetSnackBar(
        icon: const Icon(Icons.done, color: Colors.white),
        backgroundColor: const Color(0XFF408140),
        message: message,
        snackPosition: SnackPosition.TOP,
        isDismissible: false,
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.GROUNDED,
      ),
    );
  }
}
