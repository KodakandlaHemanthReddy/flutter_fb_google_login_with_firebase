import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergooglesigninapp/bloc/login_bloc.dart';
import 'package:fluttergooglesigninapp/ui/dashboard_view.dart';
import 'package:fluttergooglesigninapp/ui/login_view.dart';
import 'package:fluttergooglesigninapp/ui/splash_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_auth_flutter/simple_auth_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
LoginBloc _loginBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.init();
    SimpleAuthFlutter.init(context);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.yellow,
        brightness: Brightness.light,
          textTheme: TextTheme(
        headline: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 12.0,))
      ),
      darkTheme: ThemeData(
          primarySwatch: Colors.pink,
          primaryColor: Colors.green,
    accentColor: Colors.cyan[600],
    brightness: Brightness.dark,
    textTheme: TextTheme(
    headline: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
    body1: TextStyle(fontSize: 12.0,))
      ),
      home: StreamBuilder(
        stream: _loginBloc.loggedUser,
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot){
          print("snapshot ${snapshot.data}");
          if(snapshot.data != null){
            return DashBoardView();
          } else{
            return LoginView();
          }
          }),
    );
  }
}

