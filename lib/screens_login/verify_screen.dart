import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/screens_home/buffer_home_screen.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({
    Key? key,
    required String this.prevScreen,
  }) : super(key: key);

  final String? prevScreen;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 4), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        canResendEmail = true;
      });
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const BufferHomeScreen()
        : WillPopScope(
            onWillPop: () async {
              FirebaseAuth.instance.signOut();
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey[900],
                centerTitle: true,
                title: const Text("Verify Email"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "A verification e-mail has been sent to '${FirebaseAuth.instance.currentUser!.email.toString()}'",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Don't forget to check your spam folder",
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      icon: const Icon(CupertinoIcons.mail),
                      label: const Text("Resend Email"),
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
