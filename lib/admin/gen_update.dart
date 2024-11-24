import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/admin/gen_create.dart';
import 'package:ebook/admin/gen_read.dart';
import 'package:ebook/admin/common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class gen_update extends StatefulWidget {
  String myid;
  gen_update(this.myid);

  @override
  State<gen_update> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<gen_update> {
  TextEditingController genre_name = TextEditingController();
  TextEditingController image = TextEditingController();

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection("genre")
        .doc(widget.myid)
        .get();

    if (data.exists) {
      genre_name.text = data.get("genre_name");
      image.text = data.get("Image");
    }
  }

  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return User_scaffold(
        "Category Form",
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //     width: 150,
            //     margin: EdgeInsets.all(30),
            //     child: Image.asset("assets/images/car.jpg")),
            Container(
              width: 500,
              margin: EdgeInsets.fromLTRB(8, 90, 0, 0),
              child: Text(
                "UPDATE CATEGORY",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  width: 500,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hoverColor: Colors.black,
                        fillColor: Colors.black,
                        labelText: 'Update Genre',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      controller: genre_name),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              selectFile(widget.myid);
                            },
                            child: Text("Select File"),
                          ),
                          result != null && result!.files.isNotEmpty
                              ? Text(result!.files.single.name)
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 500,
                  height: 50,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: const Color.fromARGB(255, 218, 218, 218),
                        offset: Offset(0, 2))
                  ], color: Colors.black),
                  child: ElevatedButton(
                    onPressed: () {
                      update();
                    },
                    child: Text(
                      "UPDATE",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> selectFile(id) async {
    try {
      result = await FilePicker.platform.pickFiles();
      print("File Selected!");
      setState(() {}); // Add setState to update the UI after selecting a file
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  void update() async {
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String uniqueFileName =
          '$timestamp${result!.files.single.name.replaceAll(" ", "_")}';

      if (result != null && result!.files.isNotEmpty) {
        await Firebase.initializeApp();
        firebase_storage.Reference storageReference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child("uploads/${uniqueFileName}");

        await storageReference.putData(result!.files.single.bytes!);

        String downloadURL = await storageReference.getDownloadURL();

        FirebaseFirestore.instance.collection('genre').doc(widget.myid).update({
          'genre_name': genre_name.text,
          'Image': downloadURL,
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => gen_show()),
        );

        alert_func("Data Updated", Icons.update, Colors.green, "");
      } else {
        print("Please select a file first");
      }
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  void alert_func(String title, IconData i, Color c, String txt) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(children: [
            Icon(
              i,
              color: c,
            ),
            Text(title),
          ]),
          content: Text(txt),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void update1() {
    FirebaseFirestore.instance.collection('genre').doc(widget.myid).update({
      'genre_name': genre_name.text,
      'Image': image.text,
    });

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => genCreate(),
        ));
    alert_func("Data Updated", Icons.update, Colors.green, "");
  }
}