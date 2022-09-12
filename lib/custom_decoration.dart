import 'package:flutter/material.dart';

class CustomDecoration {
  InputDecoration inputDecoration(String hint, Icon icn) {
    InputDecoration ind = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(40),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.brown),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: hint,
      fillColor: Colors.grey[200],
      filled: true,
      icon: icn,
    );
    return ind;
  }
}
