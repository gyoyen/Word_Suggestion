import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../drawer/drawer_sidebar.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({Key? key}) : super(key: key);

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const DrawerSidebar(),
    );
  }
}
