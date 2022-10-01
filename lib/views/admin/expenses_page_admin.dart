import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class ExpensesPageAdmin extends StatefulWidget {
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
        }
      });
    }
  }

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
        }
      });
    }
  }

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
        }
      });
    }
  }

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
                            text: getTotal(data1Price, data1Qty).toString(),
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
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Expenses')
                                        .where('type', isEqualTo: 'Ingredients')
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
                                      return Expanded(
                                        child: SizedBox(
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data?.size ?? 0,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: TextBold(
                                                      text: data.docs[index]
                                                          ['item'],
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                  title: TextBold(
                                                      text: data.docs[index]
                                                                  ['qty']
                                                              .toString() +
                                                          'pcs',
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  subtitle: TextRegular(
                                                      text: 'Quantity',
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                  trailing: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextBold(
                                                          text: data.docs[index]
                                                                      ['price']
                                                                  .toString() +
                                                              '.00',
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
                                      );
                                    }),
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
                            text: getTotal(data2Price, data2Qty).toString(),
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
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Expenses')
                                        .where('type', isEqualTo: 'Drinks')
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
                                      return Expanded(
                                        child: SizedBox(
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data?.size ?? 0,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: TextBold(
                                                      text: data.docs[index]
                                                          ['item'],
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                  title: TextBold(
                                                      text: data.docs[index]
                                                                  ['qty']
                                                              .toString() +
                                                          'pcs',
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  subtitle: TextRegular(
                                                      text: 'Quantity',
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                  trailing: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextBold(
                                                          text: data.docs[index]
                                                                      ['price']
                                                                  .toString() +
                                                              '.00',
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
                                      );
                                    }),
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
                            text: getTotal(data3Price, data3Qty).toString(),
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
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Expenses')
                                        .where('type', isEqualTo: 'Bags')
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
                                      return Expanded(
                                        child: SizedBox(
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data?.size ?? 0,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: TextBold(
                                                      text: data.docs[index]
                                                          ['item'],
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                  title: TextBold(
                                                      text: data.docs[index]
                                                                  ['qty']
                                                              .toString() +
                                                          'pcs',
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  subtitle: TextRegular(
                                                      text: 'Quantity',
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                  trailing: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextBold(
                                                          text: data.docs[index]
                                                                      ['price']
                                                                  .toString() +
                                                              '.00',
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
                                      );
                                    }),
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
                            text: getTotal(data4Price, data4Qty).toString(),
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
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Expenses')
                                        .where('type', isEqualTo: 'Cups')
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
                                      return Expanded(
                                        child: SizedBox(
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data?.size ?? 0,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: TextBold(
                                                      text: data.docs[index]
                                                          ['item'],
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                  title: TextBold(
                                                      text: data.docs[index]
                                                                  ['qty']
                                                              .toString() +
                                                          'pcs',
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  subtitle: TextRegular(
                                                      text: 'Quantity',
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                  trailing: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextBold(
                                                          text: data.docs[index]
                                                                      ['price']
                                                                  .toString() +
                                                              '.00',
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
                                      );
                                    }),
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
