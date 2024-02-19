import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/bottom_sheets/add_bottom_sheet.dart';
import 'package:todo_app/ui/screens/tabs/list_tab/list_tab.dart';
import 'package:todo_app/ui/screens/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/ui/utils/app_assets.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curSelectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBotNavBar(),
      body: curSelectedTabIndex == 0 ? const ListTab() : const SettingsTab(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: const Text("To Do List"),
        toolbarHeight: MediaQuery.of(context).size.height * .12,
      );

  Widget buildBotNavBar() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
            onTap: (index) {
              curSelectedTabIndex = index;
              setState(() {});
            },
            currentIndex: curSelectedTabIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.listIcon)), label: ""),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.settingsIcon)),
                  label: ""),
            ]),
      );

  Widget buildFab() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: const AddBottomSheet(),
                  ));
        },
        child: const ImageIcon(AssetImage(AppAssets.addIcon)),
      );
}
