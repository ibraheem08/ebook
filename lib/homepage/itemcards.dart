import 'package:ebook/homepage/genredetail.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class ItemCards extends StatefulWidget {
  const ItemCards({
    Key? key,
    required this.imagepic,
    required this.text1,
    required this.text2,
  }) : super(key: key);
  final String imagepic;
  final String text1;
  final String text2;

  @override
  State<ItemCards> createState() => _ItemCardsState();
  // String id;
}

class _ItemCardsState extends State<ItemCards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              color: KFourthColor,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.imagepic),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            widget.text1,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: KFifthColor,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: KFifthColor.withOpacity(0.7),
              ),
            )
          ],
        ),
      ],
    );
  }

  void showdetailby(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => bookDetails(id),
        ));
  }
}
