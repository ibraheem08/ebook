import 'package:ebook/homepage/genredetail.dart';
import 'package:flutter/material.dart';

import 'color.dart';

// ignore: must_be_immutable
class CategoryCard extends StatefulWidget {
  String id;

  String txt;
  CategoryCard(
    this.txt,
    this.id,
  );

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                showdetailby(widget.txt);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                  color: KFourthColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.txt,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: KPrimaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
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
