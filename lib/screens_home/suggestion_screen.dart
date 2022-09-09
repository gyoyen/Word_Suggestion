import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../drawer/drawer_sidebar.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const DrawerSidebar(),
      body: const Center(
        child: Text("Suggestion"),
      ),
    );
  }
}
