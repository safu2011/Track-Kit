import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackkit/Screens/flutter_barcode_scanner.dart';

import 'flutter_barcode_scanner.dart';

class AddKit extends StatefulWidget {
  const AddKit({Key? key}) : super(key: key);

  @override
  _AddKitState createState() => _AddKitState();
}

class _AddKitState extends State<AddKit> {
  String _scanBarcode = '';

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  TextEditingController location = TextEditingController();
  TextEditingController labName = TextEditingController();
  TextEditingController barcode = TextEditingController();

  final database = FirebaseDatabase(
          databaseURL:
              "https://trackkit-a5cf3-default-rtdb.asia-southeast1.firebasedatabase.app")
      .reference()
      .child('NTU')
      .child('Location 1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: labName,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Lab Name',
            ),
          ),
          TextFormField(
            controller: location,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Location',
            ),
          ),
          TextFormField(
            controller: barcode,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Press to scan',
            ),
              onTap: () {
                scanQR();
                barcode.text = _scanBarcode;

              }

          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              final DatabaseReference reference = FirebaseDatabase(
                      databaseURL:
                          "https://trackkit-a5cf3-default-rtdb.asia-southeast1.firebasedatabase.app")
                  .reference()
                  .child('NTU');
              DatabaseReference newreference = reference.push();
              await newreference.set({ 'Lab Name': labName.text,
                'Location': location.text,
                'Barcode': barcode.text});

            },
          ),
        ],
      ),
    );


  }
}
