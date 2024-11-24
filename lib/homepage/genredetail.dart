import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/admin/book_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class bookDetails extends StatefulWidget {
  String myid;

  bookDetails(this.myid);

  @override
  State<bookDetails> createState() => _MyWidgetState();
}

class EmpGetterSetter {
  final String id;
  final String name;
  final String description;
  final String genre;
  final String price;
  final String author;
  final String availibility_status;
  final String image;

  EmpGetterSetter(this.id, this.name, this.description, this.price,
      this.availibility_status, this.author, this.genre, this.image);
}

class _MyWidgetState extends State<bookDetails> {
  @override
  void initState() {
    super.initState();
    getAllData2();
  }

  List<EmpGetterSetter> details = [];

  Future<void> getAllData2() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('book')
        .where('genre', isEqualTo: widget.myid)
        .get();

    if (querySnapshot.docs.isEmpty) {
      setState(() {
        dataa = false;
      });
    }
    for (var data in querySnapshot.docs) {
      var id = data.id;
      var name = data["book_name"];
      var description = data["description"];
      var price = data["Price"];
      var availibility_status = data["availibility_status"];
      var author = data["author_name"];
      var genre = data["genre"];
      var image = data["Image"];

      setState(() {
        details.add(EmpGetterSetter(id, name, description, price,
            availibility_status, author, genre, image));
      });
    }
  }

  bool dataa = true;

  @override
  Widget build(BuildContext context) {
    if (details.isEmpty) {
      // Show a loading indicator while data is being fetched
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      // Once data is fetched, display the book details
      return Scaffold(
        appBar: AppBar(
          title: Text('Genre Details Table'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: details.length,
                  itemBuilder: (context, index) {
                    EmpGetterSetter detail = details[index];
                    return Card(
                      child: Row(
                        children: [
                          Container(
                            height: 200,
                            // Adjust width if needed
                            width: 150,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                              detail.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Book Name: ${detail.name}"),
                                  Text("Description: ${detail.description}"),
                                  Text("Price: ${detail.price}"),
                                  Text(
                                    "Availability Status: ${detail.availibility_status}",
                                  ),
                                  Text("Author Name: ${detail.author}"),
                                  Text("Genre: ${detail.genre}"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
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

  Future delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection('book').doc(id).delete();
      Fluttertoast.showToast(msg: 'Record deleted successfully');
    } catch (e) {
      print("error:$e");
    }
  }

  void Update(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => book_update(id)),
    );
  }
}
