import 'package:flutter/material.dart';
import 'package:word_suggestion/drawer/drawer_sidebar.dart';

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
      backgroundColor: Colors.grey[300],
      drawer: const DrawerSidebar(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: const Text("Word Suggestion"),
      ),
    );
  }
}
