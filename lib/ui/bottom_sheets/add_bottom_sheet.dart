import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
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
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
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
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: Text(
                "Add",
                style: AppTheme.bottomSheetTittleTextStyle
                    .copyWith(color: AppColors.white),
              ),
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

  void addTodoToFireStore() async {
    CollectionReference todosCollectionRef = AppUser.collection()
        .doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference newEmptyDoc = todosCollectionRef.doc();
    await newEmptyDoc.set({
      "id": newEmptyDoc.id,
      "title": titleController.text,
      "description": descriptionController.text,
      "date": selectedDay,
      "isDone": false
    });
    provider.refreshTodosList();
    Navigator.pop(context);
  }
}
