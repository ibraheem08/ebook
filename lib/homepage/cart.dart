import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/admin/common.dart';
import 'package:ebook/homepage/Hcommon.dart';
import 'package:flutter/material.dart';

class cart extends StatefulWidget {
  @override
  State<cart> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    return home(
      appBar: AppBar(),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "this page in under working",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
