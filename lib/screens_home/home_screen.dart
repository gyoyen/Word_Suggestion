import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/hidden_drawer/hidden_drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return HiddenDrawerSidebar();

    /*return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: const DrawerSidebar(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          title: const Text("Home Screen"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.home,
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
