import 'package:ebook/admin/common.dart';
import 'package:ebook/admin/gen_read.dart';
import 'package:ebook/admin/login.darT';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class genCreate extends StatefulWidget {
  const genCreate({super.key});

  @override
  State<genCreate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<genCreate> {
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return User_scaffold(
        "Genre Form",
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                  "Genre",
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
                    width: 250,
                    child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          hoverColor: Colors.black,
                          fillColor: Colors.black,
                          labelText: 'Enter Genre',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        controller: con1),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                      margin: EdgeInsets.only(top: 15),
                      width: 500,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              selectFile();
                            },
                            child: Text("Select File"),
                          ),
                          result != null && result!.files.isNotEmpty
                              ? Text(result!.files.single.name)
                              : Container(),
                        ],
                      )),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 500,
                    height: 50,
                    margin: EdgeInsets.only(top: 20),
                    // decoration: BoxDecoration(boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 5,
                    //       spreadRadius: 2,
                    //       color: const Color.fromARGB(255, 218, 218, 218),
                    //       offset: Offset(0, 2))
                    // ], color: Colors.black),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (result != null && result!.files.isNotEmpty) {
                              uploadFile();
                            } else {
                              print("Please select a file first");
                            }
                          },
                          child: Text("Upload File"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
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
          ],
        );
      },
    );
  }

  void cls() {
    con1.text = "";
    con2.text = "";
  }

  Future<void> selectFile() async {
    try {
      result = await FilePicker.platform.pickFiles();
      print("File Selected!");
      setState(() {}); // Add setState to update the UI after selecting a file
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> uploadFile() async {
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

        CollectionReference tab =
            FirebaseFirestore.instance.collection("genre");
        Map<String, dynamic> data = {
          'genre_name': con1.text,
          'Image': downloadURL,
        };
        await tab.add(data);
        print("File uploaded successfully!");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => gen_show(),
            ));
      } else {
        print("Please select a file first");
      }
    } catch (e) {
      print("Error uploading file: $e");
      print("Error uploading file. Please try again.");
    }
  }

  void abc() {
    String name = con1.text;
    String image = con2.text;

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference tab = db.collection("Genre");
    Map<String, dynamic> data = {
      "Genre_name": name,
      "Image": image,
    };
    tab.add(data);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginApp(),
        ));
    alert_func("success", Icons.check, Colors.green, "Category Inserted");
    cls();
  }
}
