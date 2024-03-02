import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/screens/auth/login/login_screen.dart';
import 'package:todo_app/ui/screens/auth/register/register_screen.dart';
import 'package:todo_app/ui/screens/home_screen/home_screen.dart';
import 'package:todo_app/ui/screens/splash_screen/splash_screen.dart';
import 'package:todo_app/ui/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.lightTheme,
        routes: {
      SplashScreen.routeName : (_) => const SplashScreen(),
      HomeScreen.routeName : (_) => const HomeScreen(),
      LoginScreen.routeName : (_) => LoginScreen(),
      RegisterScreen.routeName : (_) => RegisterScreen()
    },
        initialRoute: LoginScreen.routeName,
    );
  }
}
