import 'package:alltolkit/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginPgae extends StatefulWidget {
  @override
  _LoginPgaeState createState() => _LoginPgaeState();
}

class _LoginPgaeState extends State<LoginPgae> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/8,
          ),
          Text("Login", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30
          ),),
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
          ),

          Center(

            child: Container(
                width: 130.0,
                height: 130.0,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,

                ),
              child:FlatButton( child:  Text("G", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 80
              ),
              ),
                onPressed:(){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return HomePage();
                  }));

                },
              )


            ),

          )


        ],
      ),
      )
    );
  }
}
