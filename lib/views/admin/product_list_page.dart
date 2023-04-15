import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/views/admin/product_page_admin.dart';
import 'package:turks/views/crew/add_product_page.dart';
import 'package:turks/views/crew/notif_page.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final box = GetStorage();

  int dropValue = 0;
  String type = 'Food';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AddProductPage()));
            }),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title:
              TextRegular(text: 'Products', fontSize: 18, color: Colors.black),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const NotifPage()));
              },
              icon: Badge(
                  label: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Chat')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print('error');
                          return const Center(child: Text('Error'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print('waiting');
                          return const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                          );
                        }
                        final data = snapshot.requireData;
                        return TextRegular(
                            text: data.docs.length.toString(),
                            fontSize: 12,
                            color: Colors.white);
                      }),
                  child: const Icon(Icons.notifications)),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                child: SizedBox(
                  width: 250,
                  child: DropdownButton(
                      value: dropValue,
                      items: [
                        DropdownMenuItem(
                          onTap: () {
                            setState(() {
                              type = 'Food';
                            });
                          },
                          value: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 150),
                            child: TextRegular(
                                text: 'Food',
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            setState(() {
                              type = 'Drink';
                            });
                          },
                          value: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: TextRegular(
                                text: 'Drink',
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropValue = int.parse(value.toString());
                        });
                      }),
                )),
            Expanded(
              child: SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .where('type', isEqualTo: type)
                        .orderBy('dateTime')
                        .snapshots(),
                    builder: (context, snapshot) {
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
                            color: Colors.black,
                          )),
                        );
                      }
                      final data = snapshot.requireData;
                      return GridView.builder(
                          itemCount: data.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                box.write(
                                    'productPrice', data.docs[index]['price']);
                                box.write(
                                    'productURL', data.docs[index]['url']);
                                // box.write('productQty', data.docs[index]['qty']);

                                box.write('productExDate',
                                    data.docs[index]['expireDate']);
                                box.write('productName',
                                    data.docs[index]['productName']);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductPageAdmin()));
                              },
                              child: Image.network(
                                data.docs[index]['url'],
                              ),
                            );
                          });
                    }),
              ),
            ),
          ],
        ));
  }
}
