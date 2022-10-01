import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class WasteReportPageAdmin extends StatelessWidget {
  const WasteReportPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Waste Reports'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            width: 2,
            color: Colors.black,
          )),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Waste Reports')
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
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ExpansionTile(
                          children: [
                            TextRegular(
                                text: data.docs[index]['content'],
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                          title: TextBold(
                              text: data.docs[index]['type'],
                              fontSize: 18,
                              color: Colors.black),
                          trailing: TextRegular(
                              text: data.docs[index]['date'],
                              fontSize: 12,
                              color: Colors.black),
                          subtitle: TextRegular(
                              text: data.docs[index]['name'],
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
