import 'package:carbon_foodprint_pro/utils/customColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'adminPage.dart';
import 'firebase_options.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carbon Foodprint Pro',
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.bodyBackgroundColor,
      ),
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
