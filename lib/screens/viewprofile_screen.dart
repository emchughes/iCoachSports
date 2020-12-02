import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/models/profileInfo.dart';
import 'package:iCoachSports/screens/views/myimageview.dart';

class ViewProfileScreen extends StatefulWidget {
  static const routeName = 'coachHomeScreen/viewProfileScreen';
  @override
  State<StatefulWidget> createState() {
    return _ViewProfileState();
  }
}

class _ViewProfileState extends State<ViewProfileScreen> {
  User user;
  _Controller con;
  String email;
  List<ProfileInfo> profile;
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
    profile ??= arg['profileData'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coach Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: profile.length == 0
          ? Text('No Profile', style: TextStyle(fontSize: 30.0))
          : ListView.builder(
              itemCount: profile.length,
              itemBuilder: (BuildContext context, int index) => Container(
                child: ListTile(
                  leading: MyImageView.network(
                      imageUrl: profile[index].imageURL, context: context),
                  title: Text(profile[index].coachName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Created by: ${profile[index].createdBy}'),
                      Text('Coach: ${profile[index].coachName}'),
                      Text('Sport: ${profile[index].sport}'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _Controller {
  _ViewProfileState _state;

  _Controller(this._state);
}
