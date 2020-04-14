import 'package:flutter/material.dart';
import 'package:fluttergooglesigninapp/bloc/login_bloc.dart';


class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Email SignIn"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
              child: TextFormField(
                controller: _loginBloc.emailController,
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
                controller: _loginBloc.passwordController,
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
                          _loginBloc.isTapped = !_loginBloc.isTapped;
                        });
                      },
                      child: _loginBloc.isTapped ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                    ),
                    hintStyle: TextStyle(fontSize: 12.0)),
                keyboardType: TextInputType.text,
                obscureText: !_loginBloc.isTapped,
              ),
            ),
            RaisedButton(
              onPressed: () {
                _loginBloc.signUpWithEmail(_loginBloc.emailController.text, _loginBloc.passwordController.text,context);
              },
              child: new Text("Sign Up" ),
              color: Colors.green,
            ),
            RaisedButton(
              onPressed: () {
                _loginBloc.signInWithEmail(_loginBloc.emailController.text, _loginBloc.passwordController.text,context);
              },
              child: new Text("Sign In" ),
              color: Colors.green,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.center,
              child: Text("OR"),
            ),
            RaisedButton(
              onPressed: () {
                _loginBloc.handleSignIn(context);
              },
              child: new Text("Sign In with Google"),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
