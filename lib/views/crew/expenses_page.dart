import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/services/cloud_function/add_expenses.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class ExensesPage extends StatefulWidget {
  @override
  State<ExensesPage> createState() => _ExensesPageState();
}

class _ExensesPageState extends State<ExensesPage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Expenses'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
                onPressed: () {
                  box.write('expensesType', 'Ingredients');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExpensesType()));
                },
                text: 'Ingredients'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  box.write('expensesType', 'Drinks');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExpensesType()));
                },
                text: 'Drinks'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  box.write('expensesType', 'Bags');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExpensesType()));
                },
                text: 'Bags'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  box.write('expensesType', 'Cups');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExpensesType()));
                },
                text: 'Cups'),
          ],
        ),
      ),
    );
  }
}

class ExpensesType extends StatefulWidget {
  @override
  State<ExpensesType> createState() => _ExpensesTypeState();
}

class _ExpensesTypeState extends State<ExpensesType> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  late String myName = '';

  getData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: box.read('username'));

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          myName = data['name'];
        }
      });
    }
  }

  final box = GetStorage();

  late String type;

  late String item;

  late String price;

  late String qty;

  String getTotal(int num1, int num2) {
    return "${num1 * num2}";
  }

  late String unit = 'pcs';

  var unitList = ['pcs', 'kg', 'box', 'tray', 'dozen', 'others'];

  var _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(box.read('expensesType')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextBold(
                    text: 'Item - Price', fontSize: 18, color: Colors.black),
                TextBold(text: 'Quantity', fontSize: 18, color: Colors.black),
                TextBold(text: 'Total', fontSize: 18, color: Colors.black),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Expenses')
                    .where('type', isEqualTo: box.read('expensesType'))
                    .orderBy('dateTime')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('error');
                    return Center(child: Text(snapshot.error.toString()));
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
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextRegular(
                                  text: data.docs[index]['item'] +
                                      ' - ' +
                                      data.docs[index]['price'].toString(),
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextRegular(
                                  text: data.docs[index]['qty'].toString(),
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: TextRegular(
                                  text: getTotal(data.docs[index]['price'],
                                      data.docs[index]['qty']),
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                }),
            ButtonWidget(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Adding to Expenses',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: SizedBox(
                              height: 250,
                              child: Column(
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
                                          text: 'Quantity',
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                    onChanged: (_input) {
                                      qty = _input;
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  StatefulBuilder(
                                    builder: ((context, setState) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 2, 20, 2),
                                          child: DropdownButton(
                                            underline: Container(
                                                color: Colors.transparent),
                                            iconEnabledColor: Colors.black,
                                            isExpanded: true,
                                            value: _value,
                                            items: [
                                              for (int i = 0;
                                                  i < unitList.length;
                                                  i++)
                                                DropdownMenuItem(
                                                  onTap: () {
                                                    unit = unitList[i];
                                                  },
                                                  child: Center(
                                                      child: Row(children: [
                                                    Text("Unit: " + unitList[i],
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'QRegular',
                                                          color: Colors.black,
                                                        ))
                                                  ])),
                                                  value: i,
                                                ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _value =
                                                    int.parse(value.toString());
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                color: Colors.black,
                                onPressed: () {
                                  addExpenses(
                                      item,
                                      int.parse(qty),
                                      int.parse(price),
                                      box.read('expensesType'),
                                      myName,
                                      unit);
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
                text: 'Add Expenses'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
