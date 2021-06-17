import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatImageBubble extends StatelessWidget {
  final String fileLast;
  final String time;
  final String file, text;

  ChatImageBubble({
    this.time,
    this.fileLast,
    this.file,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            showDialog(
              builder: (context) {
                return AlertDialog(
                  title: Text(fileLast),
                  content: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/as.jpg'),
                      image: NetworkImage('$mainUrl$file'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              context: context,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/as.jpg'),
              image: NetworkImage('$mainUrl$file'),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          fileLast,
          textAlign: TextAlign.start,
          style: kBody2TextStyle.copyWith(
            color: Colors.grey[700],
            fontSize: 13,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.start,
          style: kBody2TextStyle.copyWith(
            color: Colors.black,
          ),
        ),
        Text(
          time,
          style: kBody3TextStyle.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
