class ProfileInfo {
  //field name for Firestore documents
  static const COLLECTION = 'profilePics';
  static const CREATED_BY = 'cretedBy';
  static const IMAGE_FOLDER = 'profilePictures';
  static const COACH_NAME = 'coachName';
  static const IMAGE_URL = 'imageURL';
  static const IMAGE_PATH = 'imagePath';
  static const SPORT = 'sport';

  String createdBy;
  String docId;
  String coachName;
  String imagePath;
  String imageURL;
  String sport;

  ProfileInfo({
    this.createdBy,
    this.docId,
    this.coachName,
    this.imagePath,
    this.imageURL,
    this.sport,
  });
// convert Dart object to Firestore document
  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      CREATED_BY: createdBy,
      COACH_NAME: coachName,
      IMAGE_URL: imageURL,
      IMAGE_PATH: imagePath,
      SPORT: sport,
    };
  }

  // convert Firestore doc to Dart object
  static ProfileInfo deserialize(Map<String, dynamic> data, String docId) {
    return ProfileInfo(
      createdBy: data[ProfileInfo.CREATED_BY],
      docId: docId,
      coachName: data[ProfileInfo.COACH_NAME],
      imageURL: data[ProfileInfo.IMAGE_URL],
      imagePath: data[ProfileInfo.IMAGE_PATH],
      sport: data[ProfileInfo.SPORT],
    );
  }

  @override
  String toString() {
    return '$docId $createdBy $coachName $sport \n $imageURL';
  }
}
