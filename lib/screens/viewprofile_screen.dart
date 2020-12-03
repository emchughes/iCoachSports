import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/controller/firebasecontroller.dart';
import 'package:iCoachSports/models/profileInfo.dart';
import 'package:iCoachSports/screens/editprofile_screen.dart';
import 'package:iCoachSports/screens/views/mydialog.dart';
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
  var formKey = GlobalKey<FormState>();
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
    print('user: $user');
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: con.edit,
          ),
        ],
      ),
      body: profile.length == 0
          ? Text(
              'No Profile',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) => Container(
                child: ListTile(
                  leading: MyImageView.network(
                      imageUrl: profile[0].imageURL, context: context),
                  title: Text(profile[0].coachName, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35.0,),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Coach: ${profile[0].coachName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
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
  String progressMessage;
  File image;
  void edit() {
    Navigator.pushNamed(_state.context, EditProfileScreen.routeName,
        arguments: {
          'user': _state.user,
          'profileData': _state.profile,
          'image': image
        });
    _state.render(() {});
  }
}
