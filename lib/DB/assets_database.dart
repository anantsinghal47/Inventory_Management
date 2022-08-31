import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void addAsset(String name , int qua , String url , String type , String desc) async {
  FirebaseFirestore.instance.collection("assets").doc(name).set({
    "current_quantity": qua,
    "name": name,
    "photo_url" : url,
    "type" : type,
    "description":desc

  }).then((value) => print("complete"));
}
void addToDb(String name) async {

  var list = [name];
  //var list2 = [url];
  FirebaseFirestore.instance.collection("images").doc("names").update({
    "nameArray" : FieldValue.arrayUnion(list)

  }).then((value) => print("complete"));


}

void updateAsset(String name , int qua , String type , String desc) async {
  FirebaseFirestore.instance.collection("assets").doc(name).update({
    "current_quantity": qua,
    "name": name,
    "type" : type,
    "description" : desc
  });
}

void deleteAsset(name) async {
  FirebaseFirestore.instance.collection("assets").doc(name).delete();
}
void deleteLog(id) async {
  FirebaseFirestore.instance.collection("logs").doc(id).delete();
}


void addLog(String name , int qua , bool status , String type , DateTime time) async {
  FirebaseFirestore.instance.collection("logs").add({
    "quantity": qua,
    "name": name,
    "status" : status,
    "type" : type,
    "time":time

  });
}
Future<List<String>> getAsset(String name , int qua , String type) async {
  // ignore: deprecated_member_use
  List<String> l = List<String>();
  DocumentSnapshot document =  await FirebaseFirestore.instance.collection("assets").doc(name).get();
  if(document.exists)
    {
      Map<String, dynamic>data = document.data();
      var value =  data['current_quantity'].toString();
      var value2 = await data['description'];
      var value3 = await data['photo_url'];
      print(value);
      print(value2);

      l.add( value);
      l.add(await value2);
      l.add(await value3);
      return l;
    }
  else{
    var images = {};
    await FirebaseFirestore.instance.collection("images").doc("imageAll").get().then((value){

      var abc  = value.data()["img"];
      images = abc;

    });
    addAsset(name, 0, images[name], type, "");
    // ignore: deprecated_member_use
    List<String> l = List<String>();
    DocumentSnapshot document =  await FirebaseFirestore.instance.collection("assets").doc(name).get();
    Map<String, dynamic>data = document.data();
    var value =  data['current_quantity'].toString();
    var value2 = await data['description'];
    var value3 = await data['photo_url'];
    print(value);
    print(value2);

    l.add( value);
    l.add(await value2);
    l.add(await value3);
    return l;

  }




}
// void updateAsset(String name , int qua , String type , String desc) async {
//   FirebaseFirestore.instance.collection("assets").doc(name).update({
//     "current_quantity": qua,
//     "name": name,
//     "type" : type,
//     "description" : desc
//   });
// }

// void deleteLog(DateTime time) async {
//   FirebaseFirestore.instance.collection("assets").doc().delete();
// }