import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/models/StrategyInfo.dart';
import 'package:iCoachSports/models/teamInfo.dart';

class FirebaseController {
  static Future signIn(String email, String password) async {
    UserCredential auth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
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
    filePath ??= '${StrategyInfo.IMAGE_FOLDER}/$uid/${DateTime.now()}';

     StorageUploadTask task =
        FirebaseStorage.instance.ref().child(filePath).putFile(image);
    task.events.listen((event) {
      double percentage = (event.snapshot.bytesTransferred.toDouble() /
              event.snapshot.totalByteCount.toDouble()) *
          100;
      listener(percentage);
    });
    var download = await task.onComplete;
    String url = await download.ref.getDownloadURL();
    print('===========URL: $url');
    return {'url': url, 'path': filePath};
  }

    static Future<String> addStrategy(StrategyInfo strategy) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection(TeamInfo.COLLECTION)
        .add(strategy.serialize());
    return ref.id;
  }
}
