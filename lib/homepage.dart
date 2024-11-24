import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/homepage/Hcommon.dart';
import 'package:ebook/homepage/author_books_details.dart';

import 'package:flutter/material.dart';
import 'homepage/banner.dart';
import 'homepage/category.dart';
import 'homepage/itemcards.dart';
import 'homepage/trends.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class EmpGetterSetter {
  final String id;
  final String name;
  final String imagee;
  final String genre;

  EmpGetterSetter(this.id, this.name, this.imagee, this.genre);
}

class _HomePageState extends State<HomePage> {
  List<EmpGetterSetter> mylist = [];
  List<GenGetterSetter> genlist = [];
  List<AuthGetterSetter> authlist = [];
  void initState() {
    super.initState();
    getAllBooks();
    getAllGenre();
    getAllAuthors();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    queryData.devicePixelRatio;
    queryData.size.width;
    queryData.size.height;

    return home(
      appBar: AppBar(),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            BannerSection(),
            SizedBox(height: 5),
            Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genlist.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                        genlist[index].genre, genlist[index].id);
                  },
                )),
            SizedBox(height: 5),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: authlist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                auth_bookDetails(authlist[index].name),
                          ));
                    },
                    child: ItemCards(
                      imagepic: authlist[index].imagee,
                      text1: authlist[index].name,
                      text2: authlist[index].DOB,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            Trends(),
            SizedBox(height: 10),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mylist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ItemCards(
                      imagepic: mylist[index].imagee,
                      text1: mylist[index].name,
                      text2: mylist[index].genre,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5)
          ],
        ),
      ),
    );
  }

  Future<void> getAllBooks() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('book').get();

    for (var document in querySnapshot.docs) {
      var id = document.id;
      var name = document['book_name'];
      var img = document['Image'];
      var genre = document['genre'];

      setState(() {
        mylist.add(EmpGetterSetter(id, name, img, genre));
      });
    }
  }

  Future<void> getAllGenre() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('genre').get();

    for (var document in querySnapshot.docs) {
      var id = document.id;
      var img = document['Image'];
      var genre = document['genre_name'];

      setState(() {
        genlist.add(GenGetterSetter(id, img, genre));
      });
    }
  }

  Future<void> getAllAuthors() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('author').get();

    for (var document in querySnapshot.docs) {
      var id = document.id;
      var img = document['Image'];
      var name = document['author_name'];
      var DOB = document['DOB'];

      setState(() {
        authlist.add(AuthGetterSetter(id, img, name, DOB));
      });
    }
  }
}

class AuthGetterSetter {
  final String id;
  final String name;
  final String imagee;
  final String DOB;

  AuthGetterSetter(this.id, this.imagee, this.name, this.DOB);
}

class GenGetterSetter {
  final String id;
  final String imagee;
  final String genre;

  GenGetterSetter(this.id, this.imagee, this.genre);
}
