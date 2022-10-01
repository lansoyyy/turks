import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/services/cloud_function/add_sales.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class SalesHistoryPage extends StatelessWidget {
  late String item;
  late String price;
  late String qty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Sales History'),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Sales').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('error');
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBold(
                                    text: data.docs[index]['item'],
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Item',
                                    fontSize: 12,
                                    color: Colors.grey),
                              ],
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextBold(
                                  text: data.docs[index]['price'] + '.00',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextRegular(
                                  text: 'Price',
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBold(
                                    text: data.docs[index]['qty'],
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Quantity',
                                    fontSize: 12,
                                    color: Colors.grey),
                              ],
                            ),
                          );
                        })),
                  ),
                );
              }),
          ButtonWidget(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Adding to Inventory',
                            style: TextStyle(
                                fontFamily: 'QBold',
                                fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  label: TextRegular(
                                      text: 'Item',
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                onChanged: (_input) {
                                  item = _input;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  label: TextRegular(
                                      text: 'Price',
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                onChanged: (_input) {
                                  price = _input;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  label: TextRegular(
                                      text: 'Quantity',
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                onChanged: (_input) {
                                  qty = _input;
                                },
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.black,
                              onPressed: () {
                                addSales(item, price, qty);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ));
              },
              text: 'Add Sales'),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
