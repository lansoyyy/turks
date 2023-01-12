import 'package:cloud_firestore/cloud_firestore.dart';

Future addSales(String item, String price, int qty, String myName) async {
  var dt = DateTime.now();
  final docUser = FirebaseFirestore.instance.collection('Sales').doc();

  final json = {
    'item': item,
    'id': docUser.id,
    'price': price,
    'date': dt.day.toString() +
        dt.month.toString() +
        dt.year.toString() +
        dt.hour.toString() +
        dt.minute.toString() +
        dt.second.toString(),
    'dateTime': DateTime.now(),
    'qty': qty,
    'myName': myName
  };

  await docUser.set(json);
}
