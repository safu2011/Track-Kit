
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trackkit/model/user_model.dart';
import 'package:trackkit/LoginSignup/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddKit extends StatefulWidget {
  const AddKit({Key? key}) : super(key: key);

  @override
  _AddKitState createState() => _AddKitState();
}

class _AddKitState extends State<AddKit> {
  TextEditingController location = TextEditingController();
  final  database = FirebaseDatabase(databaseURL: "https://trackkit-a5cf3-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child('NTU').child('Location 1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          TextFormField(
            controller: location,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Location',
            ),
          ),

          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async  {
              final DatabaseReference reference = FirebaseDatabase(databaseURL: "https://trackkit-a5cf3-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child('NTU');
              DatabaseReference newreference = reference.push();
              await newreference.set({'Location': (location.text)});
            },
          ),
        ],
      ),
    );
  }
}
