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
    return WillPopScope(
      onWillPop: () async => false,
      child: const HiddenDrawerSidebar(),
    );
  }
}
