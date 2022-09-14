import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/drawer/hidden/hidden_drawer_menu.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({Key? key}) : super(key: key);

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  List<String> learnedList = [];
  List<Widget> itemList = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    getLearnedWords();
    //fillItemList();
    super.initState();
  }

  getLearnedWords() async {
    List<String> list = [];
    var event = await FirebaseDatabase.instance
        .ref()
        .child("Users/${FirebaseAuth.instance.currentUser!.uid}/LearnedWords")
        .once();
    String data = event.snapshot.value.toString();
    var xx = data.split(',,');
    for (var item in xx) {
      var yy = item.replaceAll(",", "");
      list.add(yy);
    }
    setState(() {
      learnedList = list;
    });

    for (int i = 0; i < learnedList.length; i++) {
      var event = await FirebaseDatabase.instance
          .ref()
          .child("Words/${learnedList[i]}/Word")
          .once();

      var item = ListTile(
        textColor: Colors.black,
        iconColor: Colors.black,
        tileColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(event.snapshot.value.toString()),
        trailing: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      HiddenDrawerSidebar(extPage: "suggested2", index: i)));
            },
            icon: const Icon(Icons.manage_search)),
      );
      setState(() {
        itemList.add(item);
      });
    }
    print(learnedList.length);
    print(itemList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.all(30),
            child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) => itemList[index])),
      ),
    );
  }
}
