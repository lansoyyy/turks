import 'package:flutter/material.dart';
import 'package:turks/widgets/button_widget.dart';

import '../../widgets/appbar_widget.dart';
import '../../widgets/text_widget.dart';

class InventoryTypeAdmin extends StatelessWidget {
  const InventoryTypeAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Ingeredients'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextBold(text: 'Item', fontSize: 18, color: Colors.black),
                TextBold(text: 'Quantity', fontSize: 18, color: Colors.black),
                TextBold(text: 'Unit', fontSize: 18, color: Colors.black),
              ],
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: TextRegular(
                            text: 'Beef', fontSize: 16, color: Colors.black),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: TextRegular(
                            text: '20', fontSize: 16, color: Colors.black),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: TextRegular(
                            text: 'KG', fontSize: 16, color: Colors.black),
                      ),
                    );
                  }),
                ),
              ),
            ),
            ButtonWidget(onPressed: () {}, text: 'Save'),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
