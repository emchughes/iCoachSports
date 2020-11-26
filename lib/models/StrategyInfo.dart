class StrategyInfo {
  //field name for Firestore documents
  static const COLLECTION = 'strategies';
  static const IMAGE_FOLDER = 'strategyImages';
  //static const TEAM_NAME = 'teamName';
  static const STRATEGY_TITLE = 'strategyTitle';
  static const CREATED_BY = 'createdBy';
  static const IMAGE_URL = 'imageURL';
  static const IMAGE_PATH = 'imagePath';

  String createdBy;
  String docId;
  //String teamName;
  String strategyTitle;
  String imagePath;
  String imageURL;

  StrategyInfo({
    this.docId,
    this.createdBy,
    //this.teamName,
    this.strategyTitle,
    this.imagePath,
    this.imageURL,
  });
// convert Dart object to Firestore document
  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      STRATEGY_TITLE: strategyTitle,
      CREATED_BY: createdBy,
      //TEAM_NAME: teamName,
      IMAGE_URL: imageURL,
      IMAGE_PATH: imagePath,
    };
  }

  // convert Firestore doc to Dart object
  static StrategyInfo deserialize(Map<String, dynamic> data, String docId) {
    return StrategyInfo(
      docId: docId,
      createdBy: data[StrategyInfo.CREATED_BY],
      //teamName: data[StrategyInfo.TEAM_NAME],
      strategyTitle: data[StrategyInfo.STRATEGY_TITLE],
      imageURL: data[StrategyInfo.IMAGE_URL],
      imagePath: data[StrategyInfo.IMAGE_PATH],

    );
  }

  @override
  String toString() {
    return '$docId $createdBy $strategyTitle \n $imageURL';
  }
}
