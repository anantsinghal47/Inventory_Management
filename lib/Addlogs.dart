import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/DB/assets_database.dart';
import 'package:stock_management/Model/assetModel.dart';
import 'package:stock_management/dropdown.dart';

// ignore: must_be_immutable
class AddLog extends StatefulWidget {
  var nameItem ;
  // BuildContext con;
  // List<Asset> tempList;
  // var images;
   AddLog(this.nameItem );
  @override
  _AddLogState createState() => _AddLogState();


}

class _AddLogState extends State<AddLog> {

  String _chosenValue ;
  String _chosenValue2 ;
   // @override
  // void initState() {
  //   super.initState();
  //   Firebase.initializeApp().whenComplete(() {
  //     print("completed");
  //     setState(() {});
  //   });
  // }

  Asset abc;
  //List<String> assets = ["cashew" , "pista" , "walnut" ,"chironji"];
  TextEditingController nameAsset = new TextEditingController();
  TextEditingController quantityAsset = new TextEditingController();

  TextEditingController  time= new TextEditingController();
  TextEditingController  type= new TextEditingController();
  //TextEditingController  status= new TextEditingController();
  bool status;

  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Make Entry"),  backgroundColor: Colors.brown,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),


            //SizedBox(height: 20,),
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

                        width: 200,
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
                            value: _chosenValue2,

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
                                _chosenValue2 = value;
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
                SizedBox(width: 5,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/3.5,
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     controller: nameAsset,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       hintText: 'Enter name*',
            //     ),
            //   ),
            // ),
            //SizedBox(height: 20,),


            SizedBox(height: 40,),
            Row(
              children: [
                Container(

                  margin: EdgeInsets.only(left: 20 , right: 0),
                    child: SizedBox(height: 50, width: 165, child: DropDownDemo(type),)),
                SizedBox(
                  width: 160,
                  child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[500]),
                      borderRadius:BorderRadius.circular(5),
                    ),
                    width: 180,
                    //margin: EdgeInsets.symmetric(horizontal: 10),
                    // decoration: BoxDecoration(
                    //   //border: Border.all(color: Colors.black54)
                    // ),
                    //padding: const EdgeInsets.all(15.0),
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: DropdownButton<String>(
                        value: _chosenValue,

//elevation: 5,
                        style: TextStyle(color: Colors.black , fontSize: 18),


                        items: <String>[
                          "Entry",
                          "Exit"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(value)
                            ),
                          );
                        }).toList(),
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Choose",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              //fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            //widget.type.text = value;
                             if(value == "Entry")
                               {
                                 status = true;
                               }
                             else{
                               status = false;
                             }
                            _chosenValue = value;

                          });
                        },
                      ),
                    ),
                  ),
          ),
        ),
                ),
              ],
            ),
            //SizedBox(height: 50, width: 150, child: DropDownDemo(type),),


            // SizedBox(height: 20,),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     controller: description,
            //     decoration: InputDecoration(
            //       //focusColor: Colors.brown,
            //       fillColor: Colors.brown,
            //       hoverColor: Colors.brown,
            //       border: OutlineInputBorder(),
            //       hintText: 'Enter description (rate or brand)',
            //     ),
            //   ),
            // ),
            SizedBox(height: 50,),
            GestureDetector(

                onTap: () async {
                  DateTime timestamp = DateTime.now();
                  addLog(nameAsset.text, int.parse(quantityAsset.text), status  , type.text, timestamp);
                  var abc = await getAsset(nameAsset.text, int.parse(quantityAsset.text) , type.text );
                  // setState(() {
                  //   _abc = abc;
                  // });
                  print(abc);
                  int newQua = int.parse(abc[0]);
                  //print(abc.toString().characters);
                  if(status == true )
                    {
                      newQua += int.parse(quantityAsset.text);
                    }
                  else{
                    if(newQua >= int.parse(quantityAsset.text)) {
                      newQua -= int.parse(quantityAsset.text);
                    }
                    else{
                      print("shortage ");
                    }
                  }
                   addAsset(nameAsset.text, newQua, abc[2], type.text, abc[1]);
                  setState(() {
                    Navigator.pop(context);
                    //Navigator.pushReplacement(widget.con , MaterialPageRoute(builder: (con) => HomePage(widget.tempList)));
                  });
                  //101updateAsset(nameAsset.text,newQua , type.text, abc[1]);
                  // abc =  new Asset(nameAsset.text, int.parse(quantityAsset.text) , widget.images[nameAsset.text].toString() , type.text , description.text);
                  // print(abc.name + " added "+ abc.url );
                  // widget.tempList.add(abc);
                  // print(type.text);
                  // addAsset(nameAsset.text, int.parse(quantityAsset.text)  ,widget.images[nameAsset.text].toString() , type.text , description.text);


                  //Navigator.pushReplacement(context, newRoute);

                },
                child: Container(

                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                      color: Colors.yellowAccent[100],
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text(
                      "Add Log",
                      style: TextStyle(fontSize: 18 , color: Colors.brown , fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
          ],

        ),
      ),
    );
  }
}
//
// Widget dropDownEntryExit(){
//   String _chosenValue;
//   return Padding(
//     padding: EdgeInsets.only(left: 10),
//     child: Center(
//       child: Container(
//
//         width: 235,
//         //margin: EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           //border: Border.all(color: Colors.black54)
//         ),
//         //padding: const EdgeInsets.all(15.0),
//         child:  Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0),
//           child: DropdownButton<String>(
//             value: _chosenValue,
//
// //elevation: 5,
//             style: TextStyle(color: Colors.black , fontSize: 18),
//
//
//             items: <String>[
//               'Bags',
//               'Boxes',
//               'Pieces'
//             ].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             hint: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Text(
//                 "Quantity type",
//                 style: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 16,
//                   //fontWeight: FontWeight.w600
//                 ),
//               ),
//             ),
//             onChanged: (String value) {
//               setState(() {
//                 widget.type.text = value;
//                 _chosenValue = value;
//               });
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }