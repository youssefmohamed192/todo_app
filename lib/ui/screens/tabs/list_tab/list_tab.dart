import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/screens/tabs/list_tab/todo_widget.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider provider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.refreshTodosList();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .12,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(flex: 3, child: Container(color: AppColors.primary)),
                  Expanded(flex: 8, child: Container(color: AppColors.accent)),
                ],
              ),
              Positioned.fill(
                child: CalendarTimeline(
                  initialDate: provider.selectedDay,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateSelected: (date) {
                    provider.selectedDay = date;
                    provider.refreshTodosList();
                  },
                  leftMargin: 20,
                  monthColor: AppColors.lightBlack,
                  dayColor: AppColors.lightBlack,
                  activeDayColor: AppColors.primary,
                  activeBackgroundDayColor: AppColors.white,
                  dotsColor: AppColors.transparent,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: provider.todos.length,
            itemBuilder: (context, index) => TodoWidget(model: provider.todos[index]),
          ),
        ),
      ],
    );
  }
}