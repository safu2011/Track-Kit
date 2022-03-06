import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final heroTag;
  final foodName;
  int num;
  final  onValueChanged;

  DetailsPage({this.heroTag, this.foodName, this.onValueChanged,this.num = 0 });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // var selectedCard = 'WEIGHT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Details',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: ListView(children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                top: 75.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height - 100.0,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
                top: 0.0,
                left: (MediaQuery.of(context).size.width / 2) - 50.0,
                child: Hero(
                    tag: widget.heroTag,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.heroTag),
                                fit: BoxFit.cover)),
                        height: 100.0,
                        width: 100.0))),
            Positioned(
                top: 100.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.foodName,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    Container(height: 5.0, width: 1.0),
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height - 300,
                      child: ListView(
                          children: [
                            _buildItem('assets/Aborbent Gauze.jpeg', 'Aborbent Gauze '),
                            _buildItem('assets/Adhesive Dressings.jpeg', 'Adhesive Dressings.jpeg  '),
                            _buildItem('assets/Crepe Bandage.jpeg', 'Crepe Bandage.jpeg '),
                            _buildItem('assets/Disposable Glove Pairs.jpeg', 'Disposable Glove Pairs '),
                            _buildItem('assets/Disposable Resuscitation Pack.jpeg', 'Disposable Resuscitation Pack '),
                            _buildItem('assets/Eye Pad.jpeg', 'Eye Pad.jpeg '),
                            _buildItem('assets/Eye Shield.jpeg', 'Eye Shield '),
                            _buildItem('assets/Hypoallergenic Tape.jpeg', 'Hypoallergenic Tape '),
                            _buildItem('assets/Safety Pins.jpeg', 'Safety Pins '),
                            _buildItem('assets/Scissors.jpeg', 'Scissors '),
                            _buildItem('assets/Torch Light.jpeg', 'Torch Light '),
                            _buildItem('assets/Triangular Bandage.jpeg', 'Triangular Bandage '),

                          ]),
                    ),


                  ],
                )
            )
          ])
        ]));
  }
  Widget _buildItem(String imgPath, String LabName) {
    return Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 10, top: 0.0),
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
                              height: 120.0,
                              width: 130.0
                          )
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(
                              LabName,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 100.0,
                              height: 30.0,
                              margin: const EdgeInsets.only(left: 0.0, top: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17.0),
                                  color: const Color(0xFF7A9BEE)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    onTap: _minusNum,
                                    child: Container(
                                      height: 25.0,
                                      width: 25.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7.0),
                                          color: const Color(0xFF7A9BEE)),
                                      child: const Center(
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(widget.num.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontSize: 15.0)),

                                  InkWell(
                                    onTap: _addNum,
                                    child: Container(
                                      height: 25.0,
                                      width: 25.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7.0),
                                          color: Colors.white),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Color(0xFF7A9BEE),
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]
                      ),

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
    );
  }



  // selectCard(cardTitle) {
  //   setState(() {
  //     selectedCard = cardTitle;
  //   });
  // }

  void _minusNum() {
    if (widget.num == 0) {
      return;
    }

    setState(() {
      widget.num -= 1;

      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }

  void _addNum() {
    setState(() {
      widget.num += 1;

      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }
}