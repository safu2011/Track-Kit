import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackkit/LoginSignup/home_screen.dart';
import 'package:trackkit/Screens/addkitscreen.dart';
import 'package:trackkit/Screens/addnewitem.dart';
import 'package:trackkit/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';




var lists = [];
class MainLocation extends StatefulWidget {
  const MainLocation({Key? key}) : super(key: key);

  @override
  _MainLocationState createState() => _MainLocationState();
}

class _MainLocationState extends State<MainLocation> {
  User? user = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase(
      databaseURL: "https://trackkit-a5cf3-default-rtdb.asia-southeast1.firebasedatabase.app")
      .reference()
      .child("NTU");
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          StreamBuilder(
            stream: database.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData && !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                print("Error on the way");
                lists.clear();
                DataSnapshot dataValues = snapshot.data!.snapshot;
                Map<dynamic, dynamic> values = dataValues.value;
                values.forEach((key, values) {
                  values["referenceName"] = key;
                  lists.add(values);
                });
                return  ListView.builder(
                  shrinkWrap: true,
                  itemCount: lists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text("Location: " + lists[index]["Place"].toString()),
                        onTap:(){
                          print(json.encode(lists[index]));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen(referenceName: lists[index]["referenceName"])),
                          );
                        },
                        leading: const SizedBox(
                        width: 50,
                        height: 50,
                      ),
                      ),
                    );
                  },
                );
              }
              return const Text("Add Kits");
            },
          ),
          ElevatedButton(
            child: const Text('Add Kits'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddKit()),
              );
            },
          ),
        ],

      ),

    );
  }
}
