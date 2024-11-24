import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/admin/book_details.dart';
import 'package:ebook/admin/book_update.dart';
import 'package:ebook/admin/common.dart';
import 'package:ebook/admin/book_create.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class bookRead extends StatefulWidget {
  @override
  State<bookRead> createState() => _MyWidgetState();
}

class EmpGetterSetter {
  final String id;
  final String name;
  final String genre;

  EmpGetterSetter(this.id, this.name, this.genre);
}

class _MyWidgetState extends State<bookRead> {
  @override
  void initState() {
    super.initState();
    getAllData();
  }

  List<EmpGetterSetter> mylist = [];
  bool dataa = true;

  Future<void> getAllData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('book').get();

    if (querySnapshot.docs.isEmpty) {
      setState(() {
        dataa = false;
      });
    }
    for (var document in querySnapshot.docs) {
      var id = document.id;
      var name = document['book_name'];
      var genre = document['genre'];

      setState(() {
        mylist.add(EmpGetterSetter(id, name, genre));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return User_scaffold(
      "Book Table",
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Genre')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: mylist.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(data.name)),
                    DataCell(Text(data.genre)),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => bookDetail(data.id),
                              ),
                            );
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
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

  void go() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => book_create(),
      ),
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
