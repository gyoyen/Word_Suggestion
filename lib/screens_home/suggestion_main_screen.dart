import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:word_suggestion/suggestion/unsuggested_word_screen.dart';

import 'home_screen.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  String pageName = "";
  bool loading = true;

  @override
  initState() {
    dataCheck();
    super.initState();
  }

  dataCheck() async {
    String stringDateTime = DateFormat("MM-dd-yyyy").format(DateTime.now());

    DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        "DailyWords/${FirebaseAuth.instance.currentUser!.uid}/$stringDateTime");

    DatabaseEvent dbEvent = await ref.once();

    //hiç kayıt yoksa veya tarih farklıysa
    if (!dbEvent.snapshot.exists) {
      await FirebaseDatabase.instance.ref().child("/DailyWords").remove();
      ref.child("0").set({"Word": "0"});
      setState(() {
        pageName = "0"; //unsuggested_word_screen_0
      });
      print("xxx");
    }
    //kayıt varsa
    else {
      //ama 10 kelimeden azsa
      if (dbEvent.snapshot.children.length < 4) {
        setState(() {
          pageName = "1"; //unsuggested_word_screen_1
        });
      }
      //ama 10 kelime ise
      else {
        setState(() {
          pageName = "2"; //suggested_word_screen
        });
      }
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          body: pageName != "0" && pageName != "1"
              ? AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  icon: const Icon(Icons.info_outline),
                  title: const Text("Word Limit."),
                  content: const Text(
                      "You can see learned or unlearned words again.\nGo to..."),
                  actions: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: const Text("Learned"),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text("Unlearned")),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => const HomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400]),
                      child: const Text("Cancel"),
                    ),
                  ],
                )
              : pageName == "0"
                  ? const UnSuggestedWordScreen(pageType: "0")
                  : const UnSuggestedWordScreen(pageType: "1"));
    }
  }
}
