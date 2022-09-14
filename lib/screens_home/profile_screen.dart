import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:word_suggestion/screens_home/buffer_home_screen.dart';

import '../custom_decoration.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    fillTextFields();
    super.initState();
  }

  fillTextFields() async {
    var event = await FirebaseDatabase.instance
        .ref()
        .child("Users/${FirebaseAuth.instance.currentUser!.uid}")
        .once();

    setState(() {
      _nameController.text = event.snapshot.child("Name").value.toString();
      _surnameController.text =
          event.snapshot.child("Surname").value.toString();
      _birthdateController.text =
          event.snapshot.child("BirthDate").value.toString();
      _emailController.text = event.snapshot.child("Email").value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.person_2_square_stack,
                    size: MediaQuery.of(context).size.height * 0.2,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const Text(
                    "Update Profile",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    readOnly: true,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
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
                              DateFormat('MM-dd-yyyy').format(pickedDate);
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
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

                      updateProfile(
                        _nameController.text,
                        _surnameController.text,
                        _birthdateController.text,
                      );
                    },
                    child: const Text("Update To"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateProfile(String name, String surname, String birthdate) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref()
          .child("Users/${FirebaseAuth.instance.currentUser!.uid}");

      await ref.update({
        "Name": name,
        "Surname": surname,
        "BirthDate": birthdate,
      }).whenComplete(() => {
            Navigator.of(context).pushReplacement(CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const BufferHomeScreen()))
          });
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(
        content: Text(e.code),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
