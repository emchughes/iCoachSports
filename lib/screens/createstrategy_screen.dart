import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iCoachSports/controller/firebasecontroller.dart';
import 'package:iCoachSports/models/StrategyInfo.dart';
import 'package:iCoachSports/screens/viewstrategy_screen.dart';
import 'package:iCoachSports/screens/views/mydialog.dart';

class CreateStrategyScreen extends StatefulWidget {
  static const routeName = '/coachHomeScreen/createStrategyScreen';
  @override
  State<StatefulWidget> createState() {
    return _CreateStrategyState();
  }
}

class _CreateStrategyState extends State<CreateStrategyScreen> {
  _Controller con;
  File image;
  User user;
  List<StrategyInfo> strategies;
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey globalKey = GlobalKey();

  List<TouchPoints> points = List();

  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments;
    print('Create Strategy arguments: $arg');
    user ??= arg['user'];
    strategies ??= arg['strategyList'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Strategy'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: con.save,
          ),
        ],
      ),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(TouchPoints(
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeType
                    ..isAntiAlias = true
                    ..color = Colors.white.withOpacity(opacity)
                    ..strokeWidth = strokeWidth));
            });
          },
          onPanStart: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(TouchPoints(
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeType
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth));
            });
          },
          onPanEnd: (details) {
            setState(() {
              points.add(null);
            });
          },
          child: RepaintBoundary(
            key: globalKey,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/images/SoccerBoard.png',
                    height: 602,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                CustomPaint(
                  size: Size.infinite,
                  painter: MyPainter(
                    pointsList: points,
                  ),
                ),
                FloatingActionButton(
                    heroTag: "erase",
                    child: Icon(Icons.clear),
                    tooltip: "Erase",
                    onPressed: () {
                      setState(() {
                        points.clear();
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _CreateStrategyState _state;
  _Controller(this._state);
  String uploadProgressMessage;
  String strategyTitle;
  String strategyTeamName;
  String email;

  // void generateImage() async {
  //   print('GenerateImage...user: $_state.user, uid: $_state.uid');
  //   //final color = Colors.primaries[widget.rd.nextInt(widget.numColors)];
  //   final recorder = ui.PictureRecorder();
  //   final canvas = Canvas(recorder,
  //       Rect.fromPoints(Offset(0.0, 0.0), Offset(canvasSize, canvasSize)));
  //           final stroke = Paint()
  //     ..color = Colors.grey
  //     ..style = PaintingStyle.stroke;

  //   canvas.drawRect(Rect.fromLTWH(0.0, 0.0, canvasSize, canvasSize), stroke);

  //   final paint = Paint()
  //    // ..color = color
  //     ..style = PaintingStyle.fill;

  //   // canvas.drawCircle(
  //   //     Offset(
  //   //       widget.rd.nextDouble() * canvasSize,
  //   //       widget.rd.nextDouble() * canvasSize,
  //   //     ),
  //   //     20.0,
  //   //     paint);
  //   final picture = recorder.endRecording();
  //   final img = await picture.toImage(200, 200);
  //   final pngBytes = await img.toByteData(format: ImageByteFormat.png);

  //   // setState(() {
  //   //   imgBytes = pngBytes;
  //   // });
  //   save();
  // }

  void save() async {
    User user;
 List<StrategyInfo> strategies = await FirebaseController.getStrategyInfo(email);
      Navigator.pushNamed(_state.context, ViewStrategyScreen.routeName,
          arguments: {'user': user, 'strategyList': strategies});

    // print('Save...user: $_state.user, uid: $_state.uid');

    // if (!_state.formKey.currentState.validate()) {
    //   return;
    // }
    // _state.formKey.currentState.save();

    // Map<String, String> imageInfo = await FirebaseController.uploadStorage(
    //   image: _state.image,
    //   uid: _state.user.uid,
    //   listener: (double progressPercentage) {
    //     _state.render(() {
    //       uploadProgressMessage =
    //           'Uploading: ${progressPercentage.toStringAsFixed(1)} %';
    //     });
    //   },
    // );
    // print('=========: ${imageInfo["path"]}');
    // print('=========: ${imageInfo["url"]}');

    // try {
    //   MyDialog.circularProgressStart(_state.context);

    //   // 1. upload pic to Storage
    //   Map<String, String> imageInfo = await FirebaseController.uploadStorage(
    //       image: _state.image,
    //       uid: _state.user.uid,
    //       listener: (double progressPercentage) {
    //         _state.render(() {
    //           uploadProgressMessage =
    //               'Uploading: ${progressPercentage.toStringAsFixed(1)} %';
    //         });
    //       });
    //   // 2. save strategy document to Firestore
    //   var s = StrategyInfo(
    //     strategyTitle: strategyTitle,
    //     imagePath: imageInfo['path'],
    //     imageURL: imageInfo['url'],
    //     createdBy: _state.user.email,
    //   );

    //   s.docId = await FirebaseController.addStrategy(s);
    //   _state.strategies.insert(0, s);
    //   List<StrategyInfo> strategies =
    //       await FirebaseController.getStrategyInfo(email);
    //   MyDialog.circularProgressEnd(_state.context);
    //   // 2. navigate to my teams screen to display teams
    //   Navigator.pushReplacementNamed(
    //       _state.context, ViewStrategyScreen.routeName,
    //       arguments: {'user': user, 'stategyList': strategies});

    //   MyDialog.circularProgressEnd(_state.context);

    //   Navigator.pushNamed(_state.context, ViewStrategyScreen.routeName);
    // } catch (e) {
    //   MyDialog.circularProgressEnd(_state.context);

    //   MyDialog.info(
    //     context: _state.context,
    //     title: 'FireBase Error',
    //     content: e.message ?? e.toString(),
    //   );
    // }
  }

  String validatorStrategyTitle(String value) {
    if (value.length < 2)
      return 'min 2 charaters';
    else
      return null;
  }

  void onSavedStrategyTitle(String value) {
    this.strategyTitle = value;
  }

  String validatorStrategyTeamName(String value) {
    if (value.length < 2)
      return 'min 2 charaters';
    else
      return null;
  }

  void onSavedStrategyTeamName(String value) {
    this.strategyTeamName = value;
  }
}

class TouchPoints {
  Paint paint;
  Offset points;
  TouchPoints({this.points, this.paint});
}

class MyPainter extends CustomPainter {
  MyPainter({this.pointsList});
  List<TouchPoints> pointsList;
  List<Offset> offsetPoints = List();

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        canvas.drawPoints(
            ui.PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}
