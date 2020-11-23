import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CreateStrategyScreen extends StatefulWidget {
  static const routeName = '/coachHomeScreen/createStrategyScreen';
  @override
  State<StatefulWidget> createState() {
    return _CreateStrategyState();
  }
}

class _CreateStrategyState extends State<CreateStrategyScreen> {
  _Controller con;

  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

    GlobalKey globalKey = GlobalKey();

  List<TouchPoints> points = List();
  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Create Strategy'),
      ),
      body: GestureDetector(
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
    );
  }
}


class _Controller {
  _CreateStrategyState _state;
  _Controller(this._state);
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

