import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HiddenDrawerHeader extends StatefulWidget {
  const HiddenDrawerHeader({Key? key}) : super(key: key);

  @override
  State<HiddenDrawerHeader> createState() => _HiddenDrawerHeaderState();
}

class _HiddenDrawerHeaderState extends State<HiddenDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.15,
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Icon(
                Icons.person_pin,
                size: constraint.biggest.shortestSide,
                color: Colors.grey[300],
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(12),
          child: AutoSizeText(
            FirebaseAuth.instance.currentUser!.email.toString(),
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey[300],
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
