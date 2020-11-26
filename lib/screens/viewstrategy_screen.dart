import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iCoachSports/models/StrategyInfo.dart';
import 'package:iCoachSports/screens/views/myimageview.dart';

class ViewStrategyScreen extends StatefulWidget {
  static const routeName = 'coachHomeScreen/viewStrategyScreen';

  @override
  State<StatefulWidget> createState() {
    return _ViewStrategyState();
  }
}

class _ViewStrategyState extends State<ViewStrategyScreen> {
  _Controller con;
  User user;
  String email;
  List<StrategyInfo> strategies;
  var formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);
  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments;
    print('View Strategies...arguments: $arg');
    user ??= arg['user'];
    strategies ??= arg['strategyList'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Strategies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: strategies.length == 0
          ? Text('No Strategies', style: TextStyle(fontSize: 30.0))
          : ListView.builder(
              itemCount: strategies.length,
              itemBuilder: (BuildContext context, int index) => Container(
                child: ListTile(
                  leading: MyImageView.network(
                        imageUrl: strategies[index].imageURL, context: context),
                  title: Text(strategies[index].strategyTitle),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Created by: ${strategies[index].createdBy}'),
                      Text('Strategy title: ${strategies[index].strategyTitle}'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _Controller {
  _ViewStrategyState _state;

  _Controller(this._state);
}

