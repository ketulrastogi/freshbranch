import 'package:flutter/material.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Text(
                'Order Status',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey[50],
                        blurRadius: 4.0,
                        spreadRadius: 1.0)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Your Order ID',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'PTN-10254L',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[100],
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0)
                            ]),
                        child: Text(
                          'Cancel Order',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.check_box,
                                      size: 32.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    child: Text(
                                      'Order Placed',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Text(
                                  '12:55 PM',
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.check_box_outline_blank,
                                      size: 32.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    child: Text(
                                      'Order Confirmed',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                            color: Colors.grey[500],
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Text(
                                  '12:55 PM',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        color: Colors.grey[500],
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.check_box_outline_blank,
                                      size: 32.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    child: Text(
                                      'Order Dispatched',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                            color: Colors.grey[500],
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Text(
                                  '12:55 PM',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        color: Colors.grey[500],
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.check_box_outline_blank,
                                      size: 32.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    child: Text(
                                      'Order Delivered',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                            color: Colors.grey[500],
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Text(
                                  '12:55 PM',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        color: Colors.grey[500],
                                      ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Order Details',
                        style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 16.0
                        ),),
                    
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey[500],
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey[50],
                        blurRadius: 4.0,
                        spreadRadius: 1.0)
                  ]),
              child: Center(
                child: Text('View All Order History',
                          style: Theme.of(context).textTheme.title.copyWith(
                            // fontSize: 20.0,
                            color: Colors.white
                          ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
