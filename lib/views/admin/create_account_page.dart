import 'package:flutter/material.dart';
import 'package:turks/views/admin/admin_home.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Crew'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/profile.png',
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: TextFormField(
                  onChanged: (_input) {},
                  decoration: InputDecoration(
                    label: TextRegular(
                        text: 'Name:', fontSize: 18, color: Colors.black),
                  ),
                ),
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
                  obscureText: true,
                  onChanged: (_input) {},
                  decoration: InputDecoration(
                    label: TextRegular(
                        text: 'Password:', fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (_input) {},
                  decoration: InputDecoration(
                    label: TextRegular(
                        text: 'Confirm Password:',
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ButtonWidget(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: const Text(
                                'Account Created Succesfully!',
                                style: TextStyle(fontFamily: 'QRegular'),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminHome()));
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
                  text: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
