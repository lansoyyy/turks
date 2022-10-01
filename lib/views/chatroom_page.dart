import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/services/cloud_function/add_chat.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class ChatRoom extends StatefulWidget {
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final box = GetStorage();

  late String name = '';

  getData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: box.read('username'));

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          name = data['name'];
        }
      });
    }
  }

  late String message;

  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppbarWidget('Chat Room'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Chat')
                    .orderBy('doc')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('error');
                    return const Center(child: Text('Error'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print('waiting');
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.blue,
                      )),
                    );
                  }

                  final data = snapshot.requireData;
                  return Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                          itemCount: snapshot.data?.size ?? 0,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 150,
                                width: 250,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              'assets/images/profile.png',
                                              height: 50,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            TextBold(
                                                text: data.docs[index]['name'],
                                                fontSize: 18,
                                                color: Colors.black),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextRegular(
                                            text: data.docs[index]['message'],
                                            fontSize: 12,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextRegular(
                                                text: data.docs[index]['time'],
                                                fontSize: 10,
                                                color: Colors.grey),
                                            TextRegular(
                                                text: data.docs[index]['date'],
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                    ),
                  );
                }),
            ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  controller: _messageController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        var dt = DateTime.now();

                        if (_messageController.text != '') {
                          addChat(
                              name,
                              dt.month.toString() +
                                  '/' +
                                  dt.day.toString() +
                                  '/' +
                                  dt.year.toString(),
                              dt.hour.toString() + ':' + dt.minute.toString(),
                              _messageController.text,
                              dt.hour.toString() +
                                  dt.minute.toString() +
                                  dt.second.toString());
                          _messageController.clear();
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                    hintText: 'Type message',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
