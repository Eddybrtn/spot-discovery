import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_discovery/core/viewmodels/my_model.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyModel>(
      builder: (context, MyModel model, child) {
        return Scaffold(
          body: Center(
              child: RaisedButton(
            child: Text(model.myVariable),
            onPressed: () {
              model.updateMyVariable("New text");
            },
          )),
        );
      },
    );
  }
}

class MyWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RaisedButton(
        child: Text(context.watch<MyModel>().myVariable),
        onPressed: () {
          context.read<MyModel>().updateMyVariable("New text");
        },
      )),
    );
  }
}
