import 'package:cloud_firestore/cloud_firestore.dart';

Future logIn(
  String name,
  String date,
  String time,
) async {
  final docUser = FirebaseFirestore.instance.collection('Login').doc();

  final json = {
    'name': name,
    'date': date,
    'time': time,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}

Future logOut(
  String name,
  String date,
  String time,
) async {
  final docUser = FirebaseFirestore.instance.collection('Logout').doc();

  final json = {
    'name': name,
    'date': date,
    'time': time,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
