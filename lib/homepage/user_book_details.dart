import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/admin/book_update.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class userbookDetail extends StatefulWidget {
  String myid;

  userbookDetail(this.myid);
  @override
  State<userbookDetail> createState() => _MyWidgetState();
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

class _MyWidgetState extends State<userbookDetail> {
  @override
  void initState() {
    super.initState();
    // getAllData();
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
      print(book_name);
    });
  }

  Future<void> getAllData2(myid) async {
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    // margin: EdgeInsets.all(5.0),

                    padding: EdgeInsets.all(5),
                    child: Image.network(image),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Book Name: $book_name"),
                        Text("Description: $description"),
                        Text("Price: $price"),
                        Text("Availability Status: $availibility_status"),
                        Text("Author Name: $author_name"),
                        Text("Genre: $genre"),
                        ElevatedButton(
                            onPressed: () {
                              // addToCart("$id");  
                            },
                            child: Text("Add to Cart"))
                        // You can display other details similarly
                      ],
                    ),
                  ),
                ],
              ),
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

  // void cls() {
  //   con.text = "";
  //   con1.text = "";
  //   con3.text = "";
  // }

//   void logins(){
//      String name=con.text;
//      String pass=con1.text;

//     if(name=="irtiza"&& pass=="ahmed")
//     {

//     setState(() {
//             res="";
//              alert_func("success",Icons.check,Colors.green,"logged in");
//           });

//     }

//     else{
//        setState(() {
//             res="";
//             alert_func("failed",Icons.not_interested,Colors.red,"incorrect crendentials");
//           });
//     }
//     cls();

// }
  // void abc() {
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   CollectionReference tab = db.collection("Students");
  //   Map<String, dynamic> data = {
  //     "St_name": "con",
  //     "St_pass": "qqqqq",
  //   };
  //   tab.add(data);
  // }

//   void click() {
//     if (text == true) {
//       setState(() {
//         text = false;
//       });
//     } else if (text == false) {
//       setState(() {
//         text = true;
//       });
//     }
//   }

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

//  Future<void> addToCart(products pro) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? existingCartJson = prefs.getString("cart");

  // if (existingCartJson != null) {
  //   List<Map<String, dynamic>> existingCartMapList =
  //       jsonDecode(existingCartJson).cast<Map<String, dynamic>>();
  //   List<productsInCart> existingCartItems = existingCartMapList
  //       .map((item) => productsInCart.fromMap(item))
  //       .toList();

  //   int existingIndex =
  //       existingCartItems.indexWhere((item) => item.id == pro.id);

  //   if (existingIndex != -1) {
  //     existingCartItems[existingIndex].qty += 1;
  //   } else {
  //     productsInCart newItem =
  //         productsInCart(pro.id, pro.name, pro.desc, pro.imageUrl, 1);
  //     existingCartItems.add(newItem);
  //   }

  //   List<Map<String, dynamic>> updatedCartMapList =
  //       existingCartItems.map((item) => item.toMap()).toList();
  //   String updatedCartJson = jsonEncode(updatedCartMapList);
  //   prefs.setString("cart", updatedCartJson);
  // } else {
  //   productsInCart newItem =
  //       productsInCart(pro.id, pro.name, pro.desc, pro.imageUrl, 1);
  //   List<Map<String, dynamic>> cartMapList = [newItem.toMap()];
  //   String cartJson = jsonEncode(cartMapList);
  //   prefs.setString("cart", cartJson);
  // }

  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(builder: (context) => showcart()),
  // );
  //}
}
