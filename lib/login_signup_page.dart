import 'package:flutter/material.dart';

class LoginSignUpPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();

}

/// enum to keep track whether the form is for login or signup.
enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage>{
  /// A key that is unique across the entire app.
  /// Global keys uniquely identify elements. Global keys provide access to other objects that are
  /// associated with elements, such as the a BuildContext and, for StatefulWidgets, a State
  final _formKey = new GlobalKey<FormState>();

  bool _isIos; ///We add an identifier for Ios devices
  bool _isLoading; /// we check on it whether now the screen is loading or not.
  String _email;
  String _password;
  String _errorMessage; /// Store the error message from Firebase
  FormMode _formMode = FormMode.LOGIN; /// Initial form is login form


  /// We use this method to set initial values/state to our application.
  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter login demo'),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
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

  /// Widget for the button callback function.
  /// method called _validateAndSubmit that will pass in both email and password for Firebase authentication.
  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: null, //_validateAndSubmit
          ),
        ));
  }


  /// Secondary button for user to be able to toggle between signup and login form.
  /// 'onPressed' method, we would like to toggle the state of the form between LOGIN and SIGNUP.
  /// Using FlatButton instead of RaisedButton, if you would like to make 1 more distinctive than the other:
  /// RaisedButton -> instantly catches the users’ attention
  /// FlatButton -> has less attention
  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
          style:
          new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  /// wraping _formMode around setState as we need to tell Flutter to re-render the screen with updated value.
  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  /// We pass the error message to user from Firebase side when they are trying to do login or signup.
  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  /// arrange previous individual UI components and put it back to our ListView.
  Widget _showBody(){
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }
}