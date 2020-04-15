
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttergooglesigninapp/bloc/dashboard_bloc.dart';


class DashBoardView extends StatefulWidget {
  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {

  DashBoardBloc _dashBoardBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashBoardBloc = DashBoardBloc();
    _dashBoardBloc.init();
    Timer(Duration(seconds: 2), (){
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dashBoardBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("DashBoard"),
      ),
      body: _dashBoardBloc.loggedUser != null ? Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
          backgroundImage: NetworkImage(_dashBoardBloc.loggedUser.photoUrl == null ? "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png" : _dashBoardBloc.loggedUser.photoUrl ),
      ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_dashBoardBloc.loggedUser.displayName == null ? "": _dashBoardBloc.loggedUser.displayName),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_dashBoardBloc.loggedUser.email),
        ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("user token ${_dashBoardBloc.loggedUser.uid}",),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                _dashBoardBloc.signOut(context);
              },
              child: new Text("Sign Out"),
              color: Colors.green,
            ),
          ),]
          ),
        ),
      ) : Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
