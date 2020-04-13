import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: isSignIn ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(_user.photoUrl),
            ),
            Text(_user.displayName),
            Text(_user.email),
            RaisedButton(
              onPressed: () {
                googleSignout();
                _logOut();
              },
              child: new Text("Sign Out"),
              color: Colors.green,
            ),
          ],
        ),
      ) : Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                handleSignIn();
              },
              child: new Text("Sign In with Google"),
              color: Colors.green,
            ),
            RaisedButton(
              onPressed: () {
                _logIn();
              },
              child: new Text("Sign In with FaceBook"),
              color: Colors.green,
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
bool isSignIn = false;

  Future<void> handleSignIn() async
  {
    print("entered login");
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    print("sign in");
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    print("Success print");
    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("signed in");
    AuthResult result = (await _auth.signInWithCredential(credential));
    print("login");
    _user = result.user;
    setState(() {
      isSignIn = true;
    });
  }

  Future<void> googleSignout() async{
    await _auth.signOut().then((onValue){
      _googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    });
  }
  void _logOut() async {
    await _auth.signOut().then((response) {
      isSignIn = false;
      setState(() {});
    });
  }

  void _logIn() {
    _loginWithFacebook().then((response) {
      if (response != null) {
        _user = response;
        isSignIn = true;
        setState(() {});
      }
    });
  }
  Future<FirebaseUser> _loginWithFacebook() async {
    FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
    final accessToken = facebookLoginResult.accessToken.token;
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      final facebookAuthCred =
      FacebookAuthProvider.getCredential(accessToken: accessToken);
      final user = await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);
      print("User :  + ${user.user.displayName}");
      return user.user;
    }
  }

  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Logged In");
        break;
    }
    return facebookLoginResult;
  }

}