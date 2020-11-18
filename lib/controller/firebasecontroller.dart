import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(TeamInfo.COLLECTION).get();

    var result = <TeamInfo>[];
    if (querySnapshot != null && querySnapshot.docs.length != 0) {
      for (var doc in querySnapshot.docs) {
        result.add(TeamInfo.deserialize(doc.data(), doc.id));
      }
    }
    return result;
  }
}
