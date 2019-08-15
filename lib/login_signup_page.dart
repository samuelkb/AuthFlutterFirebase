import 'package:flutter/material.dart';

class LoginSignUpPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();

}

class _LoginSignUpPageState extends State<LoginSignUpPage>{
  bool _isIos;
  bool _isLoading; /// we check on it whether now the screen is loading or not.

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter login demo'),
        ),
        body: Stack(
          children: <Widget>[
            //_showBody(),
            //_showCircularProgress(),
          ],
        ));
  }

  ///  show user a circular loading indicator, when any login or sign up activity is running.
  Widget _showCircularProgress(){
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } return Container(height: 0.0, width: 0.0,);

  }
}