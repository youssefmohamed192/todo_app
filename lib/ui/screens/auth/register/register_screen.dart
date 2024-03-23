import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/ui/screens/home_screen/home_screen.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';
import 'package:todo_app/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";

  String password = "";

  String username = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
              TextFormField(
                onChanged: (text) {
                  username = text;
                },
                decoration: const InputDecoration(label: Text("Username")),
              ),
              SizedBox(height: size.height * .01),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: const InputDecoration(label: Text("email")),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(label: Text("Password")),
              ),
              SizedBox(
                height: size.height * .1,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary),
                  onPressed: () {
                    register();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text("Create Account", style: AppTheme.bottomSheetTittleTextStyle.copyWith(color: AppColors.white)),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser newUser = AppUser(
          id: userCredential.user!.uid, username: username, email: email);
      await registerUserToFireStore(newUser);
      AppUser.currentUser = newUser;
      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      hideLoading(context);
      showErrorDialog(
          context, e.message ?? "Something went wrong! Please try again later");
    }
  }

  Future<void> registerUserToFireStore(AppUser user) async {
    CollectionReference<AppUser> userCollection = AppUser.collection();
    await userCollection.doc(user.id).set(user);
  }
}
