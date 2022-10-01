import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/utils/colors.dart';
import 'package:turks/views/chatroom_page.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Notifications'),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: StreamBuilder<QuerySnapshot>(
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
                    return ListView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatRoom()));
                            },
                            tileColor: Colors.white,
                            leading: const Icon(
                              Icons.mail,
                              color: secondaryColor,
                              size: 38,
                            ),
                            title: TextBold(
                                text: 'From: ' + data.docs[index]['name'],
                                fontSize: 18,
                                color: Colors.black),
                            trailing: TextRegular(
                                text: data.docs[index]['date'],
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        );
                      }),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
