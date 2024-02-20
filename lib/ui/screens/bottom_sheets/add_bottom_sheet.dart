import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';
import 'package:todo_app/ui/widgets/app_text_field.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDay = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
            AppTextField(
                hintText: "Enter task tittle", controller: titleController),
            const SizedBox(height: 8),
            AppTextField(
                hintText: "Enter task description",
                controller: descriptionController),
            const SizedBox(
              height: 16,
            ),
            Text("Select Date",
                style: AppTheme.bottomSheetTittleTextStyle
                    .copyWith(fontWeight: FontWeight.w600)),
            InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                  "${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",
                  textAlign: TextAlign.center,
                  style: AppTheme.bottomSheetTittleTextStyle.copyWith(
                      fontWeight: FontWeight.normal, color: AppColors.grey)),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                addTodoToFireStore();
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDay = await showDatePicker(
            context: context,
            initialDate: selectedDay,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDay;
    setState(() {});
  }

  void addTodoToFireStore() {
    CollectionReference todosCollectionRef =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    DocumentReference newEmptyDoc = todosCollectionRef.doc();
    newEmptyDoc.set({
      "id": newEmptyDoc.id,
      "tittle": titleController.text,
      "description": descriptionController.text,
      "date": selectedDay,
      "isDone": false
    }).timeout(Duration(milliseconds: 300),
        onTimeout: () => Navigator.pop(context));
  }
}
