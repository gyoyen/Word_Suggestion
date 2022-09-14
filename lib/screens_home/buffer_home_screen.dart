import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/drawer/hidden/hidden_drawer_menu.dart';

class BufferHomeScreen extends StatefulWidget {
  const BufferHomeScreen({Key? key}) : super(key: key);

  @override
  State<BufferHomeScreen> createState() => _BufferHomeScreenState();
}

class _BufferHomeScreenState extends State<BufferHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const HiddenDrawerSidebar(extPage: "", index: -1),
    );
  }
}
