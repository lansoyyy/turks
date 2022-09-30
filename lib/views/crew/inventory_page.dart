import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/services/cloud_function/add_inventory.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class InventoryPage extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Inventory'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
                onPressed: () {
                  box.write('inventoryType', 'Ingeredients');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InventoryType()));
                },
                text: 'Ingeredients'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  box.write('inventoryType', 'Drinks');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InventoryType()));
                },
                text: 'Drinks'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  box.write('inventoryType', 'Bags');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InventoryType()));
                },
                text: 'Bags'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  box.write('inventoryType', 'Cups');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InventoryType()));
                },
                text: 'Cups'),
          ],
        ),
      ),
    );
  }
}

class InventoryType extends StatelessWidget {
  final box = GetStorage();

  late String item;
  late String qty;
  late String unit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(box.read('inventoryType')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextBold(text: 'Item', fontSize: 18, color: Colors.black),
                TextBold(text: 'Quantity', fontSize: 18, color: Colors.black),
                TextBold(text: 'Unit', fontSize: 18, color: Colors.black),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Inventory')
                    .where('type', isEqualTo: box.read('inventoryType'))
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
                        itemCount: snapshot.data?.size ?? 0,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: TextRegular(
                                  text: data.docs[index]['item'],
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextRegular(
                                  text: data.docs[index]['qty'],
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: TextRegular(
                                  text: data.docs[index]['unit'],
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
                                  decoration: InputDecoration(
                                    label: TextRegular(
                                        text: 'Unit (Ex. kg)',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  onChanged: (_input) {
                                    unit = _input;
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              FlatButton(
                                color: Colors.black,
                                onPressed: () {
                                  addInventory(item, qty, unit,
                                      box.read('inventoryType'));
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
                text: 'Add Inventory'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
