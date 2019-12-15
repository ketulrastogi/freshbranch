import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshbranch/widgets/app_bar_widget.dart';
import 'package:freshbranch/widgets/bottom_navigation_bar_widget.dart';
import 'package:freshbranch/widgets/product_category_widget.dart';
import 'package:freshbranch/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> products = [
    {
      'name': 'Cabbage',
      'gujaratiName': 'કોબીજ',
      'price': 28,
      'unit': '1kg',
      'productUrl':
          'https://img1.exportersindia.com/product_images/bc-full/2018/9/5874570/cabbage-1536400100-4277793.jpeg',
    },
    {
      'name': 'Tomato',
      'gujaratiName': 'ટામેટા',
      'price': 12,
      'unit': '500gm',
      'productUrl':
          'https://thumbs.dreamstime.com/b/tomato-fresh-isolated-white-background-36597193.jpg',
    },
    {
      'name': 'Peas',
      'gujaratiName': 'વટાણા',
      'price': 20,
      'unit': '250gm',
      'productUrl':
          'https://thumbs.dreamstime.com/b/green-peas-fresh-white-background-40197261.jpg',
    },
    {
      'name': 'Onion',
      'gujaratiName': 'ડુંગળી',
      'price': 10,
      'unit': '1kg',
      'productUrl': 'https://thumbs.dreamstime.com/b/red-onion-25289022.jpg',
    },
    {
      'name': 'Cauliflower',
      'gujaratiName': 'ફુલાવર',
      'price': 16,
      'unit': '500gm',
      'productUrl': 'https://thumbs.dreamstime.com/b/cauliflower-3359273.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[200],
        
        body: sliverGrid(),
        bottomNavigationBar: BottomAppNavBar(),
      ),
    );
  }

  Widget sliverGrid() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          AppBarWidget(),
          ProductCategoryWidget(),
          ProductListWidget()
        ],
      ),
    );
  }
}
