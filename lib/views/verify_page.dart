import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVervication extends StatelessWidget {
  const EmailVervication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("verification"),
      ),
      body: Column(
        children: [
          Text(
              "We've send your email verify ,please open it to verify your account "),
          Text(
              " if you have not received a verivecation email yet , press the button below "),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                print(user);

                await user?.sendEmailVerification();
              },
              child: Text('verify')),
          TextButton(
            onPressed: ()async  {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/register', (route) => false);
            },
            child: const Text(
              'Restart',
            ),
          )
        ],
      ),
    );
  }
}
