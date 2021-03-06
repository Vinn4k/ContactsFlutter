import 'package:alltolkit/views/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPgae extends StatefulWidget {
  @override
  _LoginPgaeState createState() => _LoginPgaeState();
}

class _LoginPgaeState extends State<LoginPgae> {

  final GoogleSignIn googleSignIn=GoogleSignIn();
  FirebaseUser currentUser;


  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
        currentUser= user;

        if(currentUser !=null){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return HomePage();
          }));


        }
    });

  }
  String name;
  Future<FirebaseUser> _getuser() async{
    if(currentUser !=null)return currentUser;
    try{

      final GoogleSignInAccount googleSignInAccount=
            await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication=
            await googleSignInAccount.authentication;
      final AuthCredential credential=GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      final AuthResult authResult=
              await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user= authResult.user;
      name=currentUser.displayName;

      return user;

    }catch (error){
      return null;

    }

  }


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
                        onPressed:() async{

                       final  FirebaseUser user=await _getuser();
                       if (currentUser !=null){
                         Navigator.pop(context);
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           return HomePage();
                         }));

                       }

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

