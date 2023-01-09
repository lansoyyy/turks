import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        build: ((context) {
          return pw.Column(children: [
            pw.SizedBox(height: 20),
            pw.Text('Logged In'),
            pw.SizedBox(height: 30),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Text('Name'),
                    pw.Text('Date'),
                    pw.Text('Time'),
                  ],
                ),
                for (int i = 0; i < name.length; i++)
                  pw.TableRow(
                    children: [
                      pw.Text(name[i]),
                      pw.Text(date[i]),
                      pw.Text(time[i]),
                    ],
                  ),
              ],
            )
          ]);
        }),
        pageFormat: PdfPageFormat.a4,
      ),
    );

    /// Page

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
        build: ((context) {
          return pw.Column(children: [
            pw.SizedBox(height: 20),
            pw.Text('Logged Out'),
            pw.SizedBox(height: 30),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Text('Name'),
                    pw.Text('Date'),
                    pw.Text('Time'),
                  ],
                ),
                for (int i = 0; i < name1.length; i++)
                  pw.TableRow(
                    children: [
                      pw.Text(name1[i]),
                      pw.Text(date1[i]),
                      pw.Text(time1[i]),
                    ],
                  ),
              ],
            )
          ]);
        }),
        pageFormat: PdfPageFormat.a4,
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
                              .orderBy('dateTime')
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
                                      DateTime created =
                                          data.docs[index]['dateTime'].toDate();

                                      String formattedTime =
                                          DateFormat.yMMMd().format(created);
                                      String formattedTime1 =
                                          DateFormat.j().format(created);
                                      name.add(data.docs[index]['name']);
                                      date.add(formattedTime);
                                      time.add(formattedTime1);
                                      return ListTile(
                                        trailing: TextRegular(
                                            text: formattedTime,
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
                              .orderBy('dateTime')
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
                                      DateTime created =
                                          data.docs[index]['dateTime'].toDate();

                                      String formattedTime =
                                          DateFormat.yMMMd().format(created);
                                      String formattedTime1 =
                                          DateFormat.j().format(created);
                                      name1.add(data.docs[index]['name']);
                                      date1.add(formattedTime);
                                      time1.add(formattedTime1);
                                      return ListTile(
                                        trailing: TextRegular(
                                            text: formattedTime,
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
