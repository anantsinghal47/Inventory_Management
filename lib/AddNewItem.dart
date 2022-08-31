import 'package:flutter/material.dart';
import 'package:stock_management/DB/assets_database.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  TextEditingController name = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Asset to DB",) , backgroundColor: Colors.brown[400],),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
              ),
            ),
            SizedBox(height: 20,),
            TextButton(onPressed: (){
              addToDb(name.text);
              Navigator.pop(context);
            }, child: Text("Add")),
          ],
        ),
      ),
    );
  }
}
