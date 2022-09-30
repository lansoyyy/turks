import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/services/cloud_function/logbook.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class LogbookPage extends StatelessWidget {
  late String name;
  late String date;
  late String time;

  late String name1;
  late String date1;
  late String time1;
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
                                                onChanged: (_input) {
                                                  name = _input;
                                                },
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Date',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {
                                                  date = _input;
                                                },
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Time',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {
                                                  time = _input;
                                                },
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                logIn(name, date, time);
                                                Navigator.of(context).pop();
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
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Login')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              print('waiting');
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.blue,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
                            return Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                    itemCount: snapshot.data?.size ?? 0,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        trailing: TextRegular(
                                            text: data.docs[index]['date'],
                                            fontSize: 12,
                                            color: Colors.black),
                                        title: TextBold(
                                            text: data.docs[index]['name'],
                                            fontSize: 18,
                                            color: Colors.black),
                                      );
                                    }),
                              ),
                            );
                          }),
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
                                                onChanged: (_input) {
                                                  name1 = _input;
                                                },
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Date',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {
                                                  date1 = _input;
                                                },
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  label: TextRegular(
                                                      text: 'Time',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onChanged: (_input) {
                                                  time1 = _input;
                                                },
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                logOut(name1, date1, time1);
                                                Navigator.of(context).pop();
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
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Logout')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              print('waiting');
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.blue,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
                            return Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                  itemCount: snapshot.data?.size ?? 0,
                                    itemBuilder: (context, index) {
                                  return ListTile(
                                    trailing: TextRegular(
                                        text: data.docs[index]['date'],
                                        fontSize: 12,
                                        color: Colors.black),
                                    title: TextBold(
                                        text: data.docs[index]['name'],
                                        fontSize: 18,
                                        color: Colors.black),
                                  );
                                }),
                              ),
                            );
                          }),
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
