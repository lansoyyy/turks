import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class ExpensesPageAdmin extends StatelessWidget {
  const ExpensesPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Expenses'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(
              height: 50,
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBold(
                            text: '100,000.00',
                            fontSize: 16,
                            color: Colors.green),
                        TextRegular(
                            text: 'Total Amount',
                            fontSize: 12,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              title: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Ingeredients',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: ListView.builder(
                                        itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: TextBold(
                                            text: 'Meat',
                                            fontSize: 18,
                                            color: Colors.black),
                                        title: TextBold(
                                            text: '100pcs',
                                            fontSize: 16,
                                            color: Colors.black),
                                        subtitle: TextRegular(
                                            text: 'Quantity',
                                            fontSize: 10,
                                            color: Colors.grey),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextBold(
                                                text: '100.00',
                                                fontSize: 16,
                                                color: Colors.black),
                                            TextRegular(
                                                text: 'Price',
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                ListTile(
                                  leading: TextRegular(
                                      text: 'Total Amount',
                                      fontSize: 12,
                                      color: Colors.black),
                                  trailing: TextBold(
                                      text: '100,000.00',
                                      fontSize: 18,
                                      color: Colors.green),
                                ),
                              ],
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
                            ],
                          ));
                },
                child: TextBold(
                    text: 'Ingeredients', fontSize: 18, color: Colors.black),
              ),
            ),
            const Divider(
              height: 50,
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBold(
                            text: '100,000.00',
                            fontSize: 16,
                            color: Colors.green),
                        TextRegular(
                            text: 'Total Amount',
                            fontSize: 12,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              title: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Drinks',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: ListView.builder(
                                        itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: TextBold(
                                            text: 'Meat',
                                            fontSize: 18,
                                            color: Colors.black),
                                        title: TextBold(
                                            text: '100pcs',
                                            fontSize: 16,
                                            color: Colors.black),
                                        subtitle: TextRegular(
                                            text: 'Quantity',
                                            fontSize: 10,
                                            color: Colors.grey),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextBold(
                                                text: '100.00',
                                                fontSize: 16,
                                                color: Colors.black),
                                            TextRegular(
                                                text: 'Price',
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                ListTile(
                                  leading: TextRegular(
                                      text: 'Total Amount',
                                      fontSize: 12,
                                      color: Colors.black),
                                  trailing: TextBold(
                                      text: '100,000.00',
                                      fontSize: 18,
                                      color: Colors.green),
                                ),
                              ],
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
                            ],
                          ));
                },
                child:
                    TextBold(text: 'Drinks', fontSize: 18, color: Colors.black),
              ),
            ),
            const Divider(
              height: 50,
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBold(
                            text: '100,000.00',
                            fontSize: 16,
                            color: Colors.green),
                        TextRegular(
                            text: 'Total Amount',
                            fontSize: 12,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              title: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Bags',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: ListView.builder(
                                        itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: TextBold(
                                            text: 'Meat',
                                            fontSize: 18,
                                            color: Colors.black),
                                        title: TextBold(
                                            text: '100pcs',
                                            fontSize: 16,
                                            color: Colors.black),
                                        subtitle: TextRegular(
                                            text: 'Quantity',
                                            fontSize: 10,
                                            color: Colors.grey),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextBold(
                                                text: '100.00',
                                                fontSize: 16,
                                                color: Colors.black),
                                            TextRegular(
                                                text: 'Price',
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                ListTile(
                                  leading: TextRegular(
                                      text: 'Total Amount',
                                      fontSize: 12,
                                      color: Colors.black),
                                  trailing: TextBold(
                                      text: '100,000.00',
                                      fontSize: 18,
                                      color: Colors.green),
                                ),
                              ],
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
                            ],
                          ));
                },
                child:
                    TextBold(text: 'Bags', fontSize: 18, color: Colors.black),
              ),
            ),
            const Divider(
              height: 50,
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBold(
                            text: '100,000.00',
                            fontSize: 16,
                            color: Colors.green),
                        TextRegular(
                            text: 'Total Amount',
                            fontSize: 12,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              title: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Cups',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: ListView.builder(
                                        itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: TextBold(
                                            text: 'Meat',
                                            fontSize: 18,
                                            color: Colors.black),
                                        title: TextBold(
                                            text: '100pcs',
                                            fontSize: 16,
                                            color: Colors.black),
                                        subtitle: TextRegular(
                                            text: 'Quantity',
                                            fontSize: 10,
                                            color: Colors.grey),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextBold(
                                                text: '100.00',
                                                fontSize: 16,
                                                color: Colors.black),
                                            TextRegular(
                                                text: 'Price',
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                ListTile(
                                  leading: TextRegular(
                                      text: 'Total Amount',
                                      fontSize: 12,
                                      color: Colors.black),
                                  trailing: TextBold(
                                      text: '100,000.00',
                                      fontSize: 18,
                                      color: Colors.green),
                                ),
                              ],
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
                            ],
                          ));
                },
                child:
                    TextBold(text: 'Cups', fontSize: 18, color: Colors.black),
              ),
            ),
            const Divider(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
