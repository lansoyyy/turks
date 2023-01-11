import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/services/cloud_function/add_inventory.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class InventoryPage extends StatefulWidget {
  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
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
                  box.write('inventoryType', 'Ingredients');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InventoryType()));
                },
                text: 'Ingredients'),
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

class InventoryType extends StatefulWidget {
  @override
  State<InventoryType> createState() => _InventoryTypeState();
}

class _InventoryTypeState extends State<InventoryType> {
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

  late String item;

  late String qty;

  late String unit = 'pcs';

  var unitList = ['pcs', 'kg', 'box', 'tray', 'dozen', 'others'];

  var _value = 0;

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
                            content: SizedBox(
                              height: 200,
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
                                  const SizedBox(
                                    height: 20,
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
                                  addInventory(item, qty, unit,
                                      box.read('inventoryType'), myName);
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
