import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  String? hintText;

  AppTextField({this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(decoration: InputDecoration(
      hintText: hintText
    ),);
  }
}
