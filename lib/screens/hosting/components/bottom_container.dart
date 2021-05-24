import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Size size;
  final Key key;
  bool isActivated;

  BottomContainer(
      {this.text,
      this.onPressed,
      this.size,
      this.isActivated,
      @required this.key});

  @override
  Widget build(BuildContext context) {
    if(this.isActivated == null){
      this.isActivated = true;
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: (size != null) ? size.height * 0.02 : 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (this.isActivated) ...[
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
          ] else ...[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightBlue[200],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
