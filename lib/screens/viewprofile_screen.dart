import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {
  static const routeName = 'coachHomeScreen/viewProfileScreen';
  @override
  State<StatefulWidget> createState() {
    return _ViewProfileState();
  }
}

class _ViewProfileState extends State<ViewProfileScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Profile'),
      ),
      body: Text('view Profile'),
    );
  }
}
