import 'package:flutter/material.dart';
import 'package:turks/utils/colors.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Notifications'),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ListTile(
              tileColor: Colors.white,
              leading: const Icon(
                Icons.mail,
                color: secondaryColor,
                size: 38,
              ),
              title: TextBold(
                  text: 'From: ADMIN', fontSize: 18, color: Colors.black),
              trailing: TextRegular(
                  text: 'August 03, 2022', fontSize: 12, color: Colors.grey),
            ),
          );
        }),
      ),
    );
  }
}
