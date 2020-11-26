import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/screens/addteam_screen.dart';
import 'package:iCoachSports/screens/coachhome_screen.dart';
import 'package:iCoachSports/screens/createaccount_screen.dart';
import 'package:iCoachSports/screens/createstrategy_screen.dart';
import 'package:iCoachSports/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iCoachSports/screens/myteams_screen.dart';
import 'package:iCoachSports/screens/viewstrategy_screen.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          MyTeamsScreen.routeName: (context) => MyTeamsScreen(),
          CreateStrategyScreen.routeName: (context) => CreateStrategyScreen(),
          ViewStrategyScreen.routeName: (context) => ViewStrategyScreen(),
        });
  }
}
