import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/chat/components/chat_bubble.dart';
import 'package:loctio_booker/screens/chat/models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'chat_alert_dialog.dart';

class MessageBubbles extends StatefulWidget {
  final Size size;
  final Function(int id, String text, String user) onSwipe;
  final WebSocketChannel channel;

  MessageBubbles({
    this.size,
    this.onSwipe,
    this.channel,
  });

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
        child: StreamBuilder(
          stream: widget.channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return listBody();
            }
            // snapshot without value
            else {
              return Center(
                child: kMyProgressIndicator,
              );
            }
          },
        ),
      ),
    );
  }

  listBody() {
    return ListView(
      children: [
        for (int i = 0; i < 4; i++) ...[
          if (i % 2 == 0) ...[
            ChatBubble(
              message: Message(
                isMe: true,
                dateTime: DateTime.now().toString(),
                text: 'Hello from me',
                textId: 1,
              ),
              size: widget.size,
              onMessageTapped: (message) {
                showOnMessageTapped(message);
              },
              onSwipe: () {
                widget.onSwipe(1, 'Hello from me33333333333333', 'sina ziaee');
              },
            ),
          ] else ...[
            ChatBubble(
              message: Message(
                isMe: false,
                dateTime: DateTime.now().toString(),
                text:
                    'How you doing, this is the best day of your life. if you know who he is',
                textId: 2,
              ),
              size: widget.size,
              onMessageTapped: (message) {
                showOnMessageTapped(message);
              },
              onSwipe: () {
                widget.onSwipe(
                    2,
                    'How you doing, this is the best day of your life. if you know who he is',
                    'sina ziaee');
              },
            ),
          ],
        ],
      ],
    );
  }

  onDeletePressed(Message message) {
    print('delete');
    Navigator.pop(context);
  }

  onEditPressed(Message message) {
    print('edit');
    Navigator.pop(context);
  }

  onReplyPressed(Message message) {
    print('reply');
    Navigator.pop(context);
  }

  showOnMessageTapped(Message message) {
    print('on show message pressed');
    showDialog(
      context: context,
      builder: (context) {
        return ChatAlertDialog(
          onDeletePressed: () {
            onDeletePressed(message);
          },
          onEditPressed: () {
            onEditPressed(message);
          },
          onReplyPressed: () {
            onReplyPressed(message);
          },
        );
      },
    );
  }
}
