import 'package:flutter/material.dart';
import 'package:turks/services/data/menu_image_data.dart';
import 'package:turks/widgets/appbar_widget.dart';

import '../../widgets/text_widget.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Products'),
      body: SizedBox(
          child: GridView.builder(
              itemCount: 23,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => SizedBox(
                              height: 500,
                              child: AlertDialog(
                                title: Image.asset(
                                  'assets/images/menu/$index.png',
                                  height: 150,
                                ),
                                content: Column(
                                  children: [
                                    TextBold(
                                        text: names[index],
                                        fontSize: 18,
                                        color: Colors.black),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: ListTile(
                                        leading: TextBold(
                                            text: 'Price',
                                            fontSize: 14,
                                            color: Colors.black),
                                        trailing: TextBold(
                                            text: prices[index],
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: ListTile(
                                        leading: TextBold(
                                            text: 'Expiration Date',
                                            fontSize: 14,
                                            color: Colors.black),
                                        trailing: TextBold(
                                            text: '10/23/2023',
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  child: Image.asset(
                    'assets/images/menu/$index.png',
                  ),
                );
              })),
    );
  }
}
