import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';

class LogbookAdmin extends StatefulWidget {
  const LogbookAdmin({Key? key}) : super(key: key);

  @override
  State<LogbookAdmin> createState() => _LogbookAdminState();
}

class _LogbookAdminState extends State<LogbookAdmin> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final box = GetStorage();

  late String myName = '';

  getData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: box.read('username'));

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          myName = data['name'];
        }
      });
    }
  }

  final doc = pw.Document();

  var name = [];

  var date = [];

  var time = [];

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  void _loggedin() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    final image = await imageFromAssetBundle('assets/images/TURKS PNG.png');

    doc.addPage(
      pw.Page(
        build: ((context) {
          return pw.Column(children: [
            pw.Center(
              child: pw.Image(image, height: 120, width: 120),
            ),
            pw.SizedBox(height: 5),
            pw.Text('Sayre Hwy, Malaybalay, 8700 Bukidnon'),
            pw.SizedBox(height: 5),
            pw.Text(cdate2),
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
            ),
            pw.SizedBox(height: 75),
            pw.Align(
              alignment: pw.Alignment.bottomRight,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(myName,
                      style: const pw.TextStyle(
                          decoration: pw.TextDecoration.underline)),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'ADMIN',
                  ),
                ],
              ),
            ),
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

    final image = await imageFromAssetBundle(
      'assets/images/T turks logo.png',
    );

    doc.addPage(
      pw.Page(
        build: ((context) {
          return pw.Column(children: [
            pw.Center(
              child: pw.Image(image, height: 120, width: 120),
            ),
            pw.SizedBox(height: 5),
            pw.Text('Sayre Hwy, Malaybalay, 8700 Bukidnon'),
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
                                          DateFormat('MMM/d/yyy - hh:mm a')
                                              .format(created);
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
                                          DateFormat('MMM/d/yyy - hh:mm a')
                                              .format(created);
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
