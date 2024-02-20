import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:todo_app/ui/screens/tabs/list_tab/todo_widget.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class ListTab extends StatelessWidget {
  List<TodoDM> todos = [] ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .12,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(flex: 3, child: Container(color: AppColors.primary)),
                  Expanded(flex: 9, child: Container(color: AppColors.accent)),
                ],
              ),
              CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) => print(date),
                leftMargin: 20,
                monthColor: AppColors.lightBlack,
                dayColor: AppColors.lightBlack,
                activeDayColor: AppColors.primary,
                activeBackgroundDayColor: AppColors.white,
                dotsColor: AppColors.transparent,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) =>  TodoWidget(model: todos[index]),
          ),
        ),
      ],
    );
  }
  // void refreshTodosList() {
  //   FirebaseFirestore.instance.collection(TodoDM.collectionName);
  //
  // }
}
