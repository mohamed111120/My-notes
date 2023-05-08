import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            decoration: InputDecoration(hintText: 'Enter your e-mail'),
          ),
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            controller: _password,
            decoration: InputDecoration(hintText: 'Enter your password'),
          ),
          Center(
            child: TextButton(
              child: Text('Login'),
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                final UserCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                print(UserCredential);
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/register', (route) => false);
              },
              child: Text('go to register page')),
        ],
      ),
    );
  }
}
