import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/admin/book_update.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class bookDetail extends StatefulWidget {
  String myid;

  bookDetail(this.myid);
  @override
  State<bookDetail> createState() => _MyWidgetState();
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

  EmpGetterSetter(this.id, this.name, this.genre, this.price,
      this.availibility_status, this.image, this.author, this.description);
}

class _MyWidgetState extends State<bookDetail> {
  @override
  void initState() {
    super.initState();
    getAllData1(widget.myid);
  }

  List<EmpGetterSetter> details = [];
  var id;
  var book_name;
  var description;
  var price;
  var availibility_status;
  var author_name;
  var genre;
  var image;

  Future<void> getAllData1(myid) async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection("book")
        .doc(widget.myid)
        .get();
    setState(() {
      id = data.id;
      book_name = data["book_name"];
      description = data["description"];
      price = data["Price"];
      availibility_status = data["availibility_status"];
      author_name = data["author_name"];
      genre = data["genre"];
      image = data["Image"];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (book_name == null) {
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
          title: Text('BOOK Detail TABLE'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.network(image),
                    ),
                    SizedBox(height: 10),
                    Text("Book Name: $book_name"),
                    SizedBox(height: 5),
                    Text("Description: $description"),
                    SizedBox(height: 5),
                    Text("Price: $price"),
                    SizedBox(height: 5),
                    Text("Availability Status: $availibility_status"),
                    SizedBox(height: 5),
                    Text("Author Name: $author_name"),
                    SizedBox(height: 5),
                    Text("Genre: $genre"),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            delete(id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            Update(id);
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
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
