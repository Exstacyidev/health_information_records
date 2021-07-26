import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth  _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future signInWithGoogle() async {
    //Trigger Authentication Flow
    try{
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      print(googleUser);

      //Obtaining authentication details from the request
      if(googleUser !=null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        print(googleAuth);

        //Creating new credentials
        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        print(credential);

        User user = (await _auth.signInWithCredential(credential)).user;
        print(user.providerData);
      }

    }catch(e) {
      print(e);
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print('User signed out');
  }
}