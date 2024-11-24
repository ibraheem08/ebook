import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _MyWidgetState();
}

class products {
  String id;
  String name;
  String email;
  products(this.id, this.name, this.email);
}

class _MyWidgetState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetching"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "All Users",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Data found"));
                  }
                  var myydata = snapshot.data?.docs;
                  List<products> mylist = [];
                  for (var x in myydata!) {
                    mylist.add(products(x.id, x['Fullname'], x['Email']));
                  }
                  return ListView.builder(
                    itemCount: mylist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        elevation: 2,
                        child: ListTile(
                          title: Text(mylist[index].name),
                          subtitle: Text(mylist[index].email.toString()),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
