import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {
  AddItem({Key? key, required this.referenceName}) : super(key: key);

  @override
  _AddItem createState() => _AddItem();
  String referenceName;
}

class _AddItem extends State<AddItem> {
  File imageFile = File("");
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
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
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
                Center(
                  child: ElevatedButton(
                    child: const Text('Add Image'),
                    onPressed: () async {
                      _showChoiceDialog(context);
                    },
                  ),
                ),
                imageFile.path == ""
                    ? Center(child: Text(""))
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.file(imageFile, fit: BoxFit.fill)),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () async {
                    EasyLoading.show(status: 'Saving please wait...');
                    final DatabaseReference reference = FirebaseDatabase(
                            databaseURL:
                                "https://trackkit-a5cf3-default-rtdb.asia-southeast1.firebasedatabase.app")
                        .reference()
                        .child('NTU')
                        .child(widget.referenceName);
                    DatabaseReference newRef = reference.push();
                    //  final productname = database.child('NTU').child('Location 1').child(productController.text);

                    uploadPic(newRef.key).then((imageUrl) async {
                      await newRef.set({
                        'Quantity': int.parse(quantity.text),
                        'Expiry Date': expiry.text,
                        'Item': productController.text,
                        'Image': imageUrl
                      });
                      EasyLoading.dismiss();
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    Navigator.pop(context);
  }

  Future<String> uploadPic(String newRef) async {
    print("File path = ${imageFile.path}");
    final UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("${widget.referenceName}/$newRef")
        .putFile(File(imageFile.path));
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
