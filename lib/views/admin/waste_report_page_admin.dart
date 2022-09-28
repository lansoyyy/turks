import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class WasteReportPageAdmin extends StatelessWidget {
  const WasteReportPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ExpansionTile(
                children: [
                  TextRegular(
                      text: 'Lopsum Ipsum', fontSize: 12, color: Colors.black),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                title: TextBold(
                    text: 'Report $index', fontSize: 18, color: Colors.black),
                trailing: TextRegular(
                    text: 'August 03, 2022', fontSize: 12, color: Colors.black),
                subtitle: TextRegular(
                    text: 'Lance Olana', fontSize: 12, color: Colors.black),
              ),
            );
          }),
        ),
      ),
    );
  }
}
