import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {
  AddItem({Key? key, required this.referenceName}) : super(key: key);

  @override
  _AddItem createState() => _AddItem();
  String referenceName;
}

class _AddItem extends State<AddItem> {
  TextEditingController productController = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController expiry = TextEditingController();

  final database = FirebaseDatabase(
          databaseURL:
              "https://trackkit-a5cf3-default-rtdb.asia-southeast1.firebasedatabase.app")
      .reference();

  @override
  Widget build(BuildContext context) {
    // DatabaseReference location = FirebaseDatabase.instance.reference().child("Location 1");
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: productController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Product name',
            ),
          ),
          TextFormField(
            controller: quantity,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Quantity',
            ),
          ),
          TextFormField(
              controller: expiry,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Expiration Date',
              ),
              onTap: () {
                _selectDate(context);
              }),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              final DatabaseReference reference = FirebaseDatabase(
                      databaseURL:
                          "https://trackkit-a5cf3-default-rtdb.asia-southeast1.firebasedatabase.app")
                  .reference()
                  .child('NTU')
                  .child('Location 1');
              DatabaseReference newRef = reference.push();
              //  final productname = database.child('NTU').child('Location 1').child(productController.text);
              await newRef.set({
                'Quantity': int.parse(quantity.text),
                'Expiry Date': expiry.text,
                'Item': productController.text
              });
            },
          ),
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        expiry
          ..text = DateFormat.yMMMd().format(selectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: expiry.text.length, affinity: TextAffinity.upstream));
      });
    }
  }
}
