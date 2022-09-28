import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class LogbookPage extends StatelessWidget {
  const LogbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Logbook'),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 2,
                    color: Colors.black,
                  )),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBold(
                                text: 'Log-in',
                                fontSize: 18,
                                color: Colors.red),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Logging in',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Column(
                                            children: [
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Name',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {},
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Date',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {},
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Time',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {},
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                // Navigator.of(context).pushReplacement(
                                                //     MaterialPageRoute(
                                                //         builder: (context) => LogInPage()));
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              child: TextBold(
                                  text: 'Add',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            return ListTile(
                              trailing: TextRegular(
                                  text: 'August 03, 2022',
                                  fontSize: 12,
                                  color: Colors.black),
                              title: TextBold(
                                  text: 'Lance Olana',
                                  fontSize: 18,
                                  color: Colors.black),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 2,
                    color: Colors.black,
                  )),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBold(
                                text: 'Log-out',
                                fontSize: 18,
                                color: Colors.red),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Logging out',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Column(
                                            children: [
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Name',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {},
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Date',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {},
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Time',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {},
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                // Navigator.of(context).pushReplacement(
                                                //     MaterialPageRoute(
                                                //         builder: (context) => LogInPage()));
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              child: TextBold(
                                  text: 'Add',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            return ListTile(
                              trailing: TextRegular(
                                  text: 'August 03, 2022',
                                  fontSize: 12,
                                  color: Colors.black),
                              title: TextBold(
                                  text: 'Lance Olana',
                                  fontSize: 18,
                                  color: Colors.black),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
