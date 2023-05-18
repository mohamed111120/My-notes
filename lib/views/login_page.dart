import 'dart:math';

import 'package:crud_nots/ustilitis/show_error_dialog.dart';
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

                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                    final user = await FirebaseAuth.instance.currentUser;
                    if (user?.emailVerified?? false) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/mainUi', (route) => false);
                    
                    }else{
                Navigator.of(context)
                      .pushNamedAndRemoveUntil('/verify', (route) => false);
                      
                    }
                  
                } on FirebaseAuthException catch (e) {
                  //TO DO ===>>> The name of Error

                  if (e.code == "user-not-found") {
                    await showErroeDialog(
                      context,
                      'user not found ',
                    );
                  } else if (e.code == 'wrong-password') {
                    await showErroeDialog(
                      context,
                      'wrong password ',
                    );
                  }else {
                      await showErroeDialog(
                      context,
                      'Error : ${e.code }',
                    );
                  }
                }  catch (e){

                  await showErroeDialog(
                      context,
                      e.toString(),
                    );
                }
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

