import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:word_suggestion/custom_decoration.dart';
import 'package:word_suggestion/screens_login/verify_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                      CupertinoIcons.person_badge_plus,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Register Form",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Required.";
                        }
                        return null;
                      },
                      decoration: CustomDecoration().inputDecoration(
                          "Name", const Icon(CupertinoIcons.person)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _surnameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Required.";
                        }
                        return null;
                      },
                      decoration: CustomDecoration().inputDecoration(
                          "Surname", const Icon(CupertinoIcons.person_2)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _birthdateController,
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Required.";
                        }
                        return null;
                      },
                      decoration: CustomDecoration().inputDecoration(
                          "Select date of birth",
                          const Icon(CupertinoIcons.calendar)),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _birthdateController.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
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
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Required.";
                        }
                        return null;
                      },
                      decoration: CustomDecoration().inputDecoration(
                          "Password", const Icon(CupertinoIcons.lock)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();

                        signUp(
                          _nameController.text,
                          _surnameController.text,
                          _birthdateController.text,
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      },
                      child: const Text("Sign Up"),
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

  signUp(String name, String surname, String birthdate, String email,
      String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      DatabaseReference ref = FirebaseDatabase.instance
          .ref()
          .child("Users/${userCredential.user!.uid}");

      await ref.set({
        "Name": name,
        "Surname": surname,
        "BirthDate": birthdate,
        "Email": email,
      }).then((_) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const VerifyScreen(
                prevScreen: "register_screen",
              ),
            ),
          ));
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(
        content: Text(e.code),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
