import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class InventoryTypeAdmin extends StatefulWidget {
  @override
  State<InventoryTypeAdmin> createState() => _InventoryTypeAdminState();
}

class _InventoryTypeAdminState extends State<InventoryTypeAdmin> {
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

  var items = [];
  var qty = [];
  var unit = [];
  var myNames = [];

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  void _createPdf() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    // doc.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Container(
    //         margin: const pw.EdgeInsets.all(20),
    //         child: pw.Column(children: [
    //           pw.Center(child: pw.Text('Inventory')),
    //           pw.SizedBox(
    //             height: 20,
    //           ),
    //           for (int i = 0; i < items.length; i++)
    //             pw.Column(
    //               children: [
    //                 pw.Text('\n Item: ' +
    //                     items[i] +
    //                     ', Quantity: ' +
    //                     qty[i] +
    //                     ', Unit: ' +
    //                     unit[i]),
    //               ],
    //             ),
    //         ]),
    //       );
    //     },
    //   ),
    // ); // Page

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
            pw.SizedBox(height: 5),
            pw.Text(cdate2),
            pw.SizedBox(height: 20),
            pw.Text('Inventory - ${box.read('invenType')}'),
            pw.SizedBox(height: 30),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Text('Crew'),
                    pw.Text('Item'),
                    pw.Text('Quantity'),
                    pw.Text('Unit'),
                  ],
                ),
                for (int i = 0; i < items.length; i++)
                  pw.TableRow(
                    children: [
                      pw.Text(myNames[i]),
                      pw.Text(items[i]),
                      pw.Text(qty[i]),
                      pw.Text(unit[i]),
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

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/turks_inventory.pdf');
    await file.writeAsBytes(await doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(box.read('invenType')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextBold(text: 'Item', fontSize: 18, color: Colors.black),
                TextBold(text: 'Quantity', fontSize: 18, color: Colors.black),
                TextBold(text: 'Unit', fontSize: 18, color: Colors.black),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Inventory')
                    .where('type', isEqualTo: box.read('invenType'))
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
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          items.add(data.docs[index]['item']);
                          myNames.add(data.docs[index]['myName']);
                          qty.add(data.docs[index]['qty']);
                          unit.add(data.docs[index]['unit']);
                          return DataTable(
                              border: TableBorder.all(color: Colors.grey),
                              columns: [
                                DataColumn(
                                  label: TextBold(
                                      text: 'Item',
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                DataColumn(
                                  label: TextBold(
                                      text: 'Quantity',
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                DataColumn(
                                  label: TextBold(
                                      text: 'Unit',
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ],
                              rows: [
                                for (int i = 0; i < snapshot.data!.size; i++)
                                  DataRow(cells: [
                                    DataCell(
                                      TextRegular(
                                          text: data.docs[index]['item'],
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    DataCell(
                                      TextRegular(
                                          text: data.docs[index]['qty'],
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    DataCell(
                                      TextRegular(
                                          text: data.docs[index]['unit'],
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ])
                              ]);
                        }),
                      ),
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
    );
  }
}
