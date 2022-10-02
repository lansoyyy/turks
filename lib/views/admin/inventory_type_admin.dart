import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  final box = GetStorage();

  final doc = pw.Document();

  var items = [];
  var qty = [];
  var unit = [];

  void _createPdf() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Column(children: [
              pw.Center(child: pw.Text('Inventory')),
              pw.SizedBox(
                height: 20,
              ),
              for (int i = 0; i < items.length; i++)
                pw.Column(
                  children: [
                    pw.Text('\n Item: ' +
                        items[i] +
                        ', Quantity: ' +
                        qty[i] +
                        ', Unit: ' +
                        unit[i]),
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
                        itemBuilder: ((context, index) {
                          items.add(data.docs[index]['item']);
                          qty.add(data.docs[index]['qty']);
                          unit.add(data.docs[index]['unit']);
                          return ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: TextRegular(
                                  text: data.docs[index]['item'],
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextRegular(
                                  text: data.docs[index]['qty'],
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: TextRegular(
                                  text: data.docs[index]['unit'],
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          );
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
