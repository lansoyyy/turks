import 'package:cloud_firestore/cloud_firestore.dart';

Future addChat(
  String name,
  String date,
  String time,
  String message,
  String doc,
) async {
  final docUser = FirebaseFirestore.instance.collection('Chat').doc(doc);

  final json = {
    'name': name,
    'time': time,
    'message': message,
    'id': docUser.id,
    'doc': doc,
    'date': date
  };

  await docUser.set(json);
}
