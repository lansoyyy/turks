import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/views/crew/notif_page.dart';
import 'package:turks/views/crew/product_page.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class CrewHome extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
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
              icon: const Icon(Icons.notifications),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Products').snapshots(),
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
                  itemCount: snapshot.data?.size ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        box.write('productPrice', data.docs[index]['price']);
                        box.write('productURL', data.docs[index]['url']);
                        box.write('productQty', data.docs[index]['qty']);

                        box.write(
                            'productExDate', data.docs[index]['expireDate']);
                        box.write(
                            'productName', data.docs[index]['productName']);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductPage()));
                      },
                      child: Image.network(
                        data.docs[index]['url'],
                      ),
                    );
                  });
            }));
  }
}
