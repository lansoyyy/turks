import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turks/services/cloud_function/add_report.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class WasteReportPage extends StatefulWidget {
  @override
  State<WasteReportPage> createState() => _WasteReportPageState();
}

class _WasteReportPageState extends State<WasteReportPage> {
  var hasLoaded = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Reports/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Reports/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
        });

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uploaded Successfully!'),
          ),
        );
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  late String name;

  late String type;

  late String date;

  late String content;

  late String updatedReport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Waste Reports'),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 2,
                    color: Colors.black,
                  )),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Waste Reports')
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
                        return ListView.builder(
                            itemCount: snapshot.data?.size ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                'Updating Report',
                                                style: TextStyle(
                                                    fontFamily: 'QBold',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: TextFormField(
                                                maxLines: 3,
                                                onChanged: (_input) {
                                                  updatedReport = _input;
                                                },
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: const Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        fontFamily: 'QRegular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                FlatButton(
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Waste Reports')
                                                        .doc(
                                                            data.docs[index].id)
                                                        .update({
                                                      'content': updatedReport,
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Update',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'QRegular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: ExpansionTile(
                                    children: [
                                      TextRegular(
                                          text: data.docs[index]['content'],
                                          fontSize: 12,
                                          color: Colors.black),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Image.network(data.docs[index]['url'],
                                          height: 100),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                    title: TextBold(
                                        text: data.docs[index]['type'],
                                        fontSize: 18,
                                        color: Colors.black),
                                    trailing: TextRegular(
                                        text: data.docs[index]['date'],
                                        fontSize: 12,
                                        color: Colors.black),
                                    subtitle: TextRegular(
                                        text: data.docs[index]['name'],
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
            ),
          ),
          ButtonWidget(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Adding to Inventory',
                            style: TextStyle(
                                fontFamily: 'QBold',
                                fontWeight: FontWeight.bold),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: TextRegular(
                                        text: 'Name',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  onChanged: (_input) {
                                    name = _input;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: TextRegular(
                                        text: 'Report Type',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  onChanged: (_input) {
                                    type = _input;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: TextRegular(
                                        text: 'Date Reported',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  onChanged: (_input) {
                                    date = _input;
                                  },
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    label: TextRegular(
                                        text: 'Content of Report',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  onChanged: (_input) {
                                    content = _input;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                hasLoaded
                                    ? GestureDetector(
                                        onTap: () {
                                          uploadPicture('gallery');
                                        },
                                        child: SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Image.network(
                                            imageURL,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          uploadPicture('gallery');
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          color: Colors.black,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.add,
                                                  size: 32,
                                                  color: Colors.white),
                                              const SizedBox(height: 20),
                                              TextBold(
                                                  text: 'Add Photo',
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.black,
                              onPressed: () {
                                addReport(name, type, date, content, imageURL);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ));
              },
              text: 'Add Report'),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
