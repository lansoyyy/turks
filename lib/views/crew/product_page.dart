import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget('Rice Bowl'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/rice-bowl (2.6).png',
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
              trailing: TextBold(text: '200', fontSize: 18, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: ListTile(
              leading: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  TextBold(text: 'Quantity', fontSize: 18, color: Colors.black),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              trailing: SizedBox(
                height: 50,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.remove)),
                    TextBold(text: '50pcs', fontSize: 18, color: Colors.grey),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: ListTile(
              leading: TextBold(
                  text: 'Expiration Date', fontSize: 18, color: Colors.black),
              trailing: TextBold(
                  text: '10-12-2022', fontSize: 18, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
