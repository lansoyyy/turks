import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class ProductPageAdmin extends StatefulWidget {
  @override
  State<ProductPageAdmin> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPageAdmin> {
  final box = GetStorage();

  late String item;

  int qty = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(box.read('productName')),
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
                  text: box.read('productPrice').toString(),
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
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
