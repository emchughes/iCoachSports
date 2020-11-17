import 'package:flutter/material.dart';
import 'package:iCoachSports/screens/addteam_screen.dart';
import 'package:iCoachSports/screens/coachhome_screen.dart';
import 'package:iCoachSports/screens/createaccount_screen.dart';
import 'package:iCoachSports/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ICoachSportsApp());
}

class ICoachSportsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.catamaranTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Colors.green[300],
        ),
        initialRoute: LogInScreen.routeName,
        routes: {
          LogInScreen.routeName: (context) => LogInScreen(),
          CreateAccountScreen.routeName: (context) => CreateAccountScreen(),
          CoachHomeScreen.routeName: (context) => CoachHomeScreen(),
          AddTeamScreen.routeName: (context) => AddTeamScreen(),
        });
  }
}
