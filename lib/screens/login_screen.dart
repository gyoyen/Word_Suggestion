import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    CupertinoIcons.lock_circle_fill,
                    size: 120,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: CustomDecoration("Eposta"),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: CustomDecoration("Parola"),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "user-not-found") {
                          showError(
                              "Böyle bir kullanıcı sistemde kayıtlı değil.");
                        } else if (e.code == "wrong-password") {
                          showError("Yanlış parola.");
                        } else if (e.code == "too-many-requests") {
                          showError(
                              "Çok fazla deneme yapıldı. Daha sonra tekrar deneyin.");
                        } else if (e.code == "invalid-email") {
                          showError(
                              "Lütfen geçerli bir eposta adresi ile tekrar deneyin");
                        }
                      }
                    },
                    child: const Text("Giriş"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //padding: const EdgeInsets.fromLTRB(60, 4, 60, 4),
                      backgroundColor: Colors.grey[400],
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text("Kayıt Ol"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration CustomDecoration(String hint) {
    InputDecoration ind = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.brown),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: hint,
      fillColor: Colors.grey[200],
      filled: true,
    );
    return ind;
  }

  void showError(String errorMessage) {
    print(errorMessage);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                errorMessage,
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
        );
      },
    );
  }
}
