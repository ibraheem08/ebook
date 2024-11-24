import 'package:ebook/homepage/Hcommon.dart';
import 'package:ebook/homepage/color.dart';
import 'package:flutter/material.dart';

class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return home(
      appBar: AppBar(),
      Center(
        child: Text(
          'Oops!\nNo Book Marks added',
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
