import 'package:ebook/admin/book_Read.dart';
import 'package:ebook/admin/common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

// ignore: must_be_immutable
class book_update extends StatefulWidget {
  String myid;
  book_update(this.myid);

  @override
  State<book_update> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<book_update> {
  TextEditingController book_name = TextEditingController();
  TextEditingController Price = TextEditingController();
  TextEditingController availibility_status = TextEditingController();
  TextEditingController description = TextEditingController();
  List<String> mylist = [];
  List<String> mylist2 = [];
  var selectedCategory = "";
  var selectedBrand = "";
  FilePickerResult? result;

  @override
  void initState() {
    super.initState();
    fetchData();
    getdata();
    getdata2();
  }

  @override
  Widget build(BuildContext context) {
    return User_scaffold(
      "Book Form",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    border: OutlineInputBorder(),
                    hoverColor: Colors.black,
                    fillColor: Colors.black,
                    labelText: 'Enter book',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: book_name,
                ),
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
                    border: OutlineInputBorder(),
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
                  value: selectedCategory,
                  hint: Text('Select a Book'),
                ),
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
                    border: OutlineInputBorder(),
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
                  value: selectedBrand,
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
                    border: OutlineInputBorder(),
                    hoverColor: Colors.black,
                    fillColor: Colors.black,
                    labelText: 'Enter Price',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: Price,
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
                    border: OutlineInputBorder(),
                    hoverColor: Colors.black,
                    fillColor: Colors.black,
                    labelText: 'availibility status',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: availibility_status,
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
                    border: OutlineInputBorder(),
                    hoverColor: Colors.black,
                    fillColor: Colors.black,
                    labelText: 'Enter book Description',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: description,
                ),
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
                          selectFile(widget.myid);
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
                width: 250,
                height: 50,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 2,
                    color: const Color.fromARGB(255, 218, 218, 218),
                    offset: Offset(0, 2),
                  )
                ], color: Colors.black),
                child: ElevatedButton(
                  onPressed: () {
                    update();
                  },
                  child: Text(
                    "Submit",
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
      ),
    );
  }

  Future<void> fetchData() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection("book")
        .doc(widget.myid)
        .get();

    if (data.exists) {
      book_name.text = data.get("book_name");
      selectedCategory = data.get("CatName");
      selectedBrand = data.get("authorName");
      Price.text = data.get("Price");
      availibility_status.text = data.get("availibility_status");
      description.text = data.get("description");

      // Assuming fileName is a field in your Firestore document
      String fileName = data.get("Image");
    }
  }

  // Future<void> fetchData() async {
  //   DocumentSnapshot data = await FirebaseFirestore.instance
  //       .collection("products")
  //       .doc(widget.myid)
  //       .get();

  //   if (data.exists) {
  //     ProductName.text = data.get("pro_name");
  //     selectedCategory = data.get("CatName");
  //     selectedBrand = data.get("BrandName");
  //     Price.text = data.get("Price");
  //     Quantiy.text = data.get("Quantity");
  //     Description.text = data.get("description");

  //     if (fileName != null && fileName.isNotEmpty) {
  //       setState(() {
  //         result = FilePickerResult(
  //           files: [FilePickerResultItem(name: fileName)],
  //         );
  //       });
  //     }
  //   }
  // }

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
            .child("book/${uniqueFileName}");

        await storageReference.putData(result!.files.single.bytes!);

        String downloadURL = await storageReference.getDownloadURL();

        FirebaseFirestore.instance.collection('book').doc(widget.myid).update({
          'pro_name': book_name.text,
          'CatName': selectedCategory,
          'BrandName': selectedBrand,
          'Price': Price.text,
          'Quantity': availibility_status.text,
          'description': description.text,
          'Image': downloadURL,
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bookRead()),
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
          ],
        );
      },
    );
  }
}
