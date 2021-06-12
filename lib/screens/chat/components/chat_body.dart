import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../../constants.dart';

class ChatBody extends StatelessWidget {
  final String text, time;
  final bool isReplied, isFile;
  String url;
  String fileLast;

  ChatBody({
    this.text,
    this.time,
    this.isFile,
    this.isReplied,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null || url.length == 0) {
      // url = 'static/temp.file';
      url = 'static/temp.jpg';
      fileLast = url.split('/').last;
    }
    // simple message
    if (!isReplied && !isFile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(text),
          Text(
            time,
            style: kBody3TextStyle.copyWith(),
          ),
        ],
      );
    }
    // simple file
    else if (!isReplied && isFile) {
      // image
      if (url.endsWith('.jpg') ||
          url.endsWith('.jpeg') ||
          url.endsWith('.png')) {
        return showImage(context, url);
      }
      // file (not image)
      else {
        return fileWidget();
      }
    }
    // replied message
    else if (isReplied && !isFile) {
    }
    // replied file
    else if (isReplied && isFile) {}
  }

  showImage(BuildContext context, String url) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            showDialog(
              builder: (context) {
                return AlertDialog(
                  title: Text(fileLast),
                  content: FadeInImage(
                    placeholder: AssetImage('assets/images/as.jpg'),
                    image: NetworkImage(tempHouseImage),
                    fit: BoxFit.cover,
                  ),
                );
              },
              context: context,
            );
          },
          child: FadeInImage(
            placeholder: AssetImage('assets/images/as.jpg'),
            image: NetworkImage(tempHouseImage),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          fileLast,
          textAlign: TextAlign.start,
          style: kBody2TextStyle.copyWith(
            color: Colors.black,
          ),
        ),
        Text(
          time,
          style: kBody3TextStyle.copyWith(),
        ),
      ],
    );
  }

  fileWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 100,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Icon(
            Icons.download_rounded,
            color: Colors.blueGrey,
            size: 60,
          ),
        ),
        Text(
          fileLast,
          textAlign: TextAlign.start,
          style: kBody2TextStyle.copyWith(
            color: Colors.black,
          ),
        ),
        Text(
          time,
          style: kBody3TextStyle.copyWith(),
        ),
      ],
    );
  }
}
