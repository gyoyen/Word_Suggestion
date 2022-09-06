import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async => await FirebaseAuth.instance.signOut(),
              child: Text("Logout"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  User? user = FirebaseAuth.instance.currentUser;

                  print(user);

                  final ref = FirebaseDatabase.instance
                      .ref()
                      .child("Users/${user!.uid}");

                  print(ref);

                  await ref.set({
                    "Name": "nme",
                    "Surname": "snme",
                    "BirthDate": "bdt",
                    "Email": "eml",
                  });
                  print("eklendi");
                } on FirebaseException catch (e) {
                  print(
                      "HATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA___________________________________");
                  print(e);
                }
              },
              child: Text("ekle"),
            ),
          ],
        ),
      ),
    );
  }
}
