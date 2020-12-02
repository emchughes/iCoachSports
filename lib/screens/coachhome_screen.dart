import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/controller/firebasecontroller.dart';
import 'package:iCoachSports/models/StrategyInfo.dart';
import 'package:iCoachSports/models/profileInfo.dart';
import 'package:iCoachSports/models/teamInfo.dart';
import 'package:iCoachSports/screens/createstrategy_screen.dart';
import 'package:iCoachSports/screens/myteams_screen.dart';
import 'package:iCoachSports/screens/viewprofile_screen.dart';
import 'package:iCoachSports/screens/views/mydialog.dart';
import 'package:iCoachSports/screens/viewstrategy_screen.dart';

import 'addteam_screen.dart';

class CoachHomeScreen extends StatefulWidget {
  static const routeName = '/logInScreen/coachHomeScreen';
  @override
  State<StatefulWidget> createState() {
    return _CoachHomeState();
  }
}

class _CoachHomeState extends State<CoachHomeScreen> {
  _Controller con;
  User user;
  List<TeamInfo> teams;
  List<StrategyInfo> strategies;
  ProfileInfo profile;

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
    print('user from home screen: $user');
    teams ??= arg['teamList'];
    strategies ??= arg['strategiesList'];
    profile ??= arg['profileData'];
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
        body: SingleChildScrollView(
          child: Stack(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      child: Text(
                        'View My Teams',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: con.viewTeamsButton,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      child: Text(
                        'Create Strategy',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: con.createStrategyButton,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      child: Text(
                        'View Strategy',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: con.viewStrategyButton,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      child: Text(
                        'View Profile',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: con.viewProfile,
                    ),
                  ),
                ],
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
        ),
      ),
    );
  }
}

class _Controller {
  _CoachHomeState _state;
  _Controller(this._state);
  String email;
  User user;

  void addTeamButton() async {
    //navigate to AddScreen
    print('Add team State: $_state');
    await Navigator.pushNamed(_state.context, AddTeamScreen.routeName,
        arguments: {'user': _state.user, 'teamList': _state.teams});
    _state.render(() {});
  }

  void viewProfile() async {
    //navigate to Profile page
    try {
      MyDialog.circularProgressStart(_state.context);
      List<ProfileInfo> profile =
          await FirebaseController.getProfileInfo(email);
      MyDialog.circularProgressEnd(_state.context);

      Navigator.pushNamed(_state.context, ViewProfileScreen.routeName,
          arguments: {'user': _state.user, 'profileData': profile});
    } catch (e) {
      MyDialog.circularProgressEnd(_state.context);
      MyDialog.info(
        context: _state.context,
        title: 'Firebase/Firestore error',
        content: 'Cannot get team info. Try again later!',
      );
      return;
    }
  }

  void viewTeamsButton() async {
    //navigate to myTeams screen
    try {
      MyDialog.circularProgressStart(_state.context);
      List<TeamInfo> teams = await FirebaseController.getTeamInfo(email);
      MyDialog.circularProgressEnd(_state.context);

      Navigator.pushNamed(_state.context, MyTeamsScreen.routeName,
          arguments: {'user': user, 'teamsList': teams});
    } catch (e) {
      MyDialog.circularProgressEnd(_state.context);
      MyDialog.info(
        context: _state.context,
        title: 'Firebase/Firestore error',
        content: 'Cannot get team info. Try again later!',
      );
      return;
    }
  }

  void createStrategyButton() async {
    User user;
    List<StrategyInfo> strategies =
        await FirebaseController.getStrategyInfo(email);
    Navigator.pushNamed(_state.context, CreateStrategyScreen.routeName,
        arguments: {'user': user, 'strategyList': strategies});
    _state.render(() {});
  }

  void viewStrategyButton() async {
    //navigate to View Strategy screen

    User user;
    try {
      MyDialog.circularProgressStart(_state.context);
      List<StrategyInfo> strategies =
          await FirebaseController.getStrategyInfo(email);
      MyDialog.circularProgressEnd(_state.context);

      Navigator.pushNamed(_state.context, ViewStrategyScreen.routeName,
          arguments: {'user': user, 'strategyList': strategies});
    } catch (e) {
      MyDialog.circularProgressEnd(_state.context);
      MyDialog.info(
        context: _state.context,
        title: 'Firebase/Firestore error',
        content: 'Cannot get strategy info. Try again later!',
      );
      return;
    }
  }
}
