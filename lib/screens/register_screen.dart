import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _birthdate = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
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
                      decoration: CustomDecoration(
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
                      decoration: CustomDecoration(
                          "Surname", const Icon(CupertinoIcons.person_2)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _birthdate,
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Required.";
                        }
                        return null;
                      },
                      decoration: CustomDecoration("Select date of birth",
                          const Icon(CupertinoIcons.calendar)),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickeddate != null) {
                          setState(() {
                            _birthdate.text =
                                DateFormat('dd-MM-yyyy').format(pickeddate);
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
                      decoration: CustomDecoration(
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
                      decoration: CustomDecoration(
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
                      onPressed: () async {
                        if (!_formkey.currentState!.validate()) {
                          return;
                        }
                        _formkey.currentState!.save();
                        /*signUp(
                          _nameController.text,
                          _surnameController.text,
                          _birthdate.text,
                          _emailController.text,
                          _passwordController.text,
                        );*/
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

  InputDecoration CustomDecoration(String hint, Icon icn) {
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
      icon: icn,
    );
    return ind;
  }

  signUp(String name, String surname, String birthdate, String email,
      String password) async {}
}
