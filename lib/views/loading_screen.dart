import 'dart:async';

import 'package:flutter/material.dart';
import 'package:turks/auth/login.dart';

class LoadingScreenToHome extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<LoadingScreenToHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LogInPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Image(
                      width: 250,
                      image: AssetImage('assets/images/TURKS PNG.png'),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
