import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/controller/firebasecontroller.dart';
import 'package:iCoachSports/models/teamInfo.dart';

class MyTeamsScreen extends StatefulWidget {
  static const routeName = 'coachHomeScreen/myTeamsScreen';

  @override
  State<StatefulWidget> createState() {
    return _MyTeamsState();
  }
}

class _MyTeamsState extends State<MyTeamsScreen> {
  _Controller con;
  User user;
  String email;
  List<TeamInfo> teams;
  var formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);
  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments;
    print('arguments: $arg');
    user ??= arg['user'];
    teams ??= arg['teamsList'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Teams',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: teams.length == 0
          ? Text('No Teams', style: TextStyle(fontSize: 30.0))
          : ListView.builder(
              itemCount: teams.length,
              itemBuilder: (BuildContext context, int index) => Container(
                child: ListTile(
                  title: Text(teams[index].teamName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Created by: ${teams[index].createdBy}'),
                      Text('Team Name: ${teams[index].teamName}'),
                      Text('Sport: ${teams[index].sport}'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _Controller {
  _MyTeamsState _state;

  _Controller(this._state);
}
