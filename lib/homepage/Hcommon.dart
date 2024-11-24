import 'package:ebook/homepage.dart';
import 'package:ebook/homepage/cart.dart';
import 'package:ebook/homepage/color.dart';
import 'package:ebook/homepage/seeall.dart';
import 'package:ebook/user/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class home extends StatefulWidget {
  Widget body_cont;
  home(this.body_cont, {required AppBar appBar});

  State<home> createState() => _homeState();
}

int index = 0;

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Expanded(
            child: Container(
          decoration: BoxDecoration(),
          child: widget.body_cont,
        )),
        bottomNavigationBar: BottomAppBar(
          //   shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          //   color: Colors.black,
          //   notchMargin: 0,

          child: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: index,
              backgroundColor: Colors.transparent,
              iconSize: 20,
              onTap: (value) {
                setState(() {
                  index = value;
                });
                if (value == 0) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
                }
                if (value == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => seeall(),
                  ));
                }
                if (value == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => cart(),
                  ));
                }
                if (value == 3) {
                  signout();
                }
              },
              items: [
                BottomNavigationBarItem(
                  backgroundColor: KFourthColor,
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  backgroundColor: KFourthColor,
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  backgroundColor: KFourthColor,
                  icon: Icon(Icons.shop_2),
                  label: 'Add to Cart',
                ),
                BottomNavigationBarItem(
                  backgroundColor: KFourthColor,
                  icon: Icon(Icons.logout),
                  label: 'Logout',
                ),
              ]),
        ));
  }

  void signout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }
}
