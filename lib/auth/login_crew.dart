import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turks/views/crew/crew_home.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class LoginCrew extends StatefulWidget {
  const LoginCrew({Key? key}) : super(key: key);

  @override
  State<LoginCrew> createState() => _LoginCrewState();
}

class _LoginCrewState extends State<LoginCrew> {
  late String username;

  late String password;

  final box = GetStorage();

  late String forgotPassword;
  late String myPassword;
  bool hasLoaded = false;
  late String answer;

  getData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: forgotPassword + '@Crew.com')
        .where('answer', isEqualTo: answer);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          myPassword = data['password'];
          hasLoaded = true;
        }
      });
    }
  }

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
              TextBold(text: 'Login Crew', fontSize: 32, color: Colors.black),
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
                          email: username.trim() + '@Crew.com',
                          password: password.trim());
                      box.write('username', username.trim() + '@Crew.com');
                      box.write('password', password);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => CrewHome()));
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
                                  MaterialButton(
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
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Recovering Password',
                              style: TextStyle(fontFamily: 'QBold'),
                            ),
                            content: Column(
                              children: [
                                TextFormField(
                                  onChanged: (_input) {
                                    forgotPassword = _input;
                                    getData();
                                  },
                                  decoration: InputDecoration(
                                    label: TextRegular(
                                        text: 'Enter your username',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (_input) {
                                    answer = _input;
                                    getData();
                                  },
                                  decoration: InputDecoration(
                                    label: TextRegular(
                                        text: "Enter your father's birthday",
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  try {
                                    hasLoaded
                                        ? showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                    'Your Password',
                                                    style: TextStyle(
                                                        fontFamily: 'QBold'),
                                                  ),
                                                  content: Text(
                                                    myPassword,
                                                    style: const TextStyle(
                                                        fontFamily: 'QRegular'),
                                                  ),
                                                  actions: <Widget>[
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LoginCrew()));
                                                      },
                                                      child: const Text(
                                                        'Continue',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'QRegular',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                        : const Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.black));
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontFamily: 'QRegular',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ));
                },
                child: TextBold(
                    text: 'Forgot Password?',
                    fontSize: 12,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
