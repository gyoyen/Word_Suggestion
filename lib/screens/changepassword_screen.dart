import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/custom_decoration.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text("Reset Password"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(
                      CupertinoIcons.lock_rotation,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Please enter your e-mail address.\nA password reset link will then be sent to this email address.",
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Required.";
                        }
                        return null;
                      },
                      decoration: CustomDecoration().inputDecoration(
                          "E-mail", const Icon(CupertinoIcons.mail)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text("Send"),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();

                        try {
                          await auth
                              .sendPasswordResetEmail(
                                  email: _emailController.text.trim())
                              .then((_) => Navigator.of(context).pop());
                        } on FirebaseAuthException catch (e) {
                          final snackBar = SnackBar(
                            content: Text(e.code),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
