// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app_task/constants/designConstants.dart';
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
    GlobalKey<FormState> emailformkey = GlobalKey<FormState>();
    GlobalKey<FormState> passwordformkey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool toggle = true;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            DesignConstants().gradientColor1,
            DesignConstants().gradientColor2
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.all(75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              Form(
                key: emailformkey,
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: DesignConstants().emailDecor,
                    validator: MultiValidator(
                      [
                        RequiredValidator(errorText: "* Required"),
                        EmailValidator(errorText: "Enter valid email id"),
                      ],
                    )),
              ),
              Form(
                  key: passwordformkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Required"),
                        ],
                      ),
                      controller: passwordController,
                      obscureText: toggle,
                      decoration: DesignConstants().passwordDecor)),
              ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all the fields')));
                    } else if (emailformkey.currentState!.validate() &&
                        passwordformkey.currentState!.validate()) {
                      auth
                          .signIn(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((result) {
                        if (result == null) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/home',
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Login Failed, Please try again with correct credentials')));
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      fixedSize: Size(150, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[700],
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
