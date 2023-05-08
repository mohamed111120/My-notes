import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVervication extends StatelessWidget {
  const EmailVervication({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Please press to verify your email "),
        TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              print(user);

              await user?.sendEmailVerification();
            },
            child: Text('verify'))
      ],
    );
  }
}
