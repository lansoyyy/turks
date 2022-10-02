import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class ProductPage extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget('Product'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
              box.read('productURL'),
              height: 250,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: ListTile(
              leading:
                  TextBold(text: 'Price', fontSize: 18, color: Colors.black),
              trailing: TextBold(
                  text: box.read('productPrice'),
                  fontSize: 18,
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: ListTile(
              leading:
                  TextBold(text: 'Quantity', fontSize: 18, color: Colors.black),
              trailing: TextBold(
                  text: box.read('productQty'),
                  fontSize: 18,
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: ListTile(
              leading: TextBold(
                  text: 'Expiration Date', fontSize: 18, color: Colors.black),
              trailing: TextBold(
                  text: box.read('productExDate'),
                  fontSize: 18,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
