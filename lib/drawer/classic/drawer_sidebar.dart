import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/drawer/classic/drawer_header.dart';
import 'package:word_suggestion/drawer/hidden/hidden_drawer_menu.dart';
import 'package:word_suggestion/screens_login/login_screen.dart';

import 'drawer_item.dart';

class DrawerSidebar extends StatelessWidget {
  const DrawerSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[350],
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          children: [
            const MyDrawerHeader(),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.black45,
            ),
            DrawerItem(
              name: "Word Suggestion",
              icn: const Icon(Icons.translate),
              onPressed: () => onItemPressed(context, index: 1),
            ),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.black45,
            ),
            DrawerItem(
              name: "Word List",
              icn: const Icon(Icons.fact_check_outlined),
              onPressed: () => onItemPressed(context, index: 2),
            ),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.black45,
            ),
            DrawerItem(
              name: "Profile",
              icn: const Icon(Icons.person_pin_outlined),
              onPressed: () => onItemPressed(context, index: 3),
            ),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.black45,
            ),
            DrawerItem(
              name: "About Us",
              icn: const Icon(Icons.info_outline),
              onPressed: () => onItemPressed(context, index: 4),
            ),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.black45,
            ),
            DrawerItem(
              name: "Log Out",
              icn: const Icon(Icons.logout),
              onPressed: () => onItemPressed(context, index: 0),
            ),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    //Navigator.pop(context);

    switch (index) {
      case 0:
        FirebaseAuth.instance.signOut();
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HiddenDrawerSidebar(
                extPage: "mainSuggestion", index: -1)));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const HiddenDrawerSidebar(extPage: "wordlist", index: -1)));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const HiddenDrawerSidebar(extPage: "profile", index: -1)));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const HiddenDrawerSidebar(extPage: "aboutus", index: -1)));
        break;
      default:
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        /*Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
            const HiddenDrawerSidebar(extPage: "logout", index: -1)));*/
        break;
    }
  }
}
