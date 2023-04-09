import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../widgets/button_widget.dart';

class POSPage extends StatefulWidget {
  const POSPage({super.key});

  @override
  State<POSPage> createState() => _POSPageState();
}

class _POSPageState extends State<POSPage> {
  @override
  void initState() {
    super.initState();
    getData();
    getTotal1();
  }

  getTotal1() {
    FirebaseFirestore.instance
        .collection('Sales')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          prices.add(int.parse(getTotal(int.parse(doc['price']), doc['qty'])));
        });
      }
    });
  }

  final box = GetStorage();

  late String myName = '';

  List<int> prices = [];

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

  String getTotal(int num1, int num2) {
    return "${num1 * num2}";
  }

  final doc = pw.Document();

  var items = [];

  var qty = [];

  var price = [];
  var myNames = [];

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  void _createPdf() async {
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
            pw.SizedBox(height: 5),
            pw.Text(cdate2),
            pw.SizedBox(height: 20),
            pw.Text('Sales'),
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
                    pw.Text('Price'),
                  ],
                ),
                for (int i = 0; i < items.length; i++)
                  pw.TableRow(
                    children: [
                      pw.Text(myNames[i]),
                      pw.Text(items[i]),
                      pw.Text(qty[i]),
                      pw.Text(price[i]),
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
    final file = File('${output.path}/turks_pos.pdf');
    await file.writeAsBytes(await doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppbarWidget('Sales'),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Sales')
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
                return SizedBox(
                  height: 350,
                  child: Scrollbar(
                    child: ListView.builder(
                        itemCount: data.size == 0 ? 0 : 1,
                        itemBuilder: ((context, index) {
                          items.add(data.docs[index]['item']);
                          myNames.add(data.docs[index]['myName']);
                          qty.add(data.docs[index]['qty'].toString());
                          price.add(data.docs[index]['price']);
                          return DataTable(
                              border: TableBorder.all(color: Colors.grey),
                              columns: [
                                DataColumn(
                                  label: TextBold(
                                      text: 'Item - Price',
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
                                      text: 'Total',
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ],
                              rows: [
                                for (int i = 0; i < snapshot.data!.size; i++)
                                  DataRow(cells: [
                                    DataCell(
                                      TextRegular(
                                          text: data.docs[i]['item'] +
                                              ' ' +
                                              data.docs[i]['price'],
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    DataCell(
                                      TextRegular(
                                          text: data.docs[i]['qty'].toString(),
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                    DataCell(
                                      TextRegular(
                                          text: getTotal(
                                              int.parse(data.docs[i]['price']),
                                              data.docs[i]['qty']),
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ])
                              ]);
                        })),
                  ),
                );
              }),
          const SizedBox(
            height: 30,
          ),
          TextBold(
              text:
                  'Total Sales:     ₱${prices.reduce((sum, price) => sum + price)}',
              fontSize: 18,
              color: Colors.black),
          const SizedBox(
            height: 20,
          ),
          const Expanded(
            child: SizedBox(
              height: 30,
            ),
          ),
          ButtonWidget(onPressed: _createPdf, text: 'Save'),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
