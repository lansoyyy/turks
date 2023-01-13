import 'package:cloud_firestore/cloud_firestore.dart';

Future logIn(
  String name,
) async {
  final docUser = FirebaseFirestore.instance.collection('Login').doc();

  final json = {
    'name': name,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}

Future logOut(
  String name,
) async {
  final docUser = FirebaseFirestore.instance.collection('Logout').doc();

  final json = {
    'name': name,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
