import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Inventory'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryType()));
                },
                text: 'Ingeredients'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryType()));
                },
                text: 'Drinks'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryType()));
                },
                text: 'Bags'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryType()));
                },
                text: 'Cups'),
          ],
        ),
      ),
    );
  }
}

class InventoryType extends StatelessWidget {
  const InventoryType({Key? key}) : super(key: key);

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
                TextBold(text: 'Ex Date', fontSize: 18, color: Colors.black),
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
                            text: '10-12-2022',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
