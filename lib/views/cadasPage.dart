import 'dart:io';

import 'package:alltolkit/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameCOntroler = TextEditingController();
  final _emailCOntroler = TextEditingController();
  final _phoneCOntroler = TextEditingController();


Contact _editedContact;
bool _userEdited=false;
final nameFocus=FocusNode();

  @override
  void initState() {
  super.initState();

  if(widget.contact ==null){
      _editedContact=Contact();
    }else{
    _editedContact=Contact.fromMap(widget.contact.toMap());
    _nameCOntroler.text= _editedContact.name;
    _emailCOntroler.text=_editedContact.email;
    _phoneCOntroler.text=_editedContact.phone;
  }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffe74645),
          title: Text(_editedContact.name ?? "Novo Contato"),
          centerTitle: true,

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_editedContact.name !=null &&                                                                                                                  _editedContact.name.isNotEmpty){
              Navigator.pop(context,_editedContact);
            }else{
              FocusScope.of(context).requestFocus(nameFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Color(0xfffb7756),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child:  Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editedContact.img !=null ?
                        FileImage(File(_editedContact.img)):
                        AssetImage("img/all.png"),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                    onTap: (){
                  ImagePicker.pickImage(source: ImageSource.gallery).then((file){
                    if(file ==null)return;
                    _userEdited = true;
                      setState(() {
                        _editedContact.img=file.path;

                      });
                  });


                    },
              ),
              TextField(
                controller: _nameCOntroler,
                focusNode: nameFocus,
                decoration: InputDecoration(
                    labelText: "Nome"
                ),
                onChanged: (text){
                  _userEdited=true;
                  setState(() {
                    _editedContact.name=text;
                  });
                },

              ),
              TextField(
                controller: _emailCOntroler,
                decoration: InputDecoration(
                    labelText: "Email"
                ),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.email=text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _phoneCOntroler,
                decoration: InputDecoration(
                    labelText: "Telefone"
                ),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.phone=text;

                },
                keyboardType: TextInputType.phone,

              ),
            ],
          ),
        ),
      ),
    );
  }
 Future<bool>  _requestPop(){
    if(_userEdited){
      showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Descartar Alterações?"),
          content: Text("Todas Alterações Serão Perdidas"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Continuar ?"),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      }
      );
      return Future.value(false);

    } else{
      return Future.value(true);
    }

 }
}
