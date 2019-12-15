import 'package:flutter/material.dart';

class ProductCategoryWidget extends StatefulWidget {
  @override
  _ProductCategoryWidgetState createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends State<ProductCategoryWidget> {
  String activCategory = 'Vegetables';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 4.0),
        children: <Widget>[
          productCategory('Vegetables'),
          productCategory('Fruits'),
          productCategory('Organic'),
        ],
      ),
    );
  }

  Widget productCategory(String name) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                color: (activCategory == name)
                    ? null
                    : Colors.grey[600]),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          activCategory = name;
        });
      },
    );
  }
}
