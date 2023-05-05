import 'package:crud_nots/firebase_options.dart';
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
    
    _email =TextEditingController();
    _password =TextEditingController();
  
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
      body: FutureBuilder(
        future:  Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
        ) ,
        builder: (context, snapshot) {

          switch (snapshot.connectionState) {
            
            case ConnectionState.done:
              return Column(
          children: [
            TextField(
              enableSuggestions: false,
              autocorrect:false ,
              keyboardType:TextInputType.emailAddress ,
              controller: _email,
              decoration: InputDecoration(hintText: 'Enter your e-mail'),
            ),
            TextField(
              enableSuggestions: false,
              autocorrect:false ,
                obscureText: true,
                controller: _password,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            Center(
              child: TextButton(
                child: Text('Register'),
                onPressed: () async {
      
                  
      
                  final email = _email.text;
                  final password = _password.text;
      
                final UserCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: password);
                      print(UserCredential);
                },
              ),
            ),
          ],
        );

        default : return Text('Lofing....');
          }

           
        },
      ),
    );
  }
}
