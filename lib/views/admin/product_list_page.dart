import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';

import '../../services/data/menu_image_data.dart';
import '../../widgets/text_widget.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Products'),
      body: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Image.asset(
                            'assets/images/' + images[index],
                            height: 150,
                          ),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: ListTile(
                                  leading: TextBold(
                                      text: 'Price',
                                      fontSize: 14,
                                      color: Colors.black),
                                  trailing: TextBold(
                                      text: '200',
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: ListTile(
                                  leading: TextBold(
                                      text: 'Quantity',
                                      fontSize: 14,
                                      color: Colors.black),
                                  trailing: TextBold(
                                      text: '50pcs',
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: ListTile(
                                  leading: TextBold(
                                      text: 'Expiration Date',
                                      fontSize: 14,
                                      color: Colors.black),
                                  trailing: TextBold(
                                      text: '10-12-2022',
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ));
              },
              child: Image.asset(
                'assets/images/' + images[index],
              ),
            );
          }),
    );
  }
}
