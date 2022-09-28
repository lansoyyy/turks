import 'package:flutter/material.dart';
import 'package:turks/auth/login_admin.dart';
import 'package:turks/auth/login_crew.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/TURKS PNG.png',
            height: 150,
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            width: 250,
            child: Center(
              child: TextBold(text: 'Login', fontSize: 28, color: Colors.black),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.brown,
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          ButtonWidget(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginAdmin()));
              },
              text: 'Admin'),
          const SizedBox(
            height: 20,
          ),
          ButtonWidget(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginCrew()));
              },
              text: 'Crew'),
        ]),
      ),
    );
  }
}
