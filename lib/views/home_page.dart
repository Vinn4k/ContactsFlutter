import 'dart:io';
import 'package:expansion_card/expansion_card.dart';
import 'package:alltolkit/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cadasPage.dart';





enum orderOptions{orderaz,orderza}

class HomePage extends StatefulWidget {
  static String tag='Home-Page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper= ContactHelper();
  List<Contact> contacts=List();


  @override
  void initState() {
    super.initState();
    _getAllcontacts();

  }

  static const cor1 =0xff86dab7;
  static const cor2 =0xff59b48f;
  static const cor3 =0xff0eb269;
  static const branco =0xfff2f9f6;
  static int _currentindex=0;
  static final pages=[
    ContactPage.tag
  ];






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos. "),
        backgroundColor: Color(cor3),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<orderOptions>(
            itemBuilder: (context)=> <PopupMenuEntry<orderOptions>>[
              const PopupMenuItem<orderOptions>(
                child: Text("Az"),
                value: orderOptions.orderaz,
              ),
              const PopupMenuItem<orderOptions>(
                child: Text("Za"),
                value: orderOptions.orderza,
              ),
              const PopupMenuItem<orderOptions>(
                child: Text("Deslogar"),
                value: orderOptions.orderza,
              ),

            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Color(0xffffffff),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _ShowContactpage();
        } ,
        child: Icon(Icons.add),
      backgroundColor: Color(0xfffb7756)),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index){
          return _ContactCard(context, index);


          }

      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(cor3),
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title: Text("Adicionar"),
        backgroundColor: Colors.amber


    ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("data"),
              backgroundColor: Color(cor3)
          ),
        ],
        onTap: (int i){
          _currentindex=i;
        Navigator.of(context).pushNamed(pages[_currentindex]);
        },

      ),
    );
  }
  Widget _ContactCard(BuildContext context,int index){
    return Card(
      color: Color(cor2),
      child: GestureDetector(

        child: ExpansionCard(


       title: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(

                  width: 80.0,
                  height: 80.0,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: contacts[index].img !=null ?
                        FileImage(File(contacts[index].img)):
                            AssetImage("img/all.png"),
                         fit: BoxFit.cover

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
                          color: Colors.black,
                        fontSize: 22.0, fontWeight: FontWeight.bold
                      ),
                      ),
                      Text(contacts[index].email ??"",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0, fontWeight: FontWeight.w400
                        ),
                      ),
                      Text(contacts[index].phone ??"",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0, fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          children: [
            Container(
              child: Center(

                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child:   FlatButton(
                            color: Color(branco),
                            child:Icon(Icons.call, color: Color(cor3),),
                            onPressed: (){
                              launch("tel: ${contacts[index].phone}");
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: FlatButton(
                            color: Color(branco),
                            child:Icon(Icons.edit, color: Color(cor3),),
                            onPressed: (){
                              Navigator.pop(context);
                              _ShowContactpage(contact: contacts[index]);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: FlatButton(
                            color: Color(branco),
                            child:Icon(Icons.delete, color: Color(cor3),),
                            onPressed: (){
                              helper.deleteContact(contacts[index].id);
                              setState(() {
                                contacts.removeAt(index);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )


              ),
            )

          ],
        ),
        onTap: (){

        },
      ),

    );
  }


  void _ShowContactpage ({Contact contact}) async {
 final recContact=  await Navigator.push(context,
     MaterialPageRoute(builder: (context) => ContactPage(contact: contact,)),
   );
 if(recContact !=null){
   if(contact !=null){
     await helper.updateContact(recContact);
      _getAllcontacts();
   }else{
     await helper.saveContact(recContact);
   }
   _getAllcontacts();

 }
}
void _getAllcontacts (){
  helper.getAllContacts().then((list){
    setState(() {
      contacts=list;
    });
  });
}

  void _orderList(orderOptions result){
    switch(result){
      case orderOptions.orderaz:
        contacts.sort((a, b){
   return   a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case orderOptions.orderza:
        contacts.sort((a, b){
       return   b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {

    });
  }
}
