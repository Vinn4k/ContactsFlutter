import 'package:alltolkit/helpers/contact_helper.dart';
import 'package:flutter/material.dart';


class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

Contact _editedContact;
  @override
  void initState() {
  super.initState();

  if(widget.contact ==null){
      _editedContact=Contact();
    }else{
    _editedContact=Contact.fromMap(widget.contact.toMap());
  }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
