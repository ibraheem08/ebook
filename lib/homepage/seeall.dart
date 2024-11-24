import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/homepage/Hcommon.dart';
import 'package:ebook/homepage/color.dart';
import 'package:ebook/homepage/screens/searchscreen.dart';
import 'package:ebook/homepage/user_book_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class seeall extends StatefulWidget {
  @override
  State<seeall> createState() => _seeallState();
  int index = 1;
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

class _seeallState extends State<seeall> {
  void initState() {
    super.initState();
    // getAllData();
    getAllData2("");
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

  // Future<void> getAllData1(myid) async {
  //   DocumentSnapshot data = await FirebaseFirestore.instance
  //       .collection("book")
  //       .doc(widget.myid)
  //       .get();
  //   setState(() {
  //     id = data.id;
  //     book_name = data["book_name"];
  //     description = data["description"];
  //     price = data["Price"];
  //     availibility_status = data["availibility_status"];
  //     author_name = data["author_name"];
  //     genre = data["genre"];
  //     image = data["Image"];
  //     print(book_name);
  //   });
  // }

  Future<void> getAllData2(bname) async {
    if (bname == "") {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('book').get();

      if (querySnapshot.docs.isEmpty) {
        setState(() {
          dataa = false;
        });
      }
      for (var data in querySnapshot.docs) {
        var id = data.id;
        var book_name = data["book_name"];
        var description = data["description"];
        var price = data["Price"];
        var availibility_status = data["availibility_status"];
        var author = data["author_name"];
        var genre = data["genre"];
        var image = data["Image"];

        setState(() {
          details.add(EmpGetterSetter(id, book_name, description, price,
              availibility_status, author, genre, image));
        });
      }
    } else {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('book')
          .where("book_name", isEqualTo: bname)
          .get();

      if (querySnapshot.docs.isEmpty) {
        setState(() {
          dataa = false;
        });
      }
      for (var data in querySnapshot.docs) {
        var id = data.id;
        var book_name = data["book_name"];
        var description = data["description"];
        var price = data["Price"];
        var availibility_status = data["availibility_status"];
        var author = data["author_name"];
        var genre = data["genre"];
        var image = data["Image"];

        setState(() {
          details.add(EmpGetterSetter(id, book_name, description, price,
              availibility_status, author, genre, image));
        });
      }
    }
  }

  bool dataa = true;
  TextEditingController search_text = TextEditingController();
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
      return home(
          appBar: AppBar(
            title: Text('All BOOKS'),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: KPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onDoubleTap: () {
                        setState(() {
                          details.clear(); // Clear existing data
                          getAllData2(search_text
                              .text); // Fetch data based on search text
                        });
                      },
                      child: TextFormField(
                        controller: search_text,
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            'assets/icons/search.svg',
                            color: KFourthColor,
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: KFourthColor,
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    userbookDetail(details[index].id),
                              ));
                        },
                        child: TopSearch(
                          image: "${details[index].image}",
                          text1: "${details[index].name}",
                          text2: "Price ${details[index].price}",
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ));
    }
  }

  void search() {}
}
