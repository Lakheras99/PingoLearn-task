import 'package:flutter/material.dart';
import 'package:pingolearn/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return splashScreen();
  }
}

class splashScreen extends StatelessWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xFFF5F9FD)),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
