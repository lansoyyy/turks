import 'package:cloud_firestore/cloud_firestore.dart';

Future addReport(String name, String type, String date, String content,
    String imageURL, String username, String unit) async {
  final docUser = FirebaseFirestore.instance.collection('Waste Reports').doc();

  final json = {
    'myName': username,
    'name': name,
    'type': type,
    'date': date,
    'id': docUser.id,
    'content': content,
    'url': imageURL,
    'dateTime': DateTime.now(),
    'unit': unit
  };

  await docUser.set(json);
}
