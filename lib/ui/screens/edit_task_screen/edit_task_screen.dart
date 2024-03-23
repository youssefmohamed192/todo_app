import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = "edit";
  TodoDM model;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  EditTaskScreen({super.key, required this.model}) {
    titleController.text = model.title;
    descriptionController.text = model.description;
  }

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TO Do List",
          style: AppTheme.appBarTextStyle,
        ),
        // leading:const Icon(Icons.arrow_back_sharp, color: AppColors.white,),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(flex: 3, child: Container(color: AppColors.primary)),
              Expanded(flex: 8, child: Container(color: AppColors.accent)),
            ],
          ),
          Container(
            height: size.height * .7,
            width: size.width * .86,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: size.height * .02,
                ),
                Text(
                  "Edit Task",
                  style: AppTheme.taskTittleTextStyle
                      .copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.02),
                  child: TextFormField(
                    onChanged: (text){
                      widget.model.title = text;
                    },
                    controller: widget.titleController,
                    decoration: const InputDecoration(hintText: "Enter Title"),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.02),
                    child: TextFormField(
                      onChanged: (text){
                        widget.model.description = text;
                      },
                      controller: widget.descriptionController,
                      decoration:
                          const InputDecoration(hintText: "Enter Description"),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.02, top: size.height * .03),
                  child: Text(
                    "Select Date",
                    style: AppTheme.bottomSheetTittleTextStyle
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showMyDatePicker();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * .02),
                    child: Text(
                        "${widget.model.date.day}/${widget.model.date.month}/${widget.model.date.year}",
                        textAlign: TextAlign.center,
                        style: AppTheme.bottomSheetTittleTextStyle.copyWith(
                            fontWeight: FontWeight.normal,
                            color: AppColors.grey)),
                  ),
                ),
                SizedBox(height: size.height * .14,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * .18),
                  child: ElevatedButton(
                      onPressed: () async {
                        await provider.clickOnSaveChanges(widget.model);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(
                        "Save Changes",
                        style: AppTheme.taskTittleTextStyle
                            .copyWith(color: AppColors.white, fontWeight: FontWeight.normal),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    widget.model.date = await showDatePicker(
            context: context,
            initialDate: widget.model.date,
            firstDate: widget.model.date,
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        widget.model.date;
    setState(() {});
  }
}
