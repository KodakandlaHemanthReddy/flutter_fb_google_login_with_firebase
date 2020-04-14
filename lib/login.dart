import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttergooglesigninapp/dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,this.auth,this.user,this.googleSignIn, this.title}) : super(key: key);

  final String title;
  FirebaseAuth auth;
  FirebaseUser user;
  GoogleSignIn googleSignIn;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool isTapped = false;
  bool isSignedUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: new InputDecoration(
                    focusColor: const Color(0xffff6771),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)),
                        borderSide: BorderSide(
                            style: BorderStyle.none,
                            width: 0.0)),
                    contentPadding: EdgeInsets.only(
                        top: 13.0, bottom: 13.0, left: 10.0),
                    filled: true,
                    fillColor: Colors.grey[300],
                    hintText: 'Your Email',
                    hintStyle: TextStyle(fontSize: 12.0)),
                keyboardType: TextInputType.text,

              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: new InputDecoration(
                    focusColor: const Color(0xffff6771),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)),
                        borderSide: BorderSide(
                            style: BorderStyle.none,
                            width: 0.0)),
                    contentPadding: EdgeInsets.only(
                        top: 13.0, bottom: 13.0, left: 10.0),
                    filled: true,
                    fillColor: Colors.grey[300],
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          isTapped = !isTapped;
                        });
                      },
                      child: isTapped ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                    ),
                    hintStyle: TextStyle(fontSize: 12.0)),
                keyboardType: TextInputType.text,
                obscureText: !isTapped,
              ),
            ),
            RaisedButton(
              onPressed: () {
                signUpWithEmail(_emailController.text, _passwordController.text);
              },
              child: new Text("Sign Up" ),
              color: Colors.green,
            ),
            RaisedButton(
              onPressed: () {
                signInWithEmail(_emailController.text, _passwordController.text);
              },
              child: new Text("Sign In" ),
              color: Colors.green,
            ),
            RaisedButton(
              onPressed: () {
                sendSignInWithEmailLink(_emailController.text);
              },
              child: new Text("Sign In with link" ),
              color: Colors.green,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.center,
              child: Text("OR"),
            ),
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
            ),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
bool isSignIn = false;

  Future<void> handleSignIn() async
  {
    print("entered login");
    GoogleSignInAccount googleSignInAccount = await widget.googleSignIn.signIn();
    print("sign in");
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    print("Success print");
    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("signed in");
    AuthResult result = (await widget.auth.signInWithCredential(credential));
    print("login");
  }



  void _logIn() {
    _loginWithFacebook().then((response) {
      if (response != null) {
        widget.user = response;
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

  Future<FirebaseUser> signInWithEmail(String email, String password) async {
    var user = await widget.auth.signInWithEmailAndPassword(email: email, password: password);
    setState(() {
//      isSignedUp = true;
      isSignIn = true;
    });
    print("email auth ${user.user.photoUrl}");
    return user.user;
  }

  Future<FirebaseUser> signUpWithEmail(String email, String password) async {
    var user = await widget.auth.createUserWithEmailAndPassword(email: email, password: password);
    setState(() {
//      isSignIn = true;
      isSignedUp = true;
    });
    print("signup email auth ${user.user.toString()}");
    return user.user;
  }

  Future<void> sendSignInWithEmailLink(String email) async {
    print("email sign in link");
    return widget.auth.sendSignInWithEmailLink(
        email: email,
        url: "https://fluttergooglesigninapp.page.link",
        handleCodeInApp: true,
        iOSBundleID: 'com.firebasebootcamp.fluttergooglesigninapp',
        androidPackageName: 'com.firebasebootcamp.fluttergooglesigninapp',
        androidInstallIfNotAvailable: true,
        androidMinimumVersion: "21");
  }
}