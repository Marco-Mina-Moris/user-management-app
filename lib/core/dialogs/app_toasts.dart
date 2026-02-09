import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract class AppToast {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required ToastificationType type,
  }) {
    toastification.show(
      context: context,
      type: type,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: true,
      backgroundColor: backgroundColor(type),
      foregroundColor: Colors.white,
      progressBarTheme: ProgressIndicatorThemeData(
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }

  static Color backgroundColor(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return Colors.green;
      case ToastificationType.info:
        return Colors.blue;
      case ToastificationType.warning:
        return Colors.orange;
      case ToastificationType.error:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
