import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/admin/author_create.dart';
import 'package:ebook/admin/author_update.dart';
import 'package:ebook/admin/common.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class author_Show extends StatefulWidget {
  @override
  State<author_Show> createState() => _MyWidgetState();
}

class EmpGetterSetter {
  final String id;
  final String name;
  final String image;
  final String DOB;

  EmpGetterSetter(this.id, this.name, this.image, this.DOB);
}

class _MyWidgetState extends State<author_Show> {
  @override
  void initState() {
    super.initState();
    getAllData();
  }

  List<EmpGetterSetter> mylist = [];
  bool dataa = true;

  Future<void> getAllData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('author').get();

    if (querySnapshot.docs.isEmpty) {
      setState(() {
        dataa = false;
      });
    }
    for (var document in querySnapshot.docs) {
      var id = document.id;
      var name = document['author_name'];
      var DOB = document['DOB'];
      var image = document['Image'];

      setState(() {
        mylist.add(EmpGetterSetter(id, name, image, DOB));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return User_scaffold(
      "AUTHOR TABLE",
      Column(
        children: [
          Expanded(
            child: dataa
                ? ListView.builder(
                    itemCount: mylist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 12.0),
                        child: Card(
                          elevation: 2.0,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10.10),
                              child: Image.network(
                                mylist[index].image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              "${mylist[index].name}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${mylist[index].DOB}",
                              style: TextStyle(
                                fontSize: 18,
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
                                  icon: Icon(
                                    Icons.delete,
                                  ),
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
      await FirebaseFirestore.instance.collection('author').doc(id).delete();
      Fluttertoast.showToast(msg: 'Record deleted successfully');
    } catch (e) {
      print("error:$e");
    }
  }

  void go() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => authorCreate(),
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
      MaterialPageRoute(builder: (context) => author_update(id)),
    );
  }

  category_update(String id) {}
}
