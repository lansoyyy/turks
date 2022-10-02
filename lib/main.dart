import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:turks/utils/firebase_options.dart';
import 'package:turks/views/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: LoadingScreenToHome(),
    );
  }
}
