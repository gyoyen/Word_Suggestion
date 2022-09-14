import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';
import 'package:word_suggestion/drawer/hidden/hidden_drawer_menu.dart';
import 'package:word_suggestion/suggestion/service.dart';

import '../screens_home/buffer_home_screen.dart';
import 'model.dart';

class NewSuggestionScreen extends StatefulWidget {
  const NewSuggestionScreen({
    Key? key,
    /*required this.wordCount,*/
  }) : super(key: key);

  //final int wordCount;

  @override
  State<NewSuggestionScreen> createState() => _NewSuggestionScreenState();
}

class _NewSuggestionScreenState extends State<NewSuggestionScreen> {
  Random rnd = Random();
  late int randomNumber;
  String newWord = "";
  late int newIndex;
  String trMeaning = "";
  bool loading = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: Yeni kelime üret.

    randomNumber = rnd.nextInt(4973);

    checkLearnedAndGenerateNewWord();

    super.initState();
  }

  checkLearnedAndGenerateNewWord() async {
    //LearnedWords ve UnLearnedWords alanlarını değişkene al
    var ds = await FirebaseDatabase.instance
        .ref()
        .child("Users/${FirebaseAuth.instance.currentUser!.uid}/LearnedWords")
        .once();
    String learnedWords = ds.snapshot.value.toString();

    ds = await FirebaseDatabase.instance
        .ref()
        .child("Users/${FirebaseAuth.instance.currentUser!.uid}/UnLearnedWords")
        .once();
    String unLearnedWords = ds.snapshot.value.toString();
    //Words tablosundan rastgele kelime getir
    ds = await FirebaseDatabase.instance
        .ref()
        .child("Words/$randomNumber/Word")
        .once();
    String word = ds.snapshot.value.toString();

    //LearnedWords ve UnLearnedWords değişkenlerinden birinde varsa bu kelime
    // daha önce gösterilmiştir
    if (learnedWords.contains(",$randomNumber,") ||
        unLearnedWords.contains(",$randomNumber,")) {
      setState(() {
        randomNumber = rnd.nextInt(4973);
      });
      checkLearnedAndGenerateNewWord();
    } else {
      setState(() {
        newWord = word;
      });

      //getEnglishMeaning();

      saveWord();

      translate(newWord);
    }
  }

  saveWord() async {
    //DailyWords'deki son kaydın id'sini al
    var ref = FirebaseDatabase.instance.ref().child(
        "DailyWords/${FirebaseAuth.instance.currentUser!.uid}/${DateFormat("MM-dd-yyyy").format(DateTime.now())}");
    var event = await ref.once();
    int lastIndex = int.parse(event.snapshot.children.last.key.toString());
    setState(() {
      newIndex = lastIndex + 1;
    });

    //Users > LearnedWords alanını getir.

    var ref2 = FirebaseDatabase.instance
        .ref()
        .child("Users/${FirebaseAuth.instance.currentUser!.uid}");
    String readData;

    //sonraki kayıt olarak ekle

    //DailyWords tablosuna ekle.
    ref.child("$newIndex").set({
      "Word": newWord,
      "isLearned": "0",
    });

    //Users tablosuna öğrenilmedi olarak ekle
    var event2 = await ref2.child("UnLearnedWords").once();
    readData = event2.snapshot.value.toString();
    ref2.update({"UnLearnedWords": "$readData,$randomNumber,"});
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      return WillPopScope(
          onWillPop: () async {
            backDialog();
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          ///FutureBuilder
                          FutureBuilder(
                            future:
                                DictionaryService().getMeaning(word: newWord),
                            builder: (context,
                                AsyncSnapshot<List<DictionaryModel>> snapshot) {
                              if (snapshot.hasData && !snapshot.hasError) {
                                return Expanded(
                                  child: ListView(
                                    children: List.generate(1, (index) {
                                      print(snapshot.data!.length);
                                      final data = snapshot.data![index];
                                      return Column(
                                        children: [
                                          ListTile(
                                            textColor: Colors.black,
                                            iconColor: Colors.black,
                                            tileColor: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            title: Text(data.word!),
                                            subtitle: Text(
                                                data.phonetics![index].text!),
                                            trailing: IconButton(
                                                onPressed: () {
                                                  String? path = data
                                                              .phonetics![index]
                                                              .audio !=
                                                          ""
                                                      ? data.phonetics![index]
                                                          .audio
                                                      : data
                                                          .phonetics![index + 1]
                                                          .audio;

                                                  playAudio(path!);
                                                },
                                                icon: const Icon(
                                                    Icons.audiotrack)),
                                          ),
                                          ListTile(
                                            textColor: Colors.black,
                                            iconColor: Colors.black,
                                            tileColor: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            title: Text(data
                                                .meanings![index]
                                                .definitions![index]
                                                .definition!),
                                            subtitle: Text(data.meanings![index]
                                                .partOfSpeech!),
                                            leading: Image.asset(
                                                "assets/english_icon.png"),
                                          ),
                                          ListTile(
                                            textColor: Colors.black,
                                            iconColor: Colors.black,
                                            tileColor: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            title: Text(trMeaning),
                                            leading: Image.asset(
                                                "assets/turkish_icon.png"),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black,
                                                    shape:
                                                        const StadiumBorder(),
                                                  ),
                                                  onPressed: () {
                                                    changeLearned();
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const HiddenDrawerSidebar(
                                                                    extPage:
                                                                        "mainSuggestion",
                                                                    index:
                                                                        -1)));
                                                  },
                                                  child: const Text(
                                                      "   I  Learned   ")),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black,
                                                    shape:
                                                        const StadiumBorder(),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const HiddenDrawerSidebar(
                                                                    extPage:
                                                                        "mainSuggestion",
                                                                    index:
                                                                        -1)));
                                                  },
                                                  child: const Text(
                                                      "Remind Later")),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                //kayıtları sil

                                return Center(
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {
                                          deleteData();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HiddenDrawerSidebar(
                                                          extPage:
                                                              "mainSuggestion",
                                                          index: -1)));
                                        },
                                        child: const Text("Try Again"),
                                      ),
                                      Text(snapshot.error.toString()),
                                    ],
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    } else {
      return const Center();
    }
  }

  playAudio(String music) {
    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.stop();
    audioPlayer.play(music);
  }

  translate(String string) {
    GoogleTranslator translator = GoogleTranslator();

    translator.translate(string, from: 'en', to: 'tr').then((value) {
      setState(() {
        trMeaning = value.text;
        loading = false;
      });
    });
  }

  deleteData() async {
    DatabaseReference ref2 = FirebaseDatabase.instance
        .ref()
        .child("Users/${FirebaseAuth.instance.currentUser!.uid}");

    DatabaseEvent event = await ref2.child("UnLearnedWords").once();
    String readData = event.snapshot.value.toString();
    String replacedData = readData.replaceAll(",$randomNumber,", "");
    ref2.update({"UnLearnedWords": replacedData});

    DatabaseReference ref3 = FirebaseDatabase.instance
        .ref()
        .child("DailyWords/${FirebaseAuth.instance.currentUser!.uid}/"
            "${DateFormat("MM-dd-yyyy").format(DateTime.now())}/"
            "$newIndex");

    ref3.remove();
  }

  changeLearned() async {
    DatabaseReference ref2 = FirebaseDatabase.instance
        .ref()
        .child("Users/${FirebaseAuth.instance.currentUser!.uid}");

    DatabaseEvent event = await ref2.child("UnLearnedWords").once();
    String readData = event.snapshot.value.toString();
    String replacedData = readData.replaceAll(",$randomNumber,", "");
    ref2.update({"UnLearnedWords": replacedData});

    event = await ref2.child("LearnedWords").once();
    readData = event.snapshot.value.toString();
    replacedData = "$readData,$randomNumber,";
    ref2.update({"LearnedWords": replacedData});

    DatabaseReference ref3 = FirebaseDatabase.instance
        .ref()
        .child("DailyWords/${FirebaseAuth.instance.currentUser!.uid}/"
            "${DateFormat("MM-dd-yyyy").format(DateTime.now())}/"
            "$newIndex");
    ref3.update({
      "isLearned": "1",
    });
  }

  backDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          icon: const Icon(Icons.sim_card_alert_outlined),
          title: const Text("Redirect Alert"),
          content: const Text(
              "If you do this, you will be redirected to the Home Screen."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const BufferHomeScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const StadiumBorder(),
              ),
              child: const Text(" Home "),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[400],
                shape: const StadiumBorder(),
              ),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
