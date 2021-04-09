import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {

  final Function onImageSelectPressed;

  CustomAvatar(this.onImageSelectPressed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: new Stack(
        fit: StackFit.loose,
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: 140.0,
                height: 140.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/as.jpg'),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 90.0, right: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: onImageSelectPressed,
                  height: 50,
                  shape: CircleBorder(),
                  color: Colors.red,
                  child: Center(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
