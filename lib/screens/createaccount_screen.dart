import 'package:flutter/material.dart';
import 'package:iCoachSports/controller/firebasecontroller.dart';
import 'package:iCoachSports/models/user.dart';
import 'package:iCoachSports/screens/views/mydialog.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = 'logInScreen/createAccountScreen';
  @override
  State<StatefulWidget> createState() {
    return _CreateAccountState();
  }
}

class _CreateAccountState extends State<CreateAccountScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  User user;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }
  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
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
                        validator: con.validatorEmail,
                        onSaved: con.onSavedEmail,
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
                          validator: con.validatorPassword,
                          onSaved: con.onSavedPassword),
                      Text('User Type'),
                      
                      DropdownButtonFormField(
                        hint: Text('select user type'),
                        onChanged: con.onChangedType,
                        items: con.getUserList(),
                      ),
                      RaisedButton(
                        child: Text(
                          'Create',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: con.signUp,
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
  _CreateAccountState _state;
  _Controller(this._state);
  String email;
  String password;
  User user;

  void signUp() async {
    if (!_state.formKey.currentState.validate()) return;
    _state.formKey.currentState.save();

    try {
      await FirebaseController.createAccount(email, password);
      MyDialog.info(
        context: _state.context,
        title: 'Successfully created',
        content: 'Your account is created! Go to Sign In',
      );
    } catch (e) {
      MyDialog.info(
        context: _state.context,
        title: 'Error',
        content: e.message ?? e.toString(),
      );
    }
  }

  String validatorEmail(String value) {
    if (value.contains('@') && value.contains('.'))
      return null;
    else
      return 'Invalid email';
  }

  void onSavedEmail(String value) {
    this.email = value;
  }

  String validatorPassword(String value) {
    if (value.length < 6)
      return 'min 6 chars';
    else
      return null;
  }

  void onSavedPassword(String value) {
    this.password = value;
  }

  List getUserList() {
    return Type.values.map((t) {
            return DropdownMenuItem(
              value: t,
              child: Text(t.toString().split('.')[1]),
            );
          }).toList();
  }

  void onChangedType(Type t) {
    _state.user.type = t;
  }
}
