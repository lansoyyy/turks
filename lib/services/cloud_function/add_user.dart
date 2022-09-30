import 'package:cloud_firestore/cloud_firestore.dart';

Future addUser(
  String name,
  String username,
  String type,
) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc();

  final json = {
    'name': name,
    'username': username + '@$type.com',
    'id': docUser.id,
    'type': type
  };

  await docUser.set(json);
}
