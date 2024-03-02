import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const AlertDialog(
            content: Row(
              children: [
                Text("Loading..."),
                Spacer(),
                CircularProgressIndicator()
              ],
            ),
          ));
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      });
}
