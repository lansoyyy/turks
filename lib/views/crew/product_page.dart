import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/cloud_function/add_sales.dart';
import '../../widgets/button_widget.dart';

class ProductPage extends StatelessWidget {
  final box = GetStorage();

  late String item;

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
          const Expanded(child: SizedBox()),
          ButtonWidget(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Adding to Sales',
                            style: TextStyle(
                                fontFamily: 'QBold',
                                fontWeight: FontWeight.bold),
                          ),
                          content: SizedBox(
                            height: 300,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: TextRegular(
                                        text: 'Product Name',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  onChanged: (_input) {
                                    item = _input;
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.black,
                              onPressed: () {
                                addSales(item, box.read('productPrice'),
                                    box.read('productQty'));
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ));
              },
              text: 'Add Sales'),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
