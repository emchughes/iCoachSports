import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CoachHomeScreen extends StatefulWidget {
  static const routeName = 'lohInScreen/coachHomeScreen';
  @override
  State<StatefulWidget> createState() {
    return _CoachHomeState();
  }
}

class _CoachHomeState extends State<CoachHomeScreen> {
  _Controller con;
  FirebaseUser user;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
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
      body: Column (
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
            ],
          ),
        ],),
    )
    );
  }
}

class _Controller {
  _CoachHomeState _state;
  _Controller(this._state);
}
