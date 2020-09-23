import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginPgae extends StatefulWidget {
  @override
  _LoginPgaeState createState() => _LoginPgaeState();
}

class _LoginPgaeState extends State<LoginPgae> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
        width: 90.0,
        height: 90.0,

        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          )
          )


        ],
      ),
      
    );
  }
}
