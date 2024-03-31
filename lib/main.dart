import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_task/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
      fileName: "config.env"); // Load the values from the config.env file
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: dotenv.env['API_KEY']!,
    projectId: dotenv.env['PROJECT_ID']!,
    messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
    appId: dotenv.env['APP_ID']!,
  ));
  runApp(App());
}
