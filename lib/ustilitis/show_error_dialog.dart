import 'package:flutter/material.dart';

Future<void> showErroeDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error happend"),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Ok",
            ),
          )
        ],
      );
    },
  );
}
