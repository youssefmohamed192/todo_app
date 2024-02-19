import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';
import 'package:todo_app/ui/widgets/app_text_field.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: size.height * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Add New Task",
                textAlign: TextAlign.center,
                style: AppTheme.bottomSheetTittleTextStyle),
            const SizedBox(height: 16),
            AppTextField(hintText: "Enter task tittle"),
            const SizedBox(height: 8),
            AppTextField(hintText: "Enter task description"),
            const SizedBox(
              height: 16,
            ),
            Text("Select Date",
                style: AppTheme.bottomSheetTittleTextStyle
                    .copyWith(fontWeight: FontWeight.w600)),
            Text("2/19/2024",
                textAlign: TextAlign.center,
                style: AppTheme.bottomSheetTittleTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: AppColors.grey)),
            const Spacer(),
            ElevatedButton(onPressed: () {}, child: const Text("Add"),)
          ],
        ),
      ),
    );
  }
}
