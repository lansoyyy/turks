import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class WasteReportPage extends StatelessWidget {
  const WasteReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Waste Reports'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            width: 2,
            color: Colors.black,
          )),
          child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: GestureDetector(
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Updating Report',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: TextFormField(
                              maxLines: 3,
                              onChanged: (_input) {},
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
                              FlatButton(
                                color: Colors.black,
                                onPressed: () {
                                  // Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => LogInPage()));
                                },
                                child: const Text(
                                  'Update',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'QRegular',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ));
                },
                child: ExpansionTile(
                  children: [
                    TextRegular(
                        text: 'Lopsum Ipsum',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                  title: TextBold(
                      text: 'Report $index', fontSize: 18, color: Colors.black),
                  trailing: TextRegular(
                      text: 'August 03, 2022',
                      fontSize: 12,
                      color: Colors.black),
                  subtitle: TextRegular(
                      text: 'Lance Olana', fontSize: 12, color: Colors.black),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
