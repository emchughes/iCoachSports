import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/controller/firebasecontroller.dart';
import 'package:iCoachSports/models/teamInfo.dart';
import 'package:iCoachSports/screens/myteams_screen.dart';
import 'package:iCoachSports/screens/views/mydialog.dart';

class AddTeamScreen extends StatefulWidget {
  static const routeName = 'logInScreen/coachHomeScreen/addTeamScreen';
  @override
  State<StatefulWidget> createState() {
    return _AddTeamState();
  }
}

class _AddTeamState extends State<AddTeamScreen> {
  _Controller con;
  User user;
  var formKey = GlobalKey<FormState>();
  List<TeamInfo> teams;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    user ??= args['user'];
    teams = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Team',
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
                          hintText: 'Team Name',
                        ),
                        onSaved: con.onSavedTeamName,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Sport',
                        ),
                        onSaved: con.onSavedSport,
                      ),
                      RaisedButton(
                        child: Text(
                          'Add Team',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: con.save,
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
  _AddTeamState _state;
  _Controller(this._state);
  String teamName;
  String sport;
  String email;

  void save() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }

    _state.formKey.currentState.save();
    User user;
    try {
      MyDialog.circularProgressStart(_state.context);

      // 3. save teamInfo document to Firestore
      var t = TeamInfo(
        teamName: teamName,
        sport: sport,
        createdBy: email,
      );

      t.docId = await FirebaseController.addTeamInfo(t);
      // print('state: $_state');
      // _state.teams.insert(0, t);

      List<TeamInfo> teams = await FirebaseController.getTeamInfo(email);
      MyDialog.circularProgressEnd(_state.context);
      // 2. navigate to my teams screen to display teams
      Navigator.pushReplacementNamed(_state.context, MyTeamsScreen.routeName,
          arguments: {'user': user, 'teamsList': teams});

      //Navigator.pushNamed(_state.context, MyTeamsScreen.routeName);
    } catch (e) {
      MyDialog.circularProgressEnd(_state.context);

      MyDialog.info(
        context: _state.context,
        title: 'FireBase Error',
        content: e.toString(),
      );
      return;
    }
  }

  void onSavedTeamName(String value) {
    teamName = value;
  }

  void onSavedSport(String value) {
    sport = value;
  }
}
