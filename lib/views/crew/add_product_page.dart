import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turks/services/cloud_function/post_product.dart';
import 'package:turks/views/crew/crew_home.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
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
            .ref('Products/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Products/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
        });

        Navigator.of(context).pop();
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

  late String price;
  late String qty;
  late String expireData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Adding Product'),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 20,
          ),
          hasLoaded
              ? Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    color: Colors.black,
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Center(
                  child: GestureDetector(
                    onTap: () {
                      uploadPicture('gallery');
                    },
                    child: Container(
                      height: 250,
                      width: 250,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextBold(
                              text: 'Upload Image',
                              fontSize: 12,
                              color: Colors.grey)
                        ],
                      ),
                    ),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (_input) {
                price = _input;
              },
              decoration: InputDecoration(
                label: TextRegular(
                    text: 'Product Name', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (_input) {
                price = _input;
              },
              decoration: InputDecoration(
                label: TextRegular(
                    text: 'Price', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (_input) {
                qty = _input;
              },
              decoration: InputDecoration(
                label: TextRegular(
                    text: 'Quantity', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 50),
            child: TextFormField(
              onChanged: (_input) {
                expireData = _input;
              },
              decoration: InputDecoration(
                label: TextRegular(
                    text: 'Expiration Date (Ex. 10/22/2022)',
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
          ),
          ButtonWidget(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                          content: const Text(
                            'Added Succesfully!',
                            style: TextStyle(fontFamily: 'QRegular'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                postProduct(imageURL, price, qty, expireData);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => CrewHome()));
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ));
              },
              text: 'Add Product'),
        ]),
      ),
    );
  }
}
