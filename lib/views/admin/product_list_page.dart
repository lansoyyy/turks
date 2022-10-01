import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';

import '../../widgets/text_widget.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Products'),
      body: SizedBox(
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Products').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return GridView.builder(
                  itemCount: snapshot.data?.size ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => SizedBox(
                                  height: 500,
                                  child: AlertDialog(
                                    title: Image.network(
                                      data.docs[index]['url'],
                                      height: 150,
                                    ),
                                    content: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: ListTile(
                                            leading: TextBold(
                                                text: 'Price',
                                                fontSize: 14,
                                                color: Colors.black),
                                            trailing: TextBold(
                                                text: data.docs[index]['price'],
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: ListTile(
                                            leading: TextBold(
                                                text: 'Quantity',
                                                fontSize: 14,
                                                color: Colors.black),
                                            trailing: TextBold(
                                                text: data.docs[index]['qty'] +
                                                    'pcs',
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: ListTile(
                                            leading: TextBold(
                                                text: 'Expiration Date',
                                                fontSize: 14,
                                                color: Colors.black),
                                            trailing: TextBold(
                                                text: data.docs[index]
                                                    ['expireDate'],
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              fontFamily: 'QRegular',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      child: Image.network(
                        data.docs[index]['url'],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
