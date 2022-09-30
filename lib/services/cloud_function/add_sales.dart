import 'package:cloud_firestore/cloud_firestore.dart';

Future addSales(
  String item,
  String price,
  String qty,
) async {
  final docUser = FirebaseFirestore.instance.collection('Sales').doc();

  final json = {'item': item, 'qty': qty, 'id': docUser.id, 'price': price};

  await docUser.set(json);
}
