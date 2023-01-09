import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../widgets/button_widget.dart';

class POSPage extends StatelessWidget {
  String getTotal(int num1, int num2) {
    return "${num1 * num2}";
  }

  final doc = pw.Document();

  var items = [];
  var qty = [];
  var price = [];

  void _createPdf() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        build: ((context) {
          return pw.Column(children: [
            pw.SizedBox(height: 20),
            pw.Text('Sales'),
            pw.SizedBox(height: 30),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Text('Item'),
                    pw.Text('Quantity'),
                    pw.Text('Price'),
                  ],
                ),
                for (int i = 0; i < items.length; i++)
                  pw.TableRow(
                    children: [
                      pw.Text(items[i]),
                      pw.Text(qty[i]),
                      pw.Text(price[i]),
                    ],
                  ),
              ],
            )
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
                        itemCount: snapshot.data?.size ?? 0,
                        itemBuilder: ((context, index) {
                          items.add(data.docs[index]['item']);
                          qty.add(data.docs[index]['qty']);
                          price.add(data.docs[index]['price']);
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBold(
                                    text: data.docs[index]['item'] +
                                        ' - ' +
                                        data.docs[index]['price'],
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Item-Price',
                                    fontSize: 12,
                                    color: Colors.grey),
                              ],
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextBold(
                                  text: data.docs[index]['qty'],
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextRegular(
                                  text: 'Quantity',
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBold(
                                    text: getTotal(
                                        int.parse(data.docs[index]['qty']),
                                        int.parse(data.docs[index]['price'])),
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Total',
                                    fontSize: 12,
                                    color: Colors.grey),
                              ],
                            ),
                          );
                        })),
                  ),
                );
              }),
          const SizedBox(
            height: 30,
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
