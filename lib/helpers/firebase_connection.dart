import 'package:firebase/firebase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


final GoogleSignIn googleSignIn=GoogleSignIn();
FirebaseUser _currentUser;
Future<FirebaseUser> _getuser() async{
  if(_currentUser !=null)return _currentUser;
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
    name=_currentUser.displayName;

    return user;

  }catch (error){
    return null;

  }

}