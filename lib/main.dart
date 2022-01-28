import 'package:flutter/material.dart';
import 'package:flutter_project2/screens/Welcome/WelcomeScreen.dart';
import 'package:flutter_project2/utility/AppConstants.dart';
import 'package:flutter_project2/utility/Colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
