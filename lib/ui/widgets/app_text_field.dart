import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  String? hintText;
  TextEditingController controller = TextEditingController();

  AppTextField({this.hintText ,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
      hintText: hintText
    ),);
  }
}
