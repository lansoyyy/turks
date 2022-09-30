import 'package:cloud_firestore/cloud_firestore.dart';

Future addReport(
  String name,
  String type,
  String date,
  String content,
) async {
  final docUser = FirebaseFirestore.instance.collection('Waste Reports').doc();

  final json = {
    'name': name,
    'type': type,
    'date': date,
    'id': docUser.id,
    'content': content
  };

  await docUser.set(json);
}
