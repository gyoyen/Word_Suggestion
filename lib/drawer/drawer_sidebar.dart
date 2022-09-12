import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_suggestion/drawer/drawer_header.dart';
import 'package:word_suggestion/screens_home/aboutus_screen.dart';
import 'package:word_suggestion/screens_home/profile_screen.dart';
import 'package:word_suggestion/screens_home/suggestion_main_screen.dart';
import 'package:word_suggestion/screens_home/word_screen.dart';

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
        Navigator.pop(context);
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => const SuggestionScreen(),
          ),
        );
        break;
      case 2:
        Navigator.pop(context);
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => const WordScreen(),
          ),
        );
        break;
      case 3:
        Navigator.pop(context);
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => const ProfileScreen(),
          ),
        );
        break;
      case 4:
        Navigator.pop(context);
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => const AboutusScreen(),
          ),
        );
        break;
      default:
        FirebaseAuth.instance.signOut();
        break;
    }
  }
}
