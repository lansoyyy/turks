import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class LogbookAdmin extends StatelessWidget {
  const LogbookAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Logbook'),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: TextBold(
                          text: 'Lance Olana',
                          fontSize: 18,
                          color: Colors.black),
                      subtitle: TextRegular(
                          text: 'Crew', fontSize: 12, color: Colors.grey),
                      trailing: SizedBox(
                        height: 50,
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextBold(
                                    text: 'Login Time',
                                    fontSize: 10,
                                    color: Colors.black),
                                TextRegular(
                                    text: '6am',
                                    fontSize: 12,
                                    color: Colors.black),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextBold(
                                    text: 'Logout Time',
                                    fontSize: 10,
                                    color: Colors.black),
                                TextRegular(
                                    text: '6pm',
                                    fontSize: 12,
                                    color: Colors.black),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          ),
          ButtonWidget(onPressed: () {}, text: 'Save'),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
