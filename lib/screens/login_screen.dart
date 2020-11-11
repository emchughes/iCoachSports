import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/logInScreen';
  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogInScreen> {
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
          'iCoachSports',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/LogInScreen.jpg',
                      height: 603,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          icon: Icon(Icons.email),
                          hintText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          icon: Icon(Icons.lock),
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        autocorrect: false,
                      ),
                      RaisedButton(
                        onPressed: null,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.blue[200],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RaisedButton(
                        onPressed: null,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.blue[200],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _LogInState _state;
  _Controller(this._state);
  String email;
  String password;
}
