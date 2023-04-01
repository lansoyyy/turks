import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turks/views/admin/expenses_page_admin.dart';
import 'package:turks/views/admin/general_inventory.dart';
import 'package:turks/views/admin/logbook_admin.dart';
import 'package:turks/views/admin/pos_page.dart';
import 'package:turks/views/chatroom_page.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get/get.dart';

import '../../auth/login.dart';
import 'create_account_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    List myWidgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.to(ChatRoom());
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email_rounded,
                  size: 52,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextBold(
                    text: 'Banner Messages', fontSize: 18, color: Colors.black),
              ],
            ),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.to(const GeneralInventory());
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.inventory_rounded,
                  size: 52,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextBold(text: 'Inventory', fontSize: 24, color: Colors.black),
              ],
            ),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.to(LogbookAdmin());
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.groups_rounded,
                  size: 52,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextBold(text: 'Logbook', fontSize: 24, color: Colors.black),
              ],
            ),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.to(POSPage());
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.stacked_line_chart_sharp,
                  size: 52,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextBold(text: 'POS', fontSize: 24, color: Colors.black),
              ],
            ),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.to(ExpensesPageAdmin());
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.money_rounded,
                  size: 52,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextBold(text: 'Expenses', fontSize: 24, color: Colors.black),
              ],
            ),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            final box = GetStorage();
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text(
                        'Create Account',
                        style: TextStyle(
                            fontFamily: 'QBold', fontWeight: FontWeight.bold),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () {
                            box.write('createAccount', 'Admin');
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => CreateAccountPage()));
                          },
                          child: const Text(
                            'Admin',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'QRegular',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.red,
                          onPressed: () {
                            box.write('createAccount', 'Crew');
                            Get.to(CreateAccountPage());
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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_box_rounded,
                  size: 52,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextBold(
                    text: 'Manage Accounts', fontSize: 18, color: Colors.black),
              ],
            ),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text(
                        'Logout Confirmation',
                        style: TextStyle(
                            fontFamily: 'QBold', fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                        'Are you sure you want to Logout?',
                        style: TextStyle(fontFamily: 'QRegular'),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                                fontFamily: 'QRegular',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LogInPage()));
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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 52,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextBold(text: 'Logout', fontSize: 24, color: Colors.red),
              ],
            ),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/images/TURKS PNG.png',
            height: 150,
          ),
          TextBold(text: 'Admin Panel', fontSize: 18, color: Colors.black),
          Expanded(
            child: SizedBox(
              height: 500,
              child: GridView.builder(
                  itemCount: myWidgets.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return myWidgets[index];
                  }),
            ),
          )
        ],
      )),
    );
  }
}
