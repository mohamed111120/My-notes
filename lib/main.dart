import 'package:crud_nots/views/login_page.dart';
import 'package:crud_nots/views/register_page.dart';
import 'package:crud_nots/views/verify_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/verify': (context) => EmailVervication(),
        '/mainUi' : (context) => MainUi(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              if (user.emailVerified) {
                return const MainUi();
              } else {
                return EmailVervication();
              }
            } else {
              return RegisterPage();
            }

          default:
            return Text('Lofing....');
        }
      },
    );
  }
}

enum MenuAction { logOut }

class MainUi extends StatefulWidget {
  const MainUi({super.key});

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Ui"),
        actions: [
          PopupMenuButton(
            onSelected: (value) async{
          switch (value) {
            case MenuAction.logOut:
              final shouldLogOut = await showLogOutDialog(context);
              if(shouldLogOut)
              {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil("/login", (_) => false);
              }
              break;
          }
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: MenuAction.logOut,
                child: Text('log out'),
              ),
            ];
          }),
        ],
      ),
      body: Center(
        child: Text("Hello world"),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('log out'),
        content: Text('are you sure you want to log out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("log out")),
        ],
      );
    },
  ).then((value) => value ?? false);
}
