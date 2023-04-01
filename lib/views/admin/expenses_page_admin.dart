import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class ExpensesPageAdmin extends StatefulWidget {
  const ExpensesPageAdmin({Key? key}) : super(key: key);

  @override
  State<ExpensesPageAdmin> createState() => _ExpensesPageAdminState();
}

class _ExpensesPageAdminState extends State<ExpensesPageAdmin> {
  @override
  void initState() {
    getData1();
    getData2();
    getData3();
    getData4();

    super.initState();
  }

  late int data1Price = 0;
  late int data1Qty = 0;
  late int data2Price = 0;
  late int data2Qty = 0;
  late int data3Price = 0;
  late int data3Qty = 0;
  late int data4Price = 0;
  late int data4Qty = 0;

  int getTotal(int num1, int num2) {
    return num1 * num2;
  }

  late int totalPrice1 = 0;
  late int totalQuantity1 = 0;
  late int overAllTotal1 = 0;

  getData1() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Expenses')
        .where('type', isEqualTo: 'Ingredients');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          data1Price = data['price'];
          data1Qty = data['qty'];

          totalPrice1 += data1Price;
          totalQuantity1 += data1Qty;
          overAllTotal1 = totalPrice1 * totalQuantity1;
        }
      });
    }
    print(totalPrice1);
    print(totalQuantity1);
  }

  late int totalPrice2 = 0;
  late int totalQuantity2 = 0;
  late int overAllTotal2 = 0;

  getData2() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Expenses')
        .where('type', isEqualTo: 'Drinks');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          data2Price = data['price'];
          data2Qty = data['qty'];

          totalPrice2 += data2Price;
          totalQuantity2 += data2Qty;
          overAllTotal2 = totalPrice2 * totalQuantity2;
        }
      });
    }
  }

  late int totalPrice3 = 0;
  late int totalQuantity3 = 0;
  late int overAllTotal3 = 0;

  getData3() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Expenses')
        .where('type', isEqualTo: 'Bags');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          data3Price = data['price'];
          data3Qty = data['qty'];

          totalPrice3 += data3Price;
          totalQuantity3 += data3Qty;
          overAllTotal3 = totalPrice3 * totalQuantity3;
        }
      });
    }
  }

  late int totalPrice4 = 0;
  late int totalQuantity4 = 0;
  late int overAllTotal4 = 0;

  getData4() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Expenses')
        .where('type', isEqualTo: 'Cups');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          data4Price = data['price'];
          data4Qty = data['qty'];

          totalPrice4 += data4Price;
          totalQuantity4 += data4Qty;
          overAllTotal4 = totalPrice4 * totalQuantity4;
        }
      });
    }
  }

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
                            text: overAllTotal1.toString(),
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
                              'Ingredients',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Expenses')
                                        .where('type', isEqualTo: 'Ingredients')
                                        .orderBy('dateTime')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        print('error');
                                        return const Center(
                                            child: Text('Error'));
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
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
                                      return SingleChildScrollView(
                                        child: DataTable(columns: [
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Name',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Quantity',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Price',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ], rows: [
                                          for (int i = 0;
                                              i < data.docs.length;
                                              i++)
                                            DataRow(cells: [
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['item'],
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['qty']
                                                        .toString(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['price']
                                                        .toString(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ]),
                                        ]),
                                      );
                                    }),
                              ],
                            ),
                            actions: <Widget>[
                              MaterialButton(
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
                    text: 'Ingredients', fontSize: 18, color: Colors.black),
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
                            text: overAllTotal2.toString(),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Expenses')
                                        .where('type', isEqualTo: 'Drinks')
                                        .orderBy('dateTime')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        print('error');
                                        return const Center(
                                            child: Text('Error'));
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
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
                                      return SingleChildScrollView(
                                        child: DataTable(columns: [
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Name',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Quantity',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Price',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ], rows: [
                                          for (int i = 0;
                                              i < data.docs.length;
                                              i++)
                                            DataRow(cells: [
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['item'],
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['qty']
                                                        .toString(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['price']
                                                        .toString(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ]),
                                        ]),
                                      );
                                    }),
                              ],
                            ),
                            actions: <Widget>[
                              MaterialButton(
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
                            text: overAllTotal3.toString(),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Expenses')
                                        .where('type', isEqualTo: 'Bags')
                                        .orderBy('dateTime')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        print('error');
                                        return const Center(
                                            child: Text('Error'));
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
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
                                      return SingleChildScrollView(
                                        child: DataTable(columns: [
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Name',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Quantity',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Price',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ], rows: [
                                          for (int i = 0;
                                              i < data.docs.length;
                                              i++)
                                            DataRow(cells: [
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['item'],
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['qty']
                                                        .toString(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['price']
                                                        .toString(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ]),
                                        ]),
                                      );
                                    }),
                              ],
                            ),
                            actions: <Widget>[
                              MaterialButton(
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
                            text: overAllTotal4.toString(),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Expenses')
                                        .where('type', isEqualTo: 'Cups')
                                        .orderBy('dateTime')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        print('error');
                                        return const Center(
                                            child: Text('Error'));
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
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
                                      return SingleChildScrollView(
                                        child: DataTable(columns: [
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Name',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Quantity',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          DataColumn(
                                            label: TextBold(
                                                text: 'Price',
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ], rows: [
                                          for (int i = 0;
                                              i < data.docs.length;
                                              i++)
                                            DataRow(cells: [
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['item'],
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['qty']
                                                        .toString(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              DataCell(
                                                TextRegular(
                                                    text: data.docs[i]['price']
                                                        .toString(),
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ]),
                                        ]),
                                      );
                                    }),
                              ],
                            ),
                            actions: <Widget>[
                              MaterialButton(
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
