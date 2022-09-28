import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class SalesHistoryPage extends StatelessWidget {
  const SalesHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Sales History'),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView.builder(itemBuilder: ((context, index) {
                return ListTile(
                  title: TextBold(
                      text: 'Pizza', fontSize: 18, color: Colors.black),
                  subtitle: TextRegular(
                      text: 'Item', fontSize: 12, color: Colors.grey),
                  trailing: TextBold(
                      text: 'Total Sold: 100pcs',
                      fontSize: 18,
                      color: Colors.red),
                );
              })),
            ),
          ),
        ],
      ),
    );
  }
}
