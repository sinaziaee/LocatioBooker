import 'package:flutter/material.dart';

class MessageBubbles extends StatefulWidget {
  MessageBubbles();

  @override
  _MessageBubblesState createState() => _MessageBubblesState();
}

class _MessageBubblesState extends State<MessageBubbles> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.cover,
          ),
          color: Colors.grey[400],
        ),
        padding: EdgeInsets.all(0.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Text('temp');
          },
        ),
      ),
    );
  }
}
