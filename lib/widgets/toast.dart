import 'package:flutter/material.dart';

class Toast {
  static void show(BuildContext context, String message,
      {bool longDuration = false}) {
    final overlay = Overlay.of(context);
    OverlayEntry overlayEntry;

    // Colors and dimensions similar to fluttertoast package
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black;
    double fontSize = 16.0;

    overlayEntry = OverlayEntry(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(color: textColor, fontSize: fontSize),
                  ),
                ),
              ),
            ),
          ],
        ),
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
