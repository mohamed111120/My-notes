import 'package:crud_nots/firebase_options.dart';
import 'package:crud_nots/ustilitis/show_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        title: Text("Register"),
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
              child: const Text('Register'),
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  final user = FirebaseAuth.instance.currentUser;
                  user?.sendEmailVerification();
                  Navigator.of(context).pushNamed('/verify');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    await showErroeDialog(
                      context,
                      "weak passwprd",
                    );
                  } else if (e.code == 'email-already-in-use') {
                    await showErroeDialog(
                      context,
                      'email already in use ',
                    );
                  } else if (e.code == 'invalid-email') {
                    await showErroeDialog(
                      context,
                      'invalid eamil enterd ',
                    );
                  } else {
                    await showErroeDialog(
                      context,
                      e.code,
                    );
                  }
                } catch (e) {
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
                    context, '/login', (route) => false);
              },
              child: Text('go to login page')),
        ],
      ),
    );

    Text('Lofing....');
  }
}
