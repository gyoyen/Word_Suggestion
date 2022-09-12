import 'package:flutter/material.dart';

class UnSuggestedWordScreen extends StatefulWidget {
  const UnSuggestedWordScreen({Key? key, required this.pageType})
      : super(key: key);

  final String pageType;

  @override
  State<UnSuggestedWordScreen> createState() => _UnSuggestedWordScreenState();
}

class _UnSuggestedWordScreenState extends State<UnSuggestedWordScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("unsuggested"),
    );
  }
}
