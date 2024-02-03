import 'package:flutter/material.dart';

class Toast {
  static void show(BuildContext context, String message,
      {bool longDuration = false}) {
    final overlay = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(overlayEntry);

    final duration = longDuration ? 3 : 2;

    Future.delayed(Duration(seconds: duration), () {
      overlayEntry.remove();
    });
  }

  static void showToast(BuildContext context, String message) {
    show(context, message);
  }

  static void showToastLong(BuildContext context, String message) {
    show(context, message, longDuration: true);
  }
}
