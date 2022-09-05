import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/screens/home_screen.dart';
import 'package:word_suggestion/screens/login_screen.dart';

class LoginController extends StatelessWidget {
  const LoginController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.requireData;
            if (user != null) {
              return HomeScreen(
                uid: user.uid.toString(),
                uemail: user.email.toString(),
              );
            } else {
              return const LoginScreen();
            }
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
