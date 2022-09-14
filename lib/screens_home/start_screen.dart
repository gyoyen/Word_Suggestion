import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../drawer/classic/drawer_sidebar.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const DrawerSidebar(),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                const AutoSizeText(
                  "Welcome to Word Suggestion App",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60),
                  maxLines: 2,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const AutoSizeText(
                  "You can select the action you want\nto do by tapping the 'TITLE' above.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60),
                  maxLines: 2,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Image.asset("assets/phone_icon.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
