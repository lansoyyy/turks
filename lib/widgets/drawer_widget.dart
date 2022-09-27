import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:turks/views/crew/crew_home.dart';
import 'package:turks/widgets/text_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<DrawerWidget> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              accountEmail: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextRegular(
                    text: box.read('contactNumber') ?? '09090104355',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  TextRegular(
                    text: box.read('address') ?? 'Impasugong Bukidnon',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ],
              ),
              accountName: TextBold(
                text: box.read('name') ?? 'Lance Olana',
                fontSize: 14,
                color: Colors.white,
              ),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  minRadius: 50,
                  maxRadius: 50,
                  backgroundImage:
                      NetworkImage(box.read('profilePicture') ?? ''),
                ),
              ),
            ),
            ListTile(
              title: TextBold(
                text: 'Products',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const CrewHome()));
              },
            ),
            ListTile(
              title: TextBold(
                text: 'Logbook',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: TextBold(
                text: 'Inventory',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: TextBold(
                text: 'Sales History',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: TextBold(
                text: 'Waste Reports',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: TextBold(
                text: 'Expenses',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: TextBold(
                text: 'Logout',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Logout Confirmation',
                            style: TextStyle(
                                fontFamily: 'QBold',
                                fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'Are you sure you want to Logout?',
                            style: TextStyle(fontFamily: 'QRegular'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: (context) => LogInPage()));
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
            ),
          ],
        ),
      ),
    );
  }
}
