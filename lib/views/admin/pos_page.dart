import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class POSPage extends StatelessWidget {
  const POSPage({Key? key}) : super(key: key);

  String getTotal(int num1, int num2) {
    return "${num1 * num2}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppbarWidget('Sales'),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Sales').snapshots(),
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
                return SizedBox(
                  height: 350,
                  child: Scrollbar(
                    child: ListView.builder(
                        itemCount: snapshot.data?.size ?? 0,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBold(
                                    text: data.docs[index]['item'] +
                                        ' - ' +
                                        data.docs[index]['price'],
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Item-Price',
                                    fontSize: 12,
                                    color: Colors.grey),
                              ],
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextBold(
                                  text: data.docs[index]['qty'],
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextRegular(
                                  text: 'Quantity',
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBold(
                                    text: getTotal(
                                        int.parse(data.docs[index]['qty']),
                                        int.parse(data.docs[index]['price'])),
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Total',
                                    fontSize: 12,
                                    color: Colors.grey),
                              ],
                            ),
                          );
                        })),
                  ),
                );
              }),
          const SizedBox(
            height: 30,
          ),
          const Expanded(
            child: SizedBox(
              height: 30,
            ),
          ),
          //ButtonWidget(onPressed: () {}, text: 'Save'),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
