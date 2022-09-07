import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Icon(
                  Icons.person_pin,
                  size: constraint.biggest.shortestSide * 0.5,
                );
              },
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            child: Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
