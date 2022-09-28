import 'package:flutter/material.dart';
import 'package:turks/views/crew/crew_home.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Adding Product'),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 250,
                width: 250,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextBold(
                        text: 'Upload Image', fontSize: 12, color: Colors.grey)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (_input) {},
              decoration: InputDecoration(
                label: TextRegular(
                    text: 'Price', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (_input) {},
              decoration: InputDecoration(
                label: TextRegular(
                    text: 'Quantity', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 50),
            child: TextFormField(
              onChanged: (_input) {},
              decoration: InputDecoration(
                label: TextRegular(
                    text: 'Expiration Date (Ex. 10/22/2022)',
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
          ),
          ButtonWidget(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                          content: const Text(
                            'Added Succesfully!',
                            style: TextStyle(fontFamily: 'QRegular'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CrewHome()));
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
              text: 'Add Product'),
        ]),
      ),
    );
  }
}
