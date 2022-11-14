import 'package:cloud_firestore/cloud_firestore.dart';

Future postProduct(
  String productName,
  String imageURL,
  String price,
  String qty,
  String expireData,
) async {
  final docUser = FirebaseFirestore.instance.collection('Products').doc();

  final json = {
    'productName': productName,
    'url': imageURL,
    'price': price,
    'expireDate': expireData,
    'qty': qty,
    'id': docUser.id
  };

  await docUser.set(json);
}
