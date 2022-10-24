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
        body: GridView.builder(
            itemCount: 23,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // box.write('productPrice', data.docs[index]['price']);
                  // box.write('productURL', data.docs[index]['url']);
                  // box.write('productQty', data.docs[index]['qty']);
                  // box.write('productId', data.docs[index]['id']);
                  // box.write(
                  //     'productExDate', data.docs[index]['expireDate']);

                  box.write('index', index);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductPage()));
                },
                child: Image.asset(
                  'assets/images/menu/$index.png',
                ),
              );
            }));
  }
}
