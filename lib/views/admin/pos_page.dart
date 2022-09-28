import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class POSPage extends StatelessWidget {
  const POSPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppbarWidget('Sales'),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Scrollbar(
              child: ListView.builder(itemBuilder: ((context, index) {
                return ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBold(
                          text: 'Pizza-400.00',
                          fontSize: 18,
                          color: Colors.black),
                      TextRegular(
                          text: 'Item-Price', fontSize: 12, color: Colors.grey),
                    ],
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: TextBold(
                        text: '100', fontSize: 18, color: Colors.black),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: TextRegular(
                        text: 'Quantity', fontSize: 12, color: Colors.grey),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBold(
                          text: '1,000', fontSize: 18, color: Colors.black),
                      TextRegular(
                          text: 'Total', fontSize: 12, color: Colors.grey),
                    ],
                  ),
                );
              })),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              tileColor: Colors.white,
              title: TextRegular(
                  text: 'Overall Total:', fontSize: 12, color: Colors.black),
              trailing: TextBold(
                  text: '1,000,000.00', fontSize: 18, color: Colors.green),
            ),
          ),
          const Expanded(
            child: SizedBox(
              height: 30,
            ),
          ),
          ButtonWidget(onPressed: () {}, text: 'Save'),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
