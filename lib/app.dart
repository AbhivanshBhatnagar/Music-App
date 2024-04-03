import 'package:flutter/material.dart';
import 'package:music_app_task/screens/homeScreen.dart';
import 'package:music_app_task/screens/loginScreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Music App',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginScreen(),
        });
  }
}
