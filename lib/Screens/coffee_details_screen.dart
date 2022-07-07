import 'package:flutter/material.dart';

class CoffeeDetailsScreen extends StatefulWidget {

  @override
  _CoffeeDetailsScreenState createState() => _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends State<CoffeeDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: Colors.brown),
        ),
        body: Center(
          child: Icon(Icons.wb_incandescent_rounded),
        )
    );
  }
}
