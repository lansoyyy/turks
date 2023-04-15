import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../widgets/button_widget.dart';

class WasteReportPageAdmin extends StatefulWidget {
  const WasteReportPageAdmin({Key? key}) : super(key: key);

  @override
  State<WasteReportPageAdmin> createState() => _WasteReportPageAdminState();
}

class _WasteReportPageAdminState extends State<WasteReportPageAdmin> {
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

  var type = [];

  var date = [];

  var content = [];
  var myNames = [];
  var unit = [];

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  void _createPdf() async {
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
            pw.Text('Waste Reports'),
            pw.SizedBox(height: 30),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Text('Crew'),
                    pw.Text('Concern'),
                    pw.Text('Unit'),
                    pw.Text('Report Type'),
                    pw.Text('Date'),
                    pw.Text('Content'),
                  ],
                ),
                for (int i = 0; i < name.length; i++)
                  pw.TableRow(
                    children: [
                      pw.Text(myNames[i]),
                      pw.Text(name[i]),
                      pw.Text(unit[i]),
                      pw.Text(type[i]),
                      pw.Text(date[i]),
                      pw.Text(content[i]),
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
    final file = File('${output.path}/turks_reports.pdf');
    await file.writeAsBytes(await doc.save());
  }

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
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Waste Reports')
                      .orderBy('dateTime')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print('error');
                      return const Center(child: Text('Error'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                              name.add(data.docs[index]['name']);
                              type.add(data.docs[index]['type']);
                              date.add(formattedTime);
                              myNames.add(data.docs[index]['myName']);
                              unit.add(data.docs[index]['unit']);
                              content.add(data.docs[index]['content']);
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: ExpansionTile(
                                  children: [
                                    TextRegular(
                                        text: data.docs[index]['content'],
                                        fontSize: 12,
                                        color: Colors.black),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Image.network(
                                      data.docs[index]['url'],
                                      height: 100,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                  title: TextBold(
                                      text: data.docs[index]['type'],
                                      fontSize: 18,
                                      color: Colors.black),
                                  trailing: TextRegular(
                                      text: formattedTime,
                                      fontSize: 12,
                                      color: Colors.black),
                                  subtitle: TextRegular(
                                      text: data.docs[index]['name'],
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                              );
                            }),
                      ),
                    );
                  }),
              ButtonWidget(onPressed: _createPdf, text: 'Save'),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
