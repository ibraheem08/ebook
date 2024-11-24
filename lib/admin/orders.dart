import 'package:ebook/admin/common.dart';
import 'package:ebook/admin/users/UserProfile.dart';
import 'package:ebook/homepage/Hcommon.dart';
import 'package:ebook/homepage/color.dart';
import 'package:flutter/material.dart';

class orders extends StatefulWidget {
  const orders({Key? key}) : super(key: key);

  @override
  State<orders> createState() => _BookMarkState();
}

class _BookMarkState extends State<orders> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return User_scaffold(
      'Orders',
      Center(
        child: Text(
          'Oops!\nNo Orders added',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: KFifthColor,
          ),
        ),
      ),
    );
  }
}
