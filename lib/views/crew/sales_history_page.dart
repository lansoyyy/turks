import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
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
              stream: FirebaseFirestore.instance
                  .collection('Sales')
                  .orderBy('dateTime')
                  .snapshots(),
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
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          return DataTable(columns: [
                            DataColumn(
                              label: TextBold(
                                  text: 'Item',
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextBold(
                                  text: 'Quantity',
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextBold(
                                  text: 'Price',
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ], rows: [
                            for (int i = 0; i < snapshot.data!.size; i++)
                              DataRow(cells: [
                                DataCell(
                                  TextRegular(
                                      text: data.docs[index]['item'],
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                                DataCell(
                                  TextRegular(
                                      text: data.docs[index]['qty'].toString(),
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                                DataCell(
                                  TextRegular(
                                      text: data.docs[index]['price'],
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ])
                          ]);
                        })),
                  ),
                );
              }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
