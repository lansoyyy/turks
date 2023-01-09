import 'package:cloud_firestore/cloud_firestore.dart';

Future addInventory(
    String item, String qty, String unit, String type, String myName) async {
  final docUser = FirebaseFirestore.instance.collection('Inventory').doc();

  final json = {
    'item': item,
    'qty': qty,
    'unit': unit,
    'id': docUser.id,
    'type': type,
    'dateTime': DateTime.now(),
    'myName': myName
  };

  await docUser.set(json);
}
