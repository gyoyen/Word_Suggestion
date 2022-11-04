import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:word_suggestion/drawer/hidden/hidden_drawer_menu.dart';
import 'package:word_suggestion/suggestion/new_suggestion_screen.dart';

import 'buffer_home_screen.dart';

class SuggestionMainScreen extends StatefulWidget {
  const SuggestionMainScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionMainScreen> createState() => _SuggestionMainScreenState();
}

class _SuggestionMainScreenState extends State<SuggestionMainScreen> {
  String pageName = "";
  bool loading = true;
  late int wordCount;

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

      await FirebaseDatabase.instance
          .ref()
          .child("Users/${FirebaseAuth.instance.currentUser!.uid}")
          .update({"UnLearnedWords": ""});

      ref.child("0").set({
        "Word": "0",
        "isLearned": "-1",
      });
      setState(() {
        pageName = "0"; //unsuggested_word_screen_0
      });
      print("xxx");
    }
    //kayıt varsa
    else {
      //ama 10 kelimeden azsa
      if (dbEvent.snapshot.children.length < 10) {
        setState(() {
          pageName = "0"; //unsuggested_word_screen_1
        });
      }
      //ama 10 kelime ise
      else {
        setState(() {
          pageName = "1"; //suggested_word_screen
        });
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      if (pageName != "0") {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            icon: const Icon(Icons.info_outline),
            title: const Text("Word Limit."),
            content: const Text(
                "You can see learned or unlearned words again.\nGo to..."),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HiddenDrawerSidebar(
                            extPage: "suggested2", index: 0)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Learned")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HiddenDrawerSidebar(
                            extPage: "suggested3", index: 0)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Unlearned")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const BufferHomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Cancel")),
            ],
          ),
        );
      } else {
        return const NewSuggestionScreen();
      }
    }
  }
}
