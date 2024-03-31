import 'package:flutter/material.dart';
import 'package:music_app_task/services/authHelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AuthenticationHelper auth = AuthenticationHelper();

    return Scaffold();
  }
}
