// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ebook/admin/gen_update.dart';
// import 'package:ebook/admin/gen_create.dart';
// import 'package:ebook/admin/common.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class gen_show extends StatefulWidget {
//   @override
//   State<gen_show> createState() => _MyWidgetState();
// }

// class EmpGetterSetter {
//   final String id;
//   final String name;
//   final String image;

//   EmpGetterSetter(this.id, this.name, this.image);
// }

// class _MyWidgetState extends State<gen_show> {
//   @override
//   void initState() {
//     super.initState();
//     getAllData();
//   }

//   List<EmpGetterSetter> mylist = [];
//   bool dataa = true;
//   Future<void> getAllData() async {
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('genre').get();

//     if (querySnapshot.docs.isEmpty) {
//       setState(() {
//         dataa = false;
//       });
//     }
//     for (var document in querySnapshot.docs) {
//       var id = document.id;
//       var name = document['genre_name'];
//       var image = document['Image'];

//       setState(() {
//         mylist.add(EmpGetterSetter(id, name, image));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return User_scaffold(
//       "gen TABLE",
//       Column(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 dataa
//                     ? Expanded(
//                         child: ListView.builder(
//                           itemCount: mylist.length,
//                           itemBuilder: (context, index) {
//                             return Dismissible(
//                               key: Key(mylist[index].id),
//                               onDismissed: (direction) {
//                                 delete(mylist[index].id);
//                                 setState(() {
//                                   mylist.removeAt(index);
//                                 });

//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                         content: Text(
//                                   "${mylist[index].name} dismissed",
//                                 )));
//                               },
//                               child: ListTile(
//                                   leading: Container(
//                                     width: 100,
//                                     height: 100,
//                                     child: Image.network(mylist[index].image),
//                                   ),
//                                   title: Text("${index}",
//                                       style: TextStyle(fontSize: 20)),
//                                   subtitle: Text(
//                                       "genre : ${mylist[index].name}",
//                                       style: TextStyle(fontSize: 20)),
//                                   trailing: Column(
//                                     children: [
//                                       IconButton(
//                                           onPressed: () {
//                                             update(mylist[index].id);
//                                           },
//                                           icon: Icon(Icons.edit)),
//                                     ],
//                                   )),
//                             );
//                           },
//                         ),
//                       )
//                     : Text("No data found"),
//               ],
//             ),
//           )
//         ],
//       ),
//       floating: FloatingActionButton(
//         onPressed: () {
//           go();
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.grey,
//         foregroundColor: Colors.black,
//         hoverColor: Colors.red,
//         highlightElevation: 50,
//         tooltip: 'Add',
//         shape: CircleBorder(),
//       ),
//       floatinglocation: FloatingActionButtonLocation.startFloat,
//     );
//   }

//   Future delete(String id) async {
//     try {
//       await FirebaseFirestore.instance.collection('genre').doc(id).delete();
//       Fluttertoast.showToast(msg: 'Record deleted successfully');
//     } catch (e) {
//       print("error:$e");
//     }
//   }

//   void go() {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => genCreate(),
//         ));
//   }

//   void alert_func(String title, IconData i, Color c, String txt) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Column(children: [
//             Icon(
//               i,
//               color: c,
//             ),
//             Text(title),
//           ]),
//           content: Text(txt),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // void cls() {
//   //   con.text = "";
//   //   con1.text = "";
//   //   con3.text = "";
//   // }

// //   void logins(){
// //      String name=con.text;
// //      String pass=con1.text;

// //     if(name=="irtiza"&& pass=="ahmed")
// //     {

// //     setState(() {
// //             res="";
// //              alert_func("success",Icons.check,Colors.green,"logged in");
// //           });

// //     }

// //     else{
// //        setState(() {
// //             res="";
// //             alert_func("failed",Icons.not_interested,Colors.red,"incorrect crendentials");
// //           });
// //     }
// //     cls();

// // }
//   // void abc() {
//   //   FirebaseFirestore db = FirebaseFirestore.instance;
//   //   CollectionReference tab = db.collection("Students");
//   //   Map<String, dynamic> data = {
//   //     "St_name": "con",
//   //     "St_pass": "qqqqq",
//   //   };
//   //   tab.add(data);
//   // }

// //   void click() {
// //     if (text == true) {
// //       setState(() {
// //         text = false;
// //       });
// //     } else if (text == false) {
// //       setState(() {
// //         text = true;
// //       });
// //     }
// //   }

//   void update(String id) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => gen_update(id)),
//     );
//   }

//   Edit(String id) {}
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/admin/gen_update.dart';
import 'package:ebook/admin/gen_create.dart';
import 'package:ebook/admin/common.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class gen_show extends StatefulWidget {
  @override
  State<gen_show> createState() => _MyWidgetState();
}

class EmpGetterSetter {
  final String id;
  final String name;
  final String image;

  EmpGetterSetter(this.id, this.name, this.image);
}

class _MyWidgetState extends State<gen_show> {
  @override
  void initState() {
    super.initState();
    getAllData();
  }

  List<EmpGetterSetter> mylist = [];
  bool dataa = true;

  Future<void> getAllData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('genre').get();

    if (querySnapshot.docs.isEmpty) {
      setState(() {
        dataa = false;
      });
    }
    for (var document in querySnapshot.docs) {
      var id = document.id;
      var name = document['genre_name'];
      var image = document['Image'];

      setState(() {
        mylist.add(EmpGetterSetter(id, name, image));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return User_scaffold(
      "GENRE TABLE",
      Column(
        children: [
          Expanded(
            child: dataa
                ? ListView.builder(
                    itemCount: mylist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                mylist[index].image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              "${mylist[index].name}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    update(mylist[index].id);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    delete(mylist[index].id);
                                  },
                                ),
                              ],
                            ),
                            // onTap: () {
                            //   update(mylist[index].id);
                            // },
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No data found",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
          ),
        ],
      ),
      floating: FloatingActionButton(
        onPressed: () {
          go();
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 233, 128, 118),
        foregroundColor: Colors.black,
        hoverColor: Colors.red,
        highlightElevation: 50,
        tooltip: 'Add',
        shape: CircleBorder(),
      ),
      floatinglocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection('genre').doc(id).delete();
      Fluttertoast.showToast(msg: 'Record deleted successfully');
    } catch (e) {
      print("error:$e");
    }
  }

  void go() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => genCreate(),
      ),
    );
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

  void update(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gen_update(id)),
    );
  }

  Edit(String id) {}
}
