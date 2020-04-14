
import 'package:flutter/material.dart';
import 'package:fluttergooglesigninapp/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashScreenBloc _splashScreenBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashScreenBloc = SplashScreenBloc();
    _splashScreenBloc.init();
    _splashScreenBloc.startTimer(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _splashScreenBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 80,),
      ),
    );
  }
}
