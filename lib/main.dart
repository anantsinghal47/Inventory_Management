

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_management/AddNewItem.dart';
import 'package:stock_management/Addlogs.dart';
import 'package:stock_management/DB/assets_database.dart';
import 'package:stock_management/addAsset.dart';

import 'Model/assetModel.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  List<Asset> abc = [];

  @override



  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Buttons(),
          backgroundColor: Colors.blueGrey[600] , title: Text("Stock Management"), toolbarHeight: 60,centerTitle: true,
        ),
        body: HomePage(abc),
        ),
      );
  }
}

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final List<Asset> productList ;
  HomePage(this.productList);
  @override
  _HomePageState createState() => _HomePageState();
  //Function remove;
}

class _HomePageState extends State<HomePage> {
  static var allNames = [];
  List<String> namesItem = [];
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      //print(images["cashew"]);
      _selectedIndex = index;
    });
  }
 static var images = {};
  void _remove(var direction , var id)
  {
    setState(() {
      deleteLog(id);
    });
  }

@override
  void initState() {

    //// TODO: implement initState
   FirebaseFirestore.instance.collection("images").doc("imageAll").get().then((value) async{

   var  abc  = await value.data()["img"];
   images = abc;
   print(abc);


  }).then((value) => print("fetched"));

   FirebaseFirestore.instance.collection("images").doc("names").get().then((value) async{

     var  abcd  = await value.data()["nameArray"];
     allNames = abcd;
     print(abcd);

     allNames.forEach((element) {
       namesItem.add(element.toString());
     });
     namesItem.sort();


   }).then((value) => print("fetched"));



    super.initState();
  }


  //Asset abc = new Asset("kaju", 2, "0");
   void listAdd(value)
  {
  widget.productList.add(value);
  }

  static  List<Widget> _widgetOptions = <Widget>[
    ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        // Container(
        //   height: 50,
        //   child: Center(child: Text("Updated Assets" , style: TextStyle(fontSize: 20),))
        //
        // ),
        //SizedBox(height: 20,),
        StreamBuilder<QuerySnapshot>(
          // <2> Pass `Future<QuerySnapshot>` to future
            stream: FirebaseFirestore.instance.collection('assets').orderBy("name").snapshots(),
            builder: (context, snapshot) {
              if( !snapshot.hasData ) return Center(child: LinearProgressIndicator());
              final List<DocumentSnapshot> documents = snapshot.data.docs;

              return Column(
                //shrinkWrap: true,
                //scrollDirection: Axis.vertical,

                children: documents
                    .map((doc) => SizedBox(
                  height: 100,
                  child: tile(doc["name"].toString() , doc["current_quantity"].toString() ,doc["photo_url"].toString() ,doc["type"].toString() , doc["description"].toString() , context),
                )).toList() ,

              );
            }),
        //SizedBox(height: 40,)
      ],
    ),
    Container(
      //padding: EdgeInsets.all(10),
      //margin: EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          // Container(
          //   height: 50,
          //   child: Center(child: Text("Updated Assets" , style: TextStyle(fontSize: 20),))
          //
          // ),
          //SizedBox(height: 20,),
          StreamBuilder<QuerySnapshot>(
            // <2> Pass `Future<QuerySnapshot>` to future
              stream: FirebaseFirestore.instance.collection('logs').orderBy("time" , descending: true).snapshots(),

              builder: (context, snapshot) {

                if( !snapshot.hasData ) return LinearProgressIndicator();
                final List<DocumentSnapshot> documents = snapshot.data.docs;


                return Column(
                  //shrinkWrap: true,
                  //scrollDirection: Axis.vertical,

                  children: documents
                      .map((doc) => Dismissible(
                       key: UniqueKey(),
                       onDismissed: (direction) async {
                         //_showMyDialog(context, doc["name"] , "logs");
                         var id = doc.id;
                         //_remove(direction, id);
                         print(id.toString());
                         //addAsset(name, qua, url, type, desc)
                         var abc = await FirebaseFirestore.instance.collection("assets").doc(doc["name"]).get();
                         Map<String, dynamic>data = abc.data();
                         var value;
                         if(doc["status"]){
                          // print("error");
                          value =  data["current_quantity"] -doc["quantity"];
                         }
                         else{
                            value =  data['current_quantity']+doc["quantity"];
                         }
                         var value2 =  await data['description'];
                         var value3 =  await data['type'];
                         updateAsset(doc["name"].toString(), value, value3, value2);
                         deleteLog(id);
                       },
                        child: SizedBox(
                    height: 125,
                    child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(new DateFormat("dd-MM-yyyy").format(doc["time"].toDate()), style: TextStyle(fontSize: 13 , ),),
                                  ),
                                  // IconButton(icon: Icon(Icons.delete),onPressed: (){
                                  //   //_showMyDialog(context , namesItem[0]);
                                  //
                                  // },),
                                  Spacer(),


                                  //Spacer(),
                                  // IconButton(icon: Icon(Icons.delete),onPressed: (){
                                  //   //_showMyDialog(context , namesItem[0]);
                                  //
                                  // },),

                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  SizedBox(width: 10,),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(images[doc["name"]].toString()),
                                  ),
                                  SizedBox(width: 15,),
                                  Text(doc["name"].toString() , style: TextStyle(fontSize: 23 , color: Colors.brown , fontWeight: FontWeight.w500),),
                                  //SizedBox(width: 30,),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: SizedBox(
                                      width : 51,
                                      height: 45,
                                      child: Column(
                                        children: [
                                          Text(doc["status"] ? "+" + doc["quantity"].toString() : "-" +doc["quantity"].toString() , style: TextStyle(color:doc["status"] ? Colors.green : Colors.redAccent[700] , fontSize: 25),),
                                          Text(doc["type"] , style: TextStyle(color: Colors.black54),),
                                        ],
                                      ),
                                    ),
                                    // IconButton(icon: Icon(Icons.delete),onPressed: (){
                                    //   //_showMyDialog(context , namesItem[0]);
                                    //
                                    // },),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: IconButton(icon: doc["status"] ? Icon(Icons.subdirectory_arrow_left_sharp) :Icon(Icons.subdirectory_arrow_right_sharp) ,onPressed: (){
                                      //_showMyDialog(context , namesItem[0]);

                                    },
                                      color:doc["status"] ? Colors.green : Colors.redAccent[700] ,
                                    ),
                                  ),


                                  //doc["status"] ? Icon(Icons.add) : Icon(Icons.exit_to_app)
                                ],
                              ),
                              //Text(doc["status"].toString()),
                              //Text(doc["quantity"].toString()),
                              //Text(doc["time"].toString()),


                            ],
                          ),
                        ),
                    ),
                  ),
                      )).toList() ,

                );
              }),
          //SizedBox(height: 40,)
        ],
      ),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          Navigator.push(context , MaterialPageRoute(builder: (context) => AddLog(namesItem)));
        },
        backgroundColor: Colors.yellowAccent ,
        child: Icon(
            Icons.post_add_outlined,
          color: Colors.black54,
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'history',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: _selectedIndex == 0 ? AppBar(backgroundColor: Colors.brown[400], title:  Text("Updated Stocks" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
        toolbarHeight: 40,
        actions: [IconButton(icon: Icon(Icons.add), onPressed:(){
          Navigator.push(context , MaterialPageRoute(builder: (context) => AddPage(widget.productList , context, images , namesItem)));
          //print(AddPage().abc)
          //listAdd(AddPage().abc);
          print(widget.productList);

        } )],
      ): AppBar(backgroundColor: Colors.brown[400], title:  Text("Recent Logs" , style: TextStyle(fontSize: 18),),
        toolbarHeight: 40,
      ),
      body:
      _widgetOptions.elementAt(_selectedIndex),

    ) ;
  }
}

Widget tile(String name , String qua , String url , String type , String desc , BuildContext context)
{
  // print("-----");
  // print(images);
  // print(images[name]);

  return GestureDetector(
    onTap: (){
      Navigator.push(context , MaterialPageRoute(builder: (context) => EachTile(desc , type , name , url , qua)));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 1,

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          //minRadius: 20,
          radius: 40,
          backgroundImage: NetworkImage(url),
        ),
        title: Text(name , style: TextStyle(fontSize: 23 , color: Colors.brown , fontWeight: FontWeight.w400),),
        subtitle: Text( qua  + " "+ type ,style: TextStyle(fontSize:  22 , fontWeight: FontWeight.bold , color:  qua == '0' ? Colors.red : Colors.green[600]),),
        trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
          String a = "item";
          _showMyDialog(context , name , a);

        },),
      ),
    ),
  );
}

// ignore: must_be_immutable
class EachTile extends StatefulWidget {
   String name ;
   String qua ;
  final String url ;
   String type ;
  String desc ;
  EachTile(this.desc , this.type , this.name , this.url , this.qua );
  @override
  _EachTileState createState() => _EachTileState();
}

class _EachTileState extends State<EachTile> {
  TextEditingController quantity = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController description = new TextEditingController();


  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[200],

        //title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text(widget.name , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.black54),),
                  SizedBox(height: 10,),
                  Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.url),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Card(
                    color: Colors.brown[50],
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      height: 370,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              !isEdit ?
                              Text("Quantity: "+ widget.qua, style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold , color: Colors.brown),)
                              :Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Quantity" , style: TextStyle(fontSize: 17),),
                                  SizedBox(height: 15,),
                                  SizedBox(width: 100,child:
                                  TextField(
                                    controller: quantity,
                                    decoration: InputDecoration(hintText: "Quantity"),),
                                    height: 20,),
                                ],
                              )
                              ,
                              !isEdit ?
                              Text("Type: "+ widget.type, style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold , color: Colors.brown),)
                              :Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Type", style: TextStyle(fontSize: 17),),
                                  SizedBox(height: 15,),
                                  SizedBox(width: 100,child:
                                  TextField(
                                    controller: type,
                                    decoration: InputDecoration(hintText: "Type"),),
                                    height: 20,),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                          SizedBox(height: 20,child: Text("Description"),),
                          Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width/1.1,
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 3),
                                  child: !isEdit ? Text(
                                    "\n"+widget.desc, style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.brown),
                                  ) : SizedBox(
                                    height: 100,
                                    child: Container(
                                      margin: EdgeInsets.all(0),
                                      height: 6 * 24.0,
                                      child: TextField(
                                        // onSubmitted: (value){
                                        //   setState(() {
                                        //     widget.desc = value.toString();
                                        //   });
                                        // },
                                        controller: description,
                                        maxLines: 6,
                                        decoration: InputDecoration(
                                          hintText: "Enter a message",
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                              ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(onPressed: (){
                                setState(() {

                                  isEdit = !isEdit;
                                  if(isEdit) {
                                    description.text = widget.desc;
                                    quantity.text = widget.qua;
                                    type.text = widget.type;

                                  }
                                  if(!isEdit){
                                    widget.desc = description.text;
                                    widget.qua = quantity.text;
                                    widget.type = type.text;
                                    updateAsset(widget.name, int.parse(widget.qua), widget.type, widget.desc);
                                    print(widget.qua);
                                  }

                                });

                                // Navigator.pop(context);
                                // deleteAsset(widget.name);
                              } , child: Text("Edit item" , style: TextStyle(color: Colors.blue, fontSize: 18),),),
                              MaterialButton(onPressed: (){
                                Navigator.pop(context);
                                deleteAsset(widget.name);
                              } , child: Text("Delete Item" , style: TextStyle(color: Colors.red , fontSize: 18),),)
                            ],
                          )

                        ],
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Widget _buildTextField(TextEditingController des , String de) {
//   des.text = de;
//
//   final maxLines = 7;
//
//   return Container(
//     margin: EdgeInsets.all(0),
//     height: maxLines * 24.0,
//     child: TextField(
//       controller: des,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: "Enter a message",
//         fillColor: Colors.white,
//         filled: true,
//       ),
//     ),
//   );
// }
Future<void> _showMyDialog(BuildContext context , String name , String type) async {
  return showDialog<void>(
    context: context,
    //barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete item'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              //Text('This is a demo alert dialog.'),
              Text('do you want to delete ' + name + '?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:  Text('Delete item'),
            onPressed: () {
              if(type == "item") {
                deleteAsset(name);
                Navigator.of(context).pop();
              }

            },
          ),
        ],
      );
    },
  );
}
class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.assignment),onPressed: (){
      Navigator.push(context , MaterialPageRoute(builder: (context) => AddNewItem()));
    },);
  }
}
