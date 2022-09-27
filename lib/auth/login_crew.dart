import 'package:flutter/material.dart';
import 'package:turks/views/crew/crew_home.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class LoginCrew extends StatelessWidget {
  const LoginCrew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/TURKS PNG.png',
              height: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            TextBold(text: 'Login Crew', fontSize: 32, color: Colors.black),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
              child: TextFormField(
                onChanged: (_input) {},
                decoration: InputDecoration(
                  label: TextRegular(
                      text: 'Username:', fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
              child: TextFormField(
                onChanged: (_input) {},
                decoration: InputDecoration(
                  label: TextRegular(
                      text: 'Password:', fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const CrewHome()));
                },
                text: 'Login'),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: TextBold(
                  text: 'Forgot Password?', fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
