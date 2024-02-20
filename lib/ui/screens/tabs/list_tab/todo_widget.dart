import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:todo_app/ui/utils/app_assets.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
  final TodoDM model;
  const TodoWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(16)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: .26,
          children: [
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ],
        ),
        child: Container(
          height: size.height * .13,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Row(
            children: [
              const VerticalDivider(),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(model.title,
                        style: AppTheme.taskTittleTextStyle),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(model.description,
                        style: AppTheme.taskDescriptionTextStyle),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary),
                  child: const ImageIcon(
                    AssetImage(AppAssets.checkIcon),
                    color: AppColors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
