import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/chat/components/chat_bubble.dart';

class MessageBubbles extends StatefulWidget {

  final Size size;

  MessageBubbles({this.size});

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
        padding: EdgeInsets.only(bottom: 3),
        // child: ListView.builder(
        //   itemCount: 10,
        //   itemBuilder: (context, index) {
        //     return Text('temp');
        //   },
        // ),
        child: ListView(
          children: [
            for (int i = 0; i < 4; i++) ...[
              if (i % 2 == 0) ...[
                ChatBubble(
                  dateTime: DateTime.now().toString(),
                  text: 'Hello from me',
                  isMe: true,
                  size: widget.size,
                ),
              ] else ...[
                ChatBubble(
                  dateTime: DateTime.now().toString(),
                  text: 'How you doing, this is the best day of your life. if you know who he is',
                  isMe: false,
                  size: widget.size,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
