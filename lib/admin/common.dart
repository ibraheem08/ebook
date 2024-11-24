import 'package:ebook/admin/author_create.dart';
import 'package:ebook/admin/dashboard.dart';
import 'package:ebook/admin/gen_create.dart';
import 'package:ebook/admin/book_create.dart';
import 'package:ebook/user/signin_screen.dart';
import 'package:ebook/user/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class User_scaffold extends StatefulWidget {
  Widget myscaffold;
  String title;
  Color? background;
  FloatingActionButton? floating;
  FloatingActionButtonLocation? floatinglocation;

  // BottomNavigationBar? bottomNavigation

  User_scaffold(
    this.title,
    this.myscaffold, {
    this.background,
    this.floating,
    this.floatinglocation,
  });

  @override
  State<User_scaffold> createState() => _User_scaffoldState();
}

class _User_scaffoldState extends State<User_scaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE65C4F),
        toolbarHeight: 80,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu_sharp));
        }),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // margin: EdgeInsets.only(left: 20),
                width: 250,
                height: 400,
                child: Image.asset(
                  "assets/Images/Banner.png",
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              // color: Color.fromARGB(255, 236, 234, 234),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: Colors.grey,
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 3)
              ]),
        ),
      ),
      drawer: Drawer(
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Color.fromARGB(255, 228, 139, 131),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Images/logo.png"))),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Men menu",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Divider(),
            ),
            ListTile(
              leading: Icon(
                Icons.message,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyApp(),
                ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.message,
                color: Colors.white,
              ),
              title: Text(
                "Author",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => authorCreate(),
                ));
              },
            ),
            // Divider(),
            // ListTile(
            //   leading: Icon(
            //     Icons.calculate_outlined,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     "author show",
            //     style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => author_Show(),
            //     ));
            //   },
            // ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.calculate,
                color: Colors.white,
              ),
              title: Text(
                "Genre",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => genCreate(),
                ));
              },
            ),
            // Divider(),
            // ListTile(
            //   leading: Icon(
            //     Icons.calculate_outlined,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     "Genre show",
            //     style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => cat_Show(),
            //     ));
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(
            //     Icons.calculate_outlined,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     "Books",
            //     style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => bookRead(),
            //     ));
            //   },
            // ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.calculate_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Books",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => book_create(),
                ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.calculate_outlined,
                color: Colors.white,
              ),
              title: Text(
                "logout",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                signout();
              },
            ),
            // Divider(),
          ],
        ),
      ),
      body: widget.myscaffold,
      backgroundColor: widget.background,
      floatingActionButton: widget.floating,
      floatingActionButtonLocation: widget.floatinglocation,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      //   backgroundColor: Color.fromARGB(255, 60, 57, 57),
      //   foregroundColor: Colors.white,
      //   hoverColor: const Color.fromARGB(255, 132, 126, 126),
      //   highlightElevation: 50,
      //   tooltip: 'ADD',
      //   shape: CircleBorder(),
      // ),
    );
  }

  void signout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }
}
