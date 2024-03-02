import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/App_user.dart';
import 'package:todo_app/ui/screens/auth/register/register_screen.dart';
import 'package:todo_app/ui/screens/home_screen/home_screen.dart';
import 'package:todo_app/ui/utils/app_assets.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';
import 'package:todo_app/ui/utils/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";

  String password = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        toolbarHeight: size.height * .14,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: size.height * .25,
              ),
              Text("Welcome Back !",
                  style: AppTheme.appBarTextStyle
                      .copyWith(color: AppColors.black)),
              SizedBox(height: size.height * .01),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: const InputDecoration(hintText: "Email"),
              ),
              SizedBox(height: size.height * .01),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(hintText: "Password"),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text("Login", style: TextStyle(fontSize: 18)),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: size.height * .02,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.routeName);
                  },
                  child: Text(
                    "Create an account",
                    style: AppTheme.taskTittleTextStyle
                        .copyWith(color: AppColors.black45),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser currentUser =
          await getUserFromFireStore(userCredential.user!.uid);
      AppUser.currentUser = currentUser;
      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      hideLoading(context);
      showErrorDialog(
          context, e.message ?? "Something went wrong! Please try again later");
    }
  }

  Future<AppUser> getUserFromFireStore(String id) async {
    CollectionReference<AppUser> usersCollection = AppUser.collection();
    DocumentSnapshot<AppUser> documentSnapshot =
        await usersCollection.doc(id).get();
    return documentSnapshot.data()!;
  }
}
