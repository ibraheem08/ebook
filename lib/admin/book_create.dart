import 'package:ebook/admin/common.dart';
import 'package:ebook/admin/book_Read.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

class book_create extends StatefulWidget {
  const book_create({super.key});

  @override
  State<book_create> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<book_create> {
  TextEditingController book_name = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController Price = TextEditingController();
  TextEditingController availibility_status = TextEditingController();

  FilePickerResult? result;
  // TextEditingController ProductName = TextEditingController();

  void initState() {
    super.initState();
    getdata();
    getdata2();
  }

  List<String> mylist = [];
  List<String> mylist2 = [];
  var selectedCategory = "";
  var selectedBrand = "";

  @override
  Widget build(BuildContext context) {
    return User_scaffold(
      "Books Form",
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //     width: 150,
            //     margin: EdgeInsets.all(30),
            //     child: Image.asset("assets/images/car.jpg")),
            Container(
              width: 500,
              margin: EdgeInsets.fromLTRB(8, 20, 0, 20),
              child: Text(
                "Book",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        hoverColor: Colors.black,
                        fillColor: Colors.black,
                        labelText: 'Enter Book',
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 32, 26, 26)),
                      ),
                      controller: book_name),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Container(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    items: mylist.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (category) {
                      setState(() {
                        selectedCategory = category!;
                      });
                    },
                    hint: Text('Select a Genre'),
                  ),
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    items: mylist2.map((values) {
                      return DropdownMenuItem<String>(
                        value: values,
                        child: Text(values),
                      );
                    }).toList(),
                    onChanged: (brand) {
                      setState(() {
                        selectedBrand = brand!;
                      });
                    },
                    hint: Text('Select a author'),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        hoverColor: Colors.black,
                        fillColor: Colors.black,
                        labelText: 'Enter Price',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      controller: Price),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        hoverColor: Colors.black,
                        fillColor: Colors.black,
                        labelText: 'Enter avalibility',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      controller: availibility_status),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        hoverColor: Colors.black,
                        fillColor: Colors.black,
                        labelText: 'Enter Book Description',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      controller: Description),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
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
                          ),
                        ],
                      ),
                    )),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       blurRadius: 10,
                      //       spreadRadius: 10,
                      //       color: const Color.fromARGB(255, 218, 218, 218),
                      //       offset: Offset(0, 2))
                      // ],
                      //  color: Colors.black
                      ),
                  child: ElevatedButton(
                    onPressed: () {
                      uploadFile();
                      // cls();

                      // abc();
                    },
                    child: Text(
                      "Submit",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getdata() async {
    QuerySnapshot<Map<String, dynamic>> query =
        await FirebaseFirestore.instance.collection("genre").get();
    setState(() {
      mylist = query.docs.map((e) {
        return e.data()['genre_name'].toString();
      }).toList();
    });
  }

  Future<void> getdata2() async {
    QuerySnapshot<Map<String, dynamic>> query1 =
        await FirebaseFirestore.instance.collection("author").get();
    setState(() {
      mylist2 = query1.docs.map((b) {
        return b.data()['author_name'].toString();
      }).toList();
    });
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
            .child("book/${uniqueFileName}");

        await storageReference.putData(result!.files.single.bytes!);

        String downloadURL = await storageReference.getDownloadURL();

        CollectionReference tab = FirebaseFirestore.instance.collection("book");
        Map<String, dynamic> data = {
          "book_name": book_name.text,
          "genre": selectedCategory,
          "author_name": selectedBrand,
          "Price": Price.text,
          "availibility_status": availibility_status.text,
          "description": Description.text,
          'Image': downloadURL,
        };
        await tab.add(data);
        print("File uploaded successfully!");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bookRead()),
        );
        alert_func("success", Icons.check, Colors.green, "Inserted");
        cls();
      } else {
        print("Please select a file first");
      }
    } catch (e) {
      print("Error uploading file: $e");
      print("Error uploading file. Please try again.");
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
          ],
        );
      },
    );
  }

  void cls() {
    book_name.text = "";
    Price.text = "";
    availibility_status.text = "";
    Description.text = "";
    selectedBrand = "";
    selectedCategory = "";
  }

//   void abc() {
//     String name = boName.text;

//     String price = Price.text;
//     String quantity = Quantiy.text;
//     String desccription = Description.text;

//     FirebaseFirestore db = FirebaseFirestore.instance;
//     CollectionReference tab = db.collection("products");
//     Map<String, dynamic> data = {
//       "pro_name": name,
//       "CatName": selectedCategory,
//       "BrandName": selectedBrand,
//       "Price": price,
//       "Quantity": quantity,
//       "description": desccription
  // };
  //   try {
  //     tab.add(data);
  //     print("Inserted");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => bookRead()),
  //     );
  //     alert_func("success", Icons.check, Colors.green, "logged in");
  //     cls();
  //   } catch (e) {
  //     print("error $e ");
  //   }
  // }
}
