import 'package:flutter/material.dart';
import 'package:turks/views/admin/create_account_page.dart';
import 'package:turks/views/admin/expenses_page_admin.dart';
import 'package:turks/views/admin/logbook_admin.dart';
import 'package:turks/views/admin/pos_page.dart';
import 'package:turks/views/chatroom_page.dart';
import 'package:turks/widgets/button_widget.dart';

import 'inventory_page.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/TURKS PNG.png',
              height: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChatRoom()));
                },
                text: 'Chat Room'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryAdminPage()));
                },
                text: 'Inventory'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LogbookAdmin()));
                },
                text: 'Logbook'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const POSPage()));
                },
                text: 'POS'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ExpensesPageAdmin()));
                },
                text: 'Expenses'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Create Account',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAccountPage()));
                                },
                                child: const Text(
                                  'Admin',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'QRegular',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              FlatButton(
                                color: Colors.red,
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAccountPage()));
                                },
                                child: const Text(
                                  'Crew',
                                  style: TextStyle(
                                      fontFamily: 'QRegular',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ));
                },
                text: 'Manage Accounts'),
          ],
        ),
      ),
    );
  }
}
