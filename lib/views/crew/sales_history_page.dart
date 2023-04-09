import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class SalesHistoryPage extends StatefulWidget {
  const SalesHistoryPage({super.key});

  @override
  State<SalesHistoryPage> createState() => _SalesHistoryPageState();
}

class _SalesHistoryPageState extends State<SalesHistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
  }

  late String item;

  late String price;

  late String qty;

  List<int> prices = [];

  getTotal() {
    FirebaseFirestore.instance
        .collection('Sales')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          prices.add(int.parse(doc['price']));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Sales History'),
      body: SingleChildScrollView(
        child: Column(
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
                  return SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: DataTable(columns: [
                        DataColumn(
                          label: TextBold(
                              text: 'Item', fontSize: 14, color: Colors.black),
                        ),
                        DataColumn(
                          label: TextBold(
                              text: 'Quantity',
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        DataColumn(
                          label: TextBold(
                              text: 'Price', fontSize: 14, color: Colors.black),
                        ),
                      ], rows: [
                        for (int i = 0; i < snapshot.data!.size; i++)
                          DataRow(cells: [
                            DataCell(
                              TextRegular(
                                  text: data.docs[i]['item'],
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                            DataCell(
                              TextRegular(
                                  text: data.docs[i]['qty'].toString(),
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                            DataCell(
                              Builder(builder: (context) {
                                return TextRegular(
                                    text: data.docs[i]['price'],
                                    fontSize: 12,
                                    color: Colors.grey);
                              }),
                            ),
                          ])
                      ]),
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            TextBold(
                text:
                    'Total:     ₱${prices.reduce((sum, price) => sum + price)}',
                fontSize: 18,
                color: Colors.black),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
