import 'package:flutter/material.dart';
import 'package:freshbranch/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: InkWell(
            onTap: (){
              auth.signOut();
            },
            child: Text(auth.user.email))
        ),
      ),
    );
  }
}