import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turks/services/cloud_function/logbook.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/drawer_widget.dart';
import 'package:turks/widgets/text_widget.dart';

class LogbookPage extends StatefulWidget {
  @override
  State<LogbookPage> createState() => _LogbookPageState();
}

class _LogbookPageState extends State<LogbookPage> {
  late String name;

  late String date;

  late String time;

  late String name1;

  late String date1;

  late String time1;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    getLocation();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  String currentAddress = 'My Address';
  late Position currentposition;

  final String _currentAddress = '';

  final String _startAddress = '';

  late Position _currentPosition;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  late double lat = 0;
  late double long = 0;

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
    print('lat - $lat');
    print('long - $long');
  }

  // _getAddress() async {
  //   try {
  //     List<Placemark> p = await placemarkFromCoordinates(lat, long);

  //     Placemark place = p[0];

  //     setState(() {
  //       _currentAddress =
  //           "${place.locality}, ${place.country}, ${place.administrativeArea}";
  //       startAddressController.text = _currentAddress;
  //       _startAddress = _currentAddress;
  //     });

  //     print(_startAddress);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBold(
                                text: 'Log-in',
                                fontSize: 18,
                                color: Colors.red),
                            TextButton(
                              onPressed: () async {
                                LocationPermission permission;

                                permission =
                                    await Geolocator.requestPermission();
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);

                                bool serviceEnabled;

                                List<Placemark> p =
                                    await placemarkFromCoordinates(
                                        position.latitude, position.longitude);

                                Placemark place = p[0];

                                print(
                                    "${place.locality}, ${place.thoroughfare}, ${place.street}");

                                String myLoc =
                                    "${place.locality}, ${place.thoroughfare}, ${place.street}";

                                // Test if location services are enabled.
                                serviceEnabled =
                                    await Geolocator.isLocationServiceEnabled();

                                if (!serviceEnabled) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: TextBold(
                                                text: 'Cannot Procceed',
                                                color: Colors.black,
                                                fontSize: 14),
                                            content: TextRegular(
                                                text:
                                                    'Location is not turned on',
                                                color: Colors.black,
                                                fontSize: 12),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: TextBold(
                                                    text: 'Close',
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ));
                                } else {
                                  if (myLoc ==
                                      'Malaybalay, Sayre Highway, Gaisano Building') {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                'Logging in',
                                                style: TextStyle(
                                                    fontFamily: 'QBold',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: Column(
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
                                                          text: 'Date',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    onChanged: (_input) {
                                                      date = _input;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      label: TextRegular(
                                                          text: 'Time',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    onChanged: (_input) {
                                                      time = _input;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    logIn(name, date, time);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Continue',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'QRegular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: TextBold(
                                                  text: 'Cannot Procceed',
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: TextBold(
                                                      text: 'Close',
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ));
                                  }
                                }
                              },
                              child: TextBold(
                                  text: 'Add',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBold(
                                text: 'Log-out',
                                fontSize: 18,
                                color: Colors.red),
                            TextButton(
                              onPressed: () async {
                                LocationPermission permission;

                                permission =
                                    await Geolocator.requestPermission();
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);

                                bool serviceEnabled;

                                List<Placemark> p =
                                    await placemarkFromCoordinates(
                                        position.latitude, position.longitude);

                                Placemark place = p[0];

                                print(
                                    "${place.locality}, ${place.thoroughfare}, ${place.street}");

                                String myLoc =
                                    "${place.locality}, ${place.thoroughfare}, ${place.street}";

                                // Test if location services are enabled.
                                serviceEnabled =
                                    await Geolocator.isLocationServiceEnabled();
                                if (!serviceEnabled) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: TextBold(
                                                text: 'Cannot Procceed',
                                                color: Colors.black,
                                                fontSize: 14),
                                            content: TextRegular(
                                                text:
                                                    'Location is not turned on',
                                                color: Colors.black,
                                                fontSize: 12),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: TextBold(
                                                    text: 'Close',
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ));
                                } else {
                                  if (myLoc ==
                                      'Malaybalay, Sayre Highway, Gaisano Building') {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                'Logging out',
                                                style: TextStyle(
                                                    fontFamily: 'QBold',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: Column(
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      label: TextRegular(
                                                          text: 'Name',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    onChanged: (_input) {
                                                      name1 = _input;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      label: TextRegular(
                                                          text: 'Date',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    onChanged: (_input) {
                                                      date1 = _input;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      label: TextRegular(
                                                          text: 'Time',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    onChanged: (_input) {
                                                      time1 = _input;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    logOut(name1, date1, time1);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Continue',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'QRegular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: TextBold(
                                                  text: 'Cannot Procceed',
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: TextBold(
                                                      text: 'Close',
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ));
                                  }
                                }
                              },
                              child: TextBold(
                                  text: 'Add',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
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
