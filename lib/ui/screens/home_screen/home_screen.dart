import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/App_user.dart';
import 'package:todo_app/ui/bottom_sheets/add_bottom_sheet.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/screens/auth/login/login_screen.dart';
import 'package:todo_app/ui/screens/tabs/list_tab/list_tab.dart';
import 'package:todo_app/ui/screens/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/ui/utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curSelectedTabIndex = 0;
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBotNavBar(),
      body: curSelectedTabIndex == 0 ? ListTab() : const SettingsTab(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: Text("Welcome ${AppUser.currentUser!.username}"),
        toolbarHeight: MediaQuery.of(context).size.height * .12,
        actions: [
          InkWell(
              onTap: (){
                AppUser.currentUser = null;
                provider.todos.clear();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.logout),
              ))
        ],
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
                    child: AddBottomSheet(),
                  ));
        },
        child: const ImageIcon(AssetImage(AppAssets.addIcon)),
      );
}
