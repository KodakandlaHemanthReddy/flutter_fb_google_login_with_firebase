import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class DashBoardView extends StatefulWidget {
  DashBoardView({Key key,this.auth,this.user,this.googleSignIn, this.title}) : super(key: key);

  final String title;
  FirebaseAuth auth;
  FirebaseUser user;
  GoogleSignIn googleSignIn;
  @override
  DashBoardViewState createState() => DashBoardViewState();
}

class DashBoardViewState extends State<DashBoardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.user.photoUrl==null ? "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png" : widget.user.photoUrl ),
                        ),
                        Text(widget.user.displayName == null ? "": widget.user.displayName),
                        Text(widget.user.email),
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
        ),
      ),
    );
  }

  Future<void> googleSignout() async{
    await widget.auth.signOut().then((onValue){
      widget.googleSignIn.signOut();
    });
  }
  void _logOut() async {
    await widget.auth.signOut().then((response) {
      widget.googleSignIn.signOut();
      setState(() {});
    });
  }
}
