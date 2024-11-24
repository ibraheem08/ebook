import 'package:ebook/admin/author_read.dart';
import 'package:ebook/admin/book_Read.dart';
import 'package:ebook/admin/common.dart';
import 'package:ebook/admin/gen_read.dart';
import 'package:ebook/admin/orders.dart';
import 'package:ebook/admin/users/UserProfile.dart';
import 'package:ebook/homepage.dart';
import 'package:ebook/user/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
          // primarySwatch: Colors.indigo,
          ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return User_scaffold(
      "",
      ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.indigo,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(0),
              ),
            ),
            // child: Column(
            //   children: [
            //     const SizedBox(height: 50),
            //     ListTile(
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            //       title: Text('Hello world!',
            //           style: Theme.of(context)
            //               .textTheme
            //               .headlineSmall
            //               ?.copyWith(color: Colors.white)),
            //       subtitle: Text('Good Morning',
            //           style: Theme.of(context)
            //               .textTheme
            //               .titleMedium
            //               ?.copyWith(color: Colors.white54)),
            //       trailing: const CircleAvatar(
            //         radius: 30,
            //         backgroundImage: AssetImage('assets/Images/logo.png'),
            //       ),
            //     ),
            //     const SizedBox(height: 20)
            //   ],
            // ),
          ),
          Container(
            // color: Color(0xf2c1810),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(255, 178, 177, 180),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                children: [
                  InkWell(
                      onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => author_Show(),
                            ))
                          },
                      child: itemDashboard(
                        'Author',
                        CupertinoIcons.person_crop_circle_fill,
                        Colors.deepOrange,
                      )),
                  InkWell(
                      onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => gen_show(),
                            ))
                          },
                      child: itemDashboard(
                          'Genre', CupertinoIcons.person, Colors.green)),
                  InkWell(
                      onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => bookRead(),
                            ))
                          },
                      child: itemDashboard('Books',
                          CupertinoIcons.book_circle_fill, Colors.purple)),
                  InkWell(
                      onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserProfile(),
                            ))
                          },
                      child: itemDashboard(
                          'users', CupertinoIcons.person_3_fill, Colors.brown)),
                  InkWell(
                      onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => orders(),
                            ))
                          },
                      child: itemDashboard('order',
                          CupertinoIcons.money_dollar_circle, Colors.indigo)),
                  InkWell(
                      onTap: () => {signout()},
                      child: itemDashboard(
                          'logout', CupertinoIcons.add_circled, Colors.teal)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white)),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );
  void signout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }
}
