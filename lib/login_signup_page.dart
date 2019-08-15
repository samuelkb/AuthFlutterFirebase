import 'package:flutter/material.dart';

class LoginSignUpPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();

}

class _LoginSignUpPageState extends State<LoginSignUpPage>{
  bool _isIos;
  bool _isLoading; /// we check on it whether now the screen is loading or not.
  String _email;
  String _password;

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

  /// We just place one widget inside a padding widget and use padding: EdgeInsets.fromLTRB()
  /// which means from left, top, right and bottom and enter the value of padding at correct position accordingly.
  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/flutter-icon.png'),
        ),
      ),
    );
  }

  /// Email field has validator and onSaved. These 2 callbacks will be triggered when form.validate()
  /// and form.save() is called. If form.save() is called, the value in the text form field is copied
  /// into another local variable.
  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(), ///trim method to value to remove unintentional leading or trailing white spaces.
      ),
    );
  }

  /// Password field has validator and onSaved. These 2 callbacks will be triggered when form.validate()
  /// and form.save() is called. If form.save() is called, the value in the text form field is copied
  /// into another local variable. I set obscureText: true to hide user password.
  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(), ///trim method to value to remove unintentional leading or trailing white spaces.
      ),
    );
  }


}