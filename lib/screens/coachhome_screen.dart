import 'package:flutter/material.dart';

import 'addteam_screen.dart';

class CoachHomeScreen extends StatelessWidget {
  static const routeName = 'lohInScreen/coachHomeScreen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'iCoachSports',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/LogInScreen.jpg',
                    height: 603,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        child: Text(
                          'Add New Team',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () => Navigator.pushNamed(
                            context, AddTeamScreen.routeName),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
