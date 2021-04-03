import 'package:flutter/material.dart';

import '../../../constants.dart';

class PersonalInfoEditStateComponent extends StatelessWidget {

  final Function onTapped;
  final bool status;
  PersonalInfoEditStateComponent({this.onTapped, this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Personal Information', style: kBodyTextStyle),
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              status ? _getEditIcon() : new Container(),
            ],
          )
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(),
      child: new InkWell(
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: new CircleAvatar(
            backgroundColor: Colors.red,
            radius: 14.0,
            child: new Icon(
              Icons.edit,
              color: Colors.white,
              size: 16.0,
            ),
          ),
        ),
        onTap: onTapped,
      ),
    );
  }

}
