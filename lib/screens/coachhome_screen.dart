import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/models/teamInfo.dart';

import 'addteam_screen.dart';

class CoachHomeScreen extends StatefulWidget {
  static const routeName = '/signInScreen/homeScreen';
  @override
  State<StatefulWidget> createState() {
    return _CoachHomeState();
  }
}
class _CoachHomeState extends State<CoachHomeScreen> {
    _Controller con;
  User user;
   List<TeamInfo> teams;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {

        Map arg = ModalRoute.of(context).settings.arguments;
    user ??= arg['user'];
    teams ??= arg['teamList'];
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
        body: Column(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        child: Text(
                          'Add New Team',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: con.addTeamButton,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _CoachHomeState _state;
  int delIndex;
  String searchKey;

  _Controller(this._state);

  void addTeamButton() async {
    //navigate to AddScreen
    await Navigator.pushNamed(_state.context, AddTeamScreen.routeName,
        arguments: {'user': _state.user, 'teamList': _state.teams});
    _state.render(() {});
  }
}
