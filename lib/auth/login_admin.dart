import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turks/views/admin/admin_home.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class LoginAdmin extends StatelessWidget {
  late String username;
  late String password;

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
              TextBold(text: 'Login Admin', fontSize: 32, color: Colors.black),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: TextFormField(
                  onChanged: (_input) {
                    username = _input;
                  },
                  decoration: InputDecoration(
                    label: TextRegular(
                        text: 'Username:', fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (_input) {
                    password = _input;
                  },
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
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: username.trim() + '@Admin.com',
                          password: password.trim());
                      box.write('username', username.trim() + '@Admin.com');
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => AdminHome()));
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text(
                                  e.toString(),
                                  style:
                                      const TextStyle(fontFamily: 'QRegular'),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ));
                    }
                  },
                  text: 'Login'),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
