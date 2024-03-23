import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  String? hintText;
  TextEditingController controller = TextEditingController();

  AppTextField({this.hintText ,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
      hintText: hintText,
    ),);
  }
}
