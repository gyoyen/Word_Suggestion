import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../drawer/classic/drawer_sidebar.dart';

class AboutusScreen extends StatefulWidget {
  const AboutusScreen({Key? key}) : super(key: key);

  @override
  State<AboutusScreen> createState() => _AboutusScreenState();
}

class _AboutusScreenState extends State<AboutusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const DrawerSidebar(),
    );
  }
}
