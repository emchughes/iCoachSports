import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = '/createAccountScreen';
  @override
  State<StatefulWidget> createState() {
    return _CreateAccountState();
  }
}

class _CreateAccountState extends State<CreateAccountScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Text('create Account'),
    );
  }
}

class _Controller {
  _CreateAccountState _state;
  _Controller(this._state);
  String email;
  String password;
}
