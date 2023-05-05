import 'package:crud_nots/views/login_page.dart';
import 'package:crud_nots/views/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;

              if (user?.emailVerified ?? false) {
                return Text('Done');
              } else {
                return EmailVervication();
              }

            default:
              return Text('Lofing....');
          }
        },
      ),
    );
  }
}

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
