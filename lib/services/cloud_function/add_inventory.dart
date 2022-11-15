import 'package:cloud_firestore/cloud_firestore.dart';

Future addInventory(
  String item,
  String qty,
  String unit,
  String type,
) async {
  final docUser = FirebaseFirestore.instance.collection('Inventory').doc();

  final json = {
    'item': item,
    'qty': qty,
    'unit': unit,
    'id': docUser.id,
    'type': type,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
