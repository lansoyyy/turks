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
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBold(
                          text: 'Pizza', fontSize: 18, color: Colors.black),
                      TextRegular(
                          text: 'Item', fontSize: 12, color: Colors.grey),
                    ],
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: TextBold(
                        text: '400.00', fontSize: 18, color: Colors.black),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: TextRegular(
                        text: 'Price', fontSize: 12, color: Colors.grey),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBold(text: '100', fontSize: 18, color: Colors.black),
                      TextRegular(
                          text: 'Quantity', fontSize: 12, color: Colors.grey),
                    ],
                  ),
                );
              })),
            ),
          ),
        ],
      ),
    );
  }
}
