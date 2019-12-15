import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        backgroundColor: Colors.red,
        content: Container(
          height: 48.0,
          // padding: EdgeInsets.all(8.0),
          width: double.infinity,
          // color: Colors.red,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 24.0,
                  width: 24.0,
                  margin: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Icon(Icons.error, color: Colors.white, size: 24.0,),),
              Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }