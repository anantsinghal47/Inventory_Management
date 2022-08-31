import 'package:flutter/material.dart';

class DropDownDemo extends StatefulWidget {
  final TextEditingController type;
  DropDownDemo(this.type);
  @override
  _DropDownDemoState createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo> {
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('DropDown'),
      // ),
      body: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Center(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[500]),
              borderRadius:BorderRadius.circular(5),
            ),
            width: 235,
            //margin: EdgeInsets.symmetric(horizontal: 10),

            //padding: const EdgeInsets.all(15.0),
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
              value: _chosenValue,

//elevation: 5,
              style: TextStyle(color: Colors.black , fontSize: 18),


              items: <String>[
                'Bags',
                'Boxes',
                'Pieces'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(value)
                  ),
                );
              }).toList(),
              hint: Container(

                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Quantity type",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      //fontWeight: FontWeight.w600
                  ),
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  widget.type.text = value;
                  _chosenValue = value;
                });
              },
          ),
            ),
          ),
        ),
      ),
    );
  }
}