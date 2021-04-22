import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Size size;

  BottomContainer({this.text, this.onPressed, this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: (size != null) ? size.height * 0.02 : 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(text),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Container(
        height: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 0.5,
              color: Colors.grey,
              margin: EdgeInsets.only(bottom: 3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(text),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
