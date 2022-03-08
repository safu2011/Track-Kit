import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:trackkit/LoginSignup/DetailsPage.dart';
import 'package:trackkit/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
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
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 70.0, left: 10.0),
          ),
          SizedBox(height :25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('TracK',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
                SizedBox(),
                Text('Kit',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
          height: MediaQuery.of(context).size.height - 185.0,
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
          ),
          child: ListView(
          primary: false,
          padding: EdgeInsets.only(left: 25.0, right: 20.0),
          children: <Widget>[
          Padding(
          padding: EdgeInsets.only(top: 45.0),
          child: Container(
          height: MediaQuery.of(context).size.height - 300.0,
          child: ListView(
              children: [
                _buildItem1('assets/Icon.png', 'Communication Research I\nS2.1-B4-03 '),
                _buildItem2('assets/Icon.png', 'Communication Research II \nS2-B3C-26  '),
                _buildItem3('assets/Icon.png', 'Communication Lab 1\nS4-B1B-22 '),
              ]),
                ),
                ),

          ]
          )
          )
        ],
      ),
    );
  }
  Widget _buildItem1(String imgPath, String LabName,) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage(heroTag: imgPath, foodName: LabName,)),
          );
        },
                     child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: imgPath,
                              child: Image(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 90.0,
                                  width: 90.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                    LabName,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),

                              ]
                          )
                        ]
                    )
                ),
                //IconButton(
                 //   icon: Icon(Icons.add),
                 //   color: Colors.black,
                 //   onPressed: () {}
                //)
              ],
            )
        ));
  }
  Widget _buildItem2(String imgPath, String LabName,) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsPage(heroTag: imgPath, foodName: LabName,)),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: imgPath,
                              child: Image(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 90.0,
                                  width: 90.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                    LabName,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),

                              ]
                          )
                        ]
                    )
                ),
                //IconButton(
                //   icon: Icon(Icons.add),
                //   color: Colors.black,
                //   onPressed: () {}
                //)
              ],
            )
        ));
  }
  Widget _buildItem3(String imgPath, String LabName,) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsPage(heroTag: imgPath, foodName: LabName,)),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: imgPath,
                              child: Image(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 90.0,
                                  width: 90.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                    LabName,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),

                              ]
                          )
                        ]
                    )
                ),
                //IconButton(
                //   icon: Icon(Icons.add),
                //   color: Colors.black,
                //   onPressed: () {}
                //)
              ],
            )
        ));
  }
}

