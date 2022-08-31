import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/DB/assets_database.dart';
import 'package:stock_management/Model/assetModel.dart';
import 'package:stock_management/dropdown.dart';


// ignore: must_be_immutable
class AddPage extends StatefulWidget {
  BuildContext con;
  List<Asset> tempList;
  var images;
  var nameItem ;
  AddPage(this.tempList , this.con,this.images , this.nameItem);
  @override
  _AddPageState createState() => _AddPageState();


}

class _AddPageState extends State<AddPage> {

  // static var allNames = [];
  // List<String> namesItem = [];
  @override
  void initState() {

    super.initState();

  }



  Asset abc;
  List<String> assets = ["cashew" , "pista" , "walnut" ,"chironji"];
  TextEditingController nameAsset = new TextEditingController();

  TextEditingController quantityAsset = new TextEditingController();

  TextEditingController  photoUrl= new TextEditingController();
  TextEditingController  type= new TextEditingController();
  TextEditingController  description= new TextEditingController();
  String _chosenValue;
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Add Asset"),  backgroundColor: Colors.brown,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),

            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 226,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[500]),
                       borderRadius:BorderRadius.circular(5),
                    ),
                    //padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(left: 20),
                    child: Center(
                      child: Container(

                        width: 190,
                        margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 0),
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.black54)
                        ),
                        //padding: const EdgeInsets.all(15.0),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: DropdownButton<String>(
                            //itemHeight: 48,
                            //itemHeight: 50,
                            value: _chosenValue,

//elevation: 5,
                            style: TextStyle(color: Colors.black , fontSize: 18),


                            items: widget.nameItem.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(


                                value: value,
                                child: Container(
                                  //height: 10,
                                  width: 150,
                                    margin: EdgeInsets.only(left: 10),
                                    child: Container(
                                        //margin: EdgeInsets.only(left: 20),
                                        child: Text(value , style: TextStyle(),))
                                ),
                              );
                            }).toList(),
                            hint: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Choose item",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _chosenValue = value;
                                nameAsset.text = value;
                                //widget.type.text = value;


                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width/2,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: TextField(
                //       controller: nameAsset,
                //       decoration: InputDecoration(
                //         border: OutlineInputBorder(),
                //         hintText: 'Enter name*',
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(width: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: quantityAsset,
                      decoration: InputDecoration(
                        //focusColor: Colors.brown,
                        fillColor: Colors.brown,
                        hoverColor: Colors.brown,
                        border: OutlineInputBorder(),
                        hintText: 'quantity*',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SizedBox(height: 50, width: 200, child: DropDownDemo(type),),
                ],
              ),
            ),

            //SizedBox(height: 10,),

            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(left:  15, right: 20),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 3,
                controller: description,
                decoration: InputDecoration(
                  //focusColor: Colors.brown,
                  fillColor: Colors.brown,
                  hoverColor: Colors.brown,
                  border: OutlineInputBorder(),
                  hintText: 'Enter description (rate or brand)',
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(

                onTap: () async {
                  abc =  new Asset(nameAsset.text, int.parse(quantityAsset.text) , widget.images[nameAsset.text].toString() , type.text , description.text);
                  print(abc.name + " added "+ abc.url );
                  widget.tempList.add(abc);
                  print(type.text);
                  addAsset(nameAsset.text, int.parse(quantityAsset.text)  ,widget.images[nameAsset.text].toString() , type.text , description.text);
                  setState(() {
                    Navigator.pop(context);
                    //Navigator.pushReplacement(widget.con , MaterialPageRoute(builder: (con) => HomePage(widget.tempList)));
                  });

                  //Navigator.pushReplacement(context, newRoute);

                },
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      //border: Border.all(color: Colors.blueGrey),
                      color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text(
                      "Add asset",
                      style: TextStyle(fontSize: 18 , color: Colors.white , fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
          ],

        ),
      ),
    );
  }
}

