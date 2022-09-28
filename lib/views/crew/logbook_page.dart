import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class LogbookPage extends StatelessWidget {
  const LogbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Logbook'),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 2,
                    color: Colors.black,
                  )),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextBold(text: 'Log-in', fontSize: 18, color: Colors.red),
                      Expanded(
                        child: SizedBox(
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            return ListTile(
                              trailing: TextRegular(
                                  text: 'August 03, 2022',
                                  fontSize: 12,
                                  color: Colors.black),
                              title: TextBold(
                                  text: 'Lance Olana',
                                  fontSize: 18,
                                  color: Colors.black),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 2,
                    color: Colors.black,
                  )),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextBold(
                          text: 'Log-out', fontSize: 18, color: Colors.red),
                      Expanded(
                        child: SizedBox(
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            return ListTile(
                              trailing: TextRegular(
                                  text: 'August 03, 2022',
                                  fontSize: 12,
                                  color: Colors.black),
                              title: TextBold(
                                  text: 'Lance Olana',
                                  fontSize: 18,
                                  color: Colors.black),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
