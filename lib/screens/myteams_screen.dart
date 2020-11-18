import 'package:flutter/material.dart';

class MyTeamsScreen extends StatelessWidget {
  static const routeName = '/myTeamsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          title: Text(
            'My Teams',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Text('my teams')
    );
  }
}
