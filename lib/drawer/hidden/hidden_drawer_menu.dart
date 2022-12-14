import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:word_suggestion/drawer/classic/drawer_sidebar.dart';
import 'package:word_suggestion/drawer/hidden/hidden_drawer_header.dart';
import 'package:word_suggestion/screens_home/aboutus_screen.dart';
import 'package:word_suggestion/screens_home/buffer_home_screen.dart';
import 'package:word_suggestion/screens_home/profile_screen.dart';
import 'package:word_suggestion/screens_home/start_screen.dart';
import 'package:word_suggestion/screens_home/suggestion_main_screen.dart';
import 'package:word_suggestion/screens_home/word_screen.dart';
import 'package:word_suggestion/suggestion/suggested_screen.dart';

class HiddenDrawerSidebar extends StatelessWidget {
  const HiddenDrawerSidebar({
    Key? key,
    required this.extPage,
    required this.index,
  }) : super(key: key);

  final String extPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      menu: const Menu(x: ""),
      screenSelectedBuilder: (position, controller) {
        Widget? screenCurrent;
        switch (position) {
          /*case 0:
            screenCurrent = const HomeScreen();
            break;*/
          case 1:
            screenCurrent = const SuggestionMainScreen();
            break;
          case 2:
            screenCurrent = const WordScreen();
            break;
          case 3:
            screenCurrent = const ProfileScreen();
            break;
          case 4:
            screenCurrent = const AboutusScreen();
            break;
          case 100:
            FirebaseAuth.instance.signOut();
            /*Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()));*/
            break;
          default:
            if (extPage == "suggested2") {
              screenCurrent = SuggestedScreen(
                pageType: "2",
                showIndex: index,
              );
            } else if (extPage == "suggested3") {
              screenCurrent = SuggestedScreen(
                pageType: "3",
                showIndex: index,
              );
            } else if (extPage == "suggested4") {
              screenCurrent = SuggestedScreen(
                pageType: "4",
                showIndex: index,
              );
            } else if (extPage == "mainSuggestion") {
              screenCurrent = const SuggestionMainScreen();
            } else if (extPage == "wordlist") {
              screenCurrent = const WordScreen();
            } else if (extPage == "profile") {
              screenCurrent = const ProfileScreen();
            } else if (extPage == "aboutus") {
              screenCurrent = const AboutusScreen();
            } else if (extPage == "logout") {
              FirebaseAuth.instance.signOut();
            }
        }
        return Scaffold(
          drawer: const DrawerSidebar(),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[900],
            title: InkWell(
              onTap: () {
                controller.toggle();
              },
              child: const Text("Word Suggestion App"),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const BufferHomeScreen(),
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
          body: screenCurrent ?? const StartScreen(),
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({Key? key, required this.x}) : super(key: key);

  final String x;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  late AnimationController _animationController;
  static late SimpleHiddenDrawerController _controller;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controller = SimpleHiddenDrawerController.of(context);
    _controller.addListener(() {
      if (_controller.state == MenuState.open) {
        _animationController.forward();
      }

      if (_controller.state == MenuState.closing) {
        _animationController.reverse();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 240,
          image: AssetImage('assets/menu_background.png'),
          fit: BoxFit.cover,
        ),
        color: Colors.black,
      ),
      child: ListView(
        padding: EdgeInsets.fromLTRB(
            0,
            MediaQuery.of(context).size.width * 0.10,
            MediaQuery.of(context).size.width * 0.25,
            0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HiddenDrawerHeader(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.07, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.translate, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      alignment: Alignment.centerLeft,
                      backgroundColor: Colors.grey[300],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.zero,
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _controller.setSelectedMenuPosition(1);
                    },
                    label: const Text(
                      "Word Suggestion",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.03, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.fact_check_outlined,
                        color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      alignment: Alignment.centerLeft,
                      backgroundColor: Colors.grey[300],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.zero,
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _controller.setSelectedMenuPosition(2);
                    },
                    label: const Text(
                      "Word List",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.03, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_pin_outlined,
                        color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      alignment: Alignment.centerLeft,
                      backgroundColor: Colors.grey[300],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.zero,
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _controller.setSelectedMenuPosition(3);
                    },
                    label: const Text(
                      "Profile",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.03, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.info_outline, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      alignment: Alignment.centerLeft,
                      backgroundColor: Colors.grey[300],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.zero,
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _controller.setSelectedMenuPosition(4);
                    },
                    label: const Text(
                      "About Us",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.03, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.logout, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      alignment: Alignment.centerLeft,
                      backgroundColor: Colors.grey[300],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.zero,
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _controller.setSelectedMenuPosition(100);
                    },
                    label: const Text(
                      "Log Out",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
