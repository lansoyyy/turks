import 'package:cloud_firestore/cloud_firestore.dart';

Future addExpenses(
    String item, int qty, int price, String type, String myName) async {
  final docUser = FirebaseFirestore.instance.collection('Expenses').doc();

  final json = {
    'item': item,
    'qty': qty,
    'price': price,
    'id': docUser.id,
    'type': type,
    'dateTime': DateTime.now(),
    'myName': myName
  };

  await docUser.set(json);
}
