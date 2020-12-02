import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iCoachSports/models/StrategyInfo.dart';
import 'package:iCoachSports/models/profileInfo.dart';
import 'package:iCoachSports/models/teamInfo.dart';
import 'dart:typed_data';
//import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class FirebaseController {
  static Future signIn(String email, String password) async {
    UserCredential auth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print('sign in user: $auth.user');
    return auth.user;
  }

  static Future<void> createAccount(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<String> addTeamInfo(TeamInfo team) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection(TeamInfo.COLLECTION)
        .add(team.serialize());
    return ref.id;
  }

  static Future<List<TeamInfo>> getTeamInfo(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(TeamInfo.COLLECTION)
        .where(TeamInfo.CREATED_BY, isEqualTo: email)
        .orderBy(TeamInfo.TEAM_NAME, descending: true)
        .get();

    var result = <TeamInfo>[];
    if (querySnapshot != null && querySnapshot.docs.length != 0) {
      for (var doc in querySnapshot.docs) {
        result.add(TeamInfo.deserialize(doc.data(), doc.id));
      }
    }
    return result;
  }

  static Future<List<ProfileInfo>> getProfileInfo(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(ProfileInfo.COLLECTION)
        .where(ProfileInfo.CREATED_BY, isEqualTo: email)
        .orderBy(ProfileInfo.COACH_NAME, descending: true)
        .get();

    var result = <ProfileInfo>[];
    if (querySnapshot != null && querySnapshot.docs.length != 0) {
      for (var doc in querySnapshot.docs) {
        result.add(ProfileInfo.deserialize(doc.data(), doc.id));
      }
    }
    return result;
  }

  static Future<List<StrategyInfo>> getStrategyInfo(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(StrategyInfo.COLLECTION)
        .where(StrategyInfo.CREATED_BY, isEqualTo: email)
        .orderBy(StrategyInfo.STRATEGY_TITLE, descending: true)
        .get();

    var result = <StrategyInfo>[];
    if (querySnapshot != null && querySnapshot.docs.length != 0) {
      for (var doc in querySnapshot.docs) {
        result.add(StrategyInfo.deserialize(doc.data(), doc.id));
      }
    }
    return result;
  }

  static Future<Map<String, String>> uploadStorage({
    @required File image,
    String filePath,
    @required String uid,
    @required Function listener,
  }) async {
    print('made it to uploadStorage!');
    filePath ??= '${ProfileInfo.IMAGE_FOLDER}/$uid}';
    print('made it past filePath');
    StorageUploadTask task =
        FirebaseStorage.instance.ref().child(filePath).putFile(image);
    task.events.listen((event) {
      double percentage = (event.snapshot.bytesTransferred.toDouble() /
              event.snapshot.totalByteCount.toDouble()) *
          100;
      listener(percentage);
    });
    print('made it pastlistener');
    var download = await task.onComplete;
    String url = await download.ref.getDownloadURL();
    return {'url': url, 'path': filePath};
  }

  static Future uploadImageToFirebase(File imageFile) async {
    print('made it to uploadImage');
    //File imageFile;
    String fileName = Path.basename(imageFile.path);
    print('fileName: $fileName');
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    print('firebaseStorageRef: $firebaseStorageRef');

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    print('uploadTask: $uploadTask');
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print('taskSnapshot: $taskSnapshot');

    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  static Future<String> addStrategy(StrategyInfo strategy) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection(TeamInfo.COLLECTION)
        .add(strategy.serialize());
    return ref.id;
  }

  static Future<void> updatePhotoMemo(ProfileInfo photoMemo) async {
    await FirebaseFirestore.instance
        .collection(ProfileInfo.COLLECTION)
        .doc(photoMemo.docId)
        .set(photoMemo.serialize());
  }

  static Future<String> addProfileInfo(ProfileInfo profile) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection(ProfileInfo.COLLECTION)
        .add(profile.serialize());
    return ref.id;
  }
  //convert to file to upload
//   final formkey = GlobalKey<FormState>();
//   Uint8List image;
//   Future<void> getImage() async {
//     //Uint8List tempImg = await ImagePickerWeb.getImage(outputType: ImageType.bytes);
//     Uint8List bytesFromPicker =
//         await ImagePicker.getImage(asUint8List: true);

//     if (bytesFromPicker != null) {
//       debugPrint(bytesFromPicker.toString());
//  if (tempImg != null) {
//   setState(() async {
//     image = tempImg;
//     final tempDir = await getTemporaryDirectory();
//     final file = await new File('${tempDir.path}/image.jpg').create();
//     file.writeAsBytesSync(image);
//     });
//    }
//   }
// }
//}
}
