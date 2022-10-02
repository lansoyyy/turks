import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';

class LogbookAdmin extends StatelessWidget {
  final doc = pw.Document();

  var name = [];
  var date = [];
  var time = [];

  void _loggedin() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Column(children: [
              pw.Center(child: pw.Text('Logged In')),
              pw.SizedBox(
                height: 20,
              ),
              for (int i = 0; i < name.length; i++)
                pw.Column(
                  children: [
                    pw.Text('\n Name: ' +
                        name[i] +
                        ', Date: ' +
                        date[i] +
                        ', Time: ' +
                        time[i]),
                  ],
                ),
            ]),
          );
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/turks_loggedin.pdf');
    await file.writeAsBytes(await doc.save());
  }

  var name1 = [];
  var date1 = [];
  var time1 = [];

  void _loggedOut() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Column(children: [
              pw.Center(child: pw.Text('Logged Out')),
              pw.SizedBox(
                height: 20,
              ),
              for (int i = 0; i < name1.length; i++)
                pw.Column(
                  children: [
                    pw.Text('\n Name: ' +
                        name1[i] +
                        ', Date: ' +
                        date1[i] +
                        ', Time: ' +
                        time1[i]),
                  ],
                ),
            ]),
          );
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/turks_loggedout.pdf');
    await file.writeAsBytes(await doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      TextBold(
                          text: 'Logged in', fontSize: 18, color: Colors.red),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Login')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              print('waiting');
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.blue,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
                            return Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                    itemCount: snapshot.data?.size ?? 0,
                                    itemBuilder: (context, index) {
                                      name.add(data.docs[index]['name']);
                                      date.add(data.docs[index]['date']);
                                      time.add(data.docs[index]['time']);
                                      return ListTile(
                                        trailing: TextRegular(
                                            text: data.docs[index]['date'],
                                            fontSize: 12,
                                            color: Colors.black),
                                        title: TextBold(
                                            text: data.docs[index]['name'],
                                            fontSize: 18,
                                            color: Colors.black),
                                      );
                                    }),
                              ),
                            );
                          }),
                      ButtonWidget(onPressed: _loggedin, text: 'Save'),
                      const SizedBox(
                        height: 10,
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
                          text: 'Logged out', fontSize: 18, color: Colors.red),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Logout')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              print('waiting');
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.blue,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
                            return Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                    itemCount: snapshot.data?.size ?? 0,
                                    itemBuilder: (context, index) {
                                      name1.add(data.docs[index]['name']);
                                      date1.add(data.docs[index]['date']);
                                      time1.add(data.docs[index]['time']);
                                      return ListTile(
                                        trailing: TextRegular(
                                            text: data.docs[index]['date'],
                                            fontSize: 12,
                                            color: Colors.black),
                                        title: TextBold(
                                            text: data.docs[index]['name'],
                                            fontSize: 18,
                                            color: Colors.black),
                                      );
                                    }),
                              ),
                            );
                          }),
                      ButtonWidget(onPressed: _loggedOut, text: 'Save'),
                      const SizedBox(
                        height: 10,
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
