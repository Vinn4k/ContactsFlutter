import 'dart:io';

import 'package:alltolkit/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper= ContactHelper();
  List<Contact> contacts=List();


  @override
  void initState() {
    super.initState();
    helper.getAllContacts().then((list){
    setState(() {
      contacts=list;
    });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Color(0xffe74645),
        centerTitle: true,
      ),
      backgroundColor: Color(0xffffffff),
      floatingActionButton: FloatingActionButton(
        onPressed: (){} ,
        child: Icon(Icons.add),
      backgroundColor: Color(0xfffb7756)),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index){
          return _ContactCard(context, index);


          }

      ),
    );
  }
  Widget _ContactCard(BuildContext context,int index){
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        color: Color(0xfffb7756),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,

                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index].img !=null ? 
                      FileImage(File(contacts[index].img)):
                          AssetImage("img/all.png")
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contacts[index].name ??"",
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 22.0, fontWeight: FontWeight.bold
                    ),
                    ),
                    Text(contacts[index].email ??"",
                      style: TextStyle(
                        color: Colors.white,
                          fontSize: 18.0, fontWeight: FontWeight.w400
                      ),
                    ),
                    Text(contacts[index].phone ??"",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0, fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
