class TeamInfo {
  //field name for Firestore documents
  static const COLLECTION = 'teamInfo';
  static const CREATED_BY = 'createdBy';
  static const TEAM_NAME = 'teamName';
  static const SPORT = 'sport';
  static const TEAM_MEMBERS = 'teamMembers';

  String createdBy;
  String docId;
  String teamName;
  String sport;
  List<dynamic> teamMembers; // list of all team members

  TeamInfo({
    this.docId,
    this.createdBy,
    this.teamName,
    this.sport,
    this.teamMembers,
  }) {
    this.teamMembers ??= [];
  }

  // convert Dart object to Firestore document
  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      CREATED_BY: createdBy,
      TEAM_NAME: teamName,
      SPORT: sport,
      TEAM_MEMBERS: teamMembers,
    };
  }

  // convert Firestore doc to Dart object
  static TeamInfo deserialize(Map<String, dynamic> data, String docId) {
    return TeamInfo(
      docId: docId,
      createdBy: data[TeamInfo.CREATED_BY],
      teamName: data[TeamInfo.TEAM_NAME],
      sport: data[TeamInfo.SPORT],
      teamMembers: data[TeamInfo.TEAM_MEMBERS],
    );
  }

  @override
  String toString() {
    return '$docId $createdBy $teamName $sport $teamMembers';
  }
}
