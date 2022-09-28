import 'package:flutter/material.dart';
import 'package:turks/services/data/menu_image_data.dart';
import 'package:turks/views/crew/notif_page.dart';
import 'package:turks/views/crew/product_page.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class CrewHome extends StatelessWidget {
  const CrewHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextRegular(text: 'Products', fontSize: 18, color: Colors.black),
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
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProductPage()));
              },
              child: Image.asset(
                'assets/images/' + images[index],
              ),
            );
          }),
    );
  }
}
