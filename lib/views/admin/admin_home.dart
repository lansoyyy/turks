import 'package:flutter/material.dart';
import 'package:turks/auth/login.dart';
import 'package:turks/views/admin/create_account_page.dart';
import 'package:turks/views/admin/expenses_page_admin.dart';
import 'package:turks/views/admin/logbook_admin.dart';
import 'package:turks/views/admin/pos_page.dart';
import 'package:turks/views/chatroom_page.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'inventory_page.dart';

class AdminHome extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChatRoom()));
                  },
                  text: 'Chat Room'),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InventoryAdminPage()));
                  },
                  text: 'Inventory'),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LogbookAdmin()));
                  },
                  text: 'Logbook'),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => POSPage()));
                  },
                  text: 'POS'),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExpensesPageAdmin()));
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
                                    box.write('createAccount', 'Admin');
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateAccountPage()));
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
                                    box.write('createAccount', 'Crew');
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateAccountPage()));
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
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                  onPressed: () {
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
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(
                                        fontFamily: 'QRegular',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogInPage()));
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
                  text: 'Logout'),
            ],
          ),
        ),
      ),
    );
  }
}
