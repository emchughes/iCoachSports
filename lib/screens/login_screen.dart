import 'package:flutter/material.dart';
import 'package:iCoachSports/screens/createaccount_screen.dart';

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
                        // validator: con.validatorEmail,
                        // onSaved: con.onSavedEmail,
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
                        //validator: con.validatorPassword,
                        //onSaved: con.onSavedPassword
                      ),
                      RaisedButton(
                        onPressed: null,//con.signIn,
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
                        onPressed: () => Navigator.pushNamed(context, CreateAccountScreen.routeName),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.blue[400],
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

  // void signIn() async {
  //   if (!_state.formKey.currentState.validate()) {
  //     return;
  //   }

  //   _state.formKey.currentState.save();

  //   MyDialog.circularProgressStart(_state.context);

  //   FirebaseUser user;
  //   try {
  //     user = await FirebaseController.signIn(email, password);
  //     print('USER: $user');
  //   } catch (e) {
  //     MyDialog.circularProgressEnd(_state.context);
  //     MyDialog.info(
  //       context: _state.context,
  //       title: 'Sign In Error',
  //       content: e.message ?? e.toString(),
  //     );
  //     return;
  //   }
}
