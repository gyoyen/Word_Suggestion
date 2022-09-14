import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';
import 'package:word_suggestion/drawer/hidden/hidden_drawer_menu.dart';
import 'package:word_suggestion/screens_home/buffer_home_screen.dart';
import 'package:word_suggestion/suggestion/model.dart';
import 'package:word_suggestion/suggestion/service.dart';

class SuggestedScreen extends StatefulWidget {
  const SuggestedScreen({
    Key? key,
    required this.pageType,
    required this.showIndex,
  }) : super(key: key);

  final String pageType;
  final int showIndex;

  @override
  State<SuggestedScreen> createState() => _SuggestedScreenState();
}

class _SuggestedScreenState extends State<SuggestedScreen> {
  Map<String, String> suggestedWords = <String, String>{};
  String trMeaning = "";
  bool loading = true;

  @override
  void initState() {
    fillSuggestedWords();

    super.initState();
  }

  fillSuggestedWords() async {
    String stringDateTime = DateFormat("MM-dd-yyyy").format(DateTime.now());

    DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        "DailyWords/${FirebaseAuth.instance.currentUser!.uid}/$stringDateTime");

    DatabaseEvent event = await ref.once();

    if (widget.pageType == "2" || widget.pageType == "4") {
      //learned
      for (var item in event.snapshot.children) {
        if (item.child("isLearned").value.toString() == "1") {
          suggestedWords[item.key.toString()] =
              item.child("Word").value.toString();
        }
      }
    } else {
      //unlearned
      for (var item in event.snapshot.children) {
        if (item.child("isLearned").value.toString() == "0") {
          suggestedWords[item.key.toString()] =
              item.child("Word").value.toString();
        }
      }
    }

    translate(suggestedWords.values.elementAt(widget.showIndex));

    setState(() {
      loading = false;
    });
    /*await Future.delayed(const Duration(seconds: 10));
    print("**************************************gectii");*/
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      return WillPopScope(
          onWillPop: () async {
            backDialog();
            return false;
          },
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
                          future: DictionaryService().getMeaning(
                              word: suggestedWords.values
                                  .elementAt(widget.showIndex)),
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
                                                    ? data
                                                        .phonetics![index].audio
                                                    : data.phonetics![index + 1]
                                                        .audio;

                                                playAudio(path!);
                                              },
                                              icon:
                                                  const Icon(Icons.audiotrack)),
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
                                          title: Text(data.meanings![index]
                                              .definitions![index].definition!),
                                          subtitle: Text(data
                                              .meanings![index].partOfSpeech!),
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
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: const StadiumBorder(),
                                                ),
                                                onPressed: () {
                                                  late int newIndex;

                                                  if (widget.showIndex == 0) {
                                                    newIndex = suggestedWords
                                                            .entries.length -
                                                        1;
                                                  } else {
                                                    newIndex =
                                                        widget.showIndex - 1;
                                                  }

                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          HiddenDrawerSidebar(
                                                              extPage: widget
                                                                          .pageType ==
                                                                      "2"
                                                                  ? "suggested2"
                                                                  : "suggested3",
                                                              index:
                                                                  newIndex)));
                                                },
                                                child: widget.showIndex != 0
                                                    ? const Text("<< Back")
                                                    : const Text("||< Last")),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: const StadiumBorder(),
                                                ),
                                                onPressed: () {
                                                  late int newIndex;
                                                  if (widget.showIndex ==
                                                      suggestedWords
                                                              .entries.length -
                                                          1) {
                                                    newIndex = 0;
                                                  } else {
                                                    newIndex =
                                                        widget.showIndex + 1;
                                                  }
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          HiddenDrawerSidebar(
                                                              extPage: widget
                                                                          .pageType ==
                                                                      "2"
                                                                  ? "suggested2"
                                                                  : "suggested3",
                                                              index:
                                                                  newIndex)));
                                                },
                                                child: widget.showIndex !=
                                                        suggestedWords.entries
                                                                .length -
                                                            1
                                                    ? const Text("Next >>")
                                                    : const Text("First >||")),
                                          ],
                                        ),
                                        ElevatedButton.icon(
                                            icon: const Icon(
                                                Icons.check_circle_outline),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey[600],
                                              shape: const StadiumBorder(),
                                            ),
                                            onPressed: () async {
                                              int newIndex;
                                              DatabaseReference ref = FirebaseDatabase
                                                  .instance
                                                  .ref()
                                                  .child(
                                                      "DailyWords/${FirebaseAuth.instance.currentUser!.uid}/"
                                                      "${DateFormat("MM-dd-yyyy").format(DateTime.now())}/"
                                                      "${suggestedWords.keys.elementAt(widget.showIndex)}");

                                              if (widget.pageType == "2") {
                                                ref.update({
                                                  "isLearned": "0",
                                                });
                                                changeLearnedData(
                                                    "LearnedToUnlearned");
                                              } else {
                                                ref.update({
                                                  "isLearned": "1",
                                                });
                                                changeLearnedData(
                                                    "UnlearnedToLearned");
                                              }

                                              if (suggestedWords
                                                      .entries.length !=
                                                  1) {
                                                if (widget.showIndex ==
                                                    suggestedWords
                                                            .entries.length -
                                                        1) {
                                                  newIndex = 0;
                                                } else {
                                                  newIndex = widget.showIndex;
                                                }
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HiddenDrawerSidebar(
                                                              extPage: widget
                                                                          .pageType ==
                                                                      "2"
                                                                  ? "suggested2"
                                                                  : "suggested3",
                                                              index: newIndex,
                                                            )));
                                              } else {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HiddenDrawerSidebar(
                                                              extPage:
                                                                  "mainSuggestion",
                                                              index: -1,
                                                            )));
                                              }
                                            },
                                            label: widget.pageType == "2"
                                                ? const Text(
                                                    "Mark As Not Learned")
                                                : const Text(
                                                    "Mark As Learned")),
                                      ],
                                    );
                                  }),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              //kayıtları sil
                              return Text(snapshot.error.toString());
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
      });
    });
  }

  changeLearnedData(String changeTo) async {
    DatabaseReference ref2 = FirebaseDatabase.instance
        .ref()
        .child("Users/${FirebaseAuth.instance.currentUser!.uid}");
    //Kelime öğrenmedim olarak işaretlenince Users tablosundaki LearnedWords
    // alanındaki kelime id'sini UnLearnedWords alanına taşı
    if (changeTo == "LearnedToUnlearned") {
      DatabaseEvent event = await ref2.child("LearnedWords").once();
      String readData = event.snapshot.value.toString();
      String replacedData = readData.replaceAll(
          ",${suggestedWords.values.elementAt(widget.showIndex)},", "");
      ref2.update({"LearnedWords": replacedData});

      event = await ref2.child("UnLearnedWords").once();
      readData = event.snapshot.value.toString();
      replacedData =
          "$readData,${suggestedWords.values.elementAt(widget.showIndex)},";
      ref2.update({"UnLearnedWords": replacedData});
    }
    //Kelime öğrendim olarak işaretlenince Users tablosundaki UnLearnedWords
    // alanındaki kelime id'sini LearnedWords alanına taşı
    else {
      DatabaseEvent event = await ref2.child("UnLearnedWords").once();
      String readData = event.snapshot.value.toString();
      String replacedData = readData.replaceAll(
          ",${suggestedWords.values.elementAt(widget.showIndex)},", "");
      ref2.update({"UnLearnedWords": replacedData});

      event = await ref2.child("LearnedWords").once();
      readData = event.snapshot.value.toString();
      replacedData =
          "$readData,${suggestedWords.values.elementAt(widget.showIndex)},";
      ref2.update({"LearnedWords": replacedData});
    }
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
              "If you do this, you will be redirected to the Home Screen or Word List."),
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
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const HiddenDrawerSidebar(
                        extPage: "wordlist", index: -1)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const StadiumBorder(),
              ),
              child: const Text(" Word "),
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
