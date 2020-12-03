import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/controller/firebasecontroller.dart';
import 'package:iCoachSports/models/profileInfo.dart';
import 'package:iCoachSports/screens/viewprofile_screen.dart';
import 'package:iCoachSports/screens/views/mydialog.dart';
import 'package:iCoachSports/screens/views/myimageview.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/viewProfileScreen/editProfileScreen';
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfileScreen> {
  _Controller con;
  User user;
  ProfileInfo info;
  File image;
  String filePath;
  List<ProfileInfo> profile;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments;
    user ??= arg['user'];
    print('user: $user');
    profile ??= arg['profileData'];
    image ??= arg['image'];
    print('image: $image');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: con.save,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: image == null
                        ? Icon(Icons.photo_library, size: 300.0)
                        : Image.file(image, fit: BoxFit.fill),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      color: Colors.blue[200],
                      child: PopupMenuButton<String>(
                        onSelected: con.getPicture,
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'camera',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.photo_camera),
                                Text('Camera'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'gallery',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.photo_album),
                                Text('Gallery'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              con.uploadProgressMessage == null
                  ? SizedBox(
                      height: 1.0,
                    )
                  : Text(con.uploadProgressMessage,
                      style: TextStyle(fontSize: 20.0)),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                autocorrect: true,
                validator: con.validatorName,
                onSaved: con.onSavedName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _EditProfileState _state;
  _Controller(this._state);
  File image;
  String uploadProgress;
  String uploadProgressMessage;
  String coachName;

  void save() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }

    _state.formKey.currentState.save();

    try {
      MyDialog.circularProgressStart(_state.context);
      print('made it to try');
      // 1. upload pic to Storage
      Map<String, String> profileInfo = await FirebaseController.uploadStorage(
          image: _state.image,
          filePath: _state.filePath,
          uid: _state.user.uid,
          listener: (double progressPercentage) {
            _state.render(() {
              uploadProgressMessage =
                  'Uploading: ${progressPercentage.toStringAsFixed(1)} %';
            });
          });
      print('profileInfo: $profileInfo');
      //save profile info to Firestore
      var p = ProfileInfo(
        coachName: coachName,
        imagePath: profileInfo['path'],
        imageURL: profileInfo['url'],
        createdBy: _state.user.email,
      );

      p.docId = await FirebaseController.addProfileInfo(p);
      _state.profile.insert(0, p);

      await _state.user.reload();
      _state.user = FirebaseAuth.instance.currentUser;
      Navigator.pushNamed(_state.context, ViewProfileScreen.routeName,
            arguments: {'user': _state.user, 'profileData': _state.profile });
      MyDialog.circularProgressEnd(_state.context);
    } catch (e) {
      MyDialog.circularProgressEnd(_state.context);

      MyDialog.info(
        context: _state.context,
        title: 'FireBase Error',
        content: e.toString(),
      );
    }
  }

  void getPicture(String src) async {
    print('made it to get picture');
    try {
      PickedFile _imageFile;
      if (src == 'camera') {
        _imageFile = await ImagePicker().getImage(source: ImageSource.camera);
      } else {
        _imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
      }
      _state.render(() {
        _state.image = File(_imageFile.path);
      });
    } catch (e) {
      print('no get picture');
    }
  }

  String validatorName(String value) {
    if (value.length < 2) {
      return 'min 2 chars';
    } else {
      return null;
    }
  }

  void onSavedName(String value) {
    this.coachName = value;
  }
}
