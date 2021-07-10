import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/chat/components/chat_message_text_field.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../../models/user.dart';
import 'components/message_bubbles.dart';
import 'models/message.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  final User user;
  final int chatRoomId;
  final String otherUser;
  final String otherUserImageUrl;

  ChatScreen({
    @required this.user,
    @required this.chatRoomId,
    @required this.otherUser,
    @required this.otherUserImageUrl,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String socketUrl = 'ws://172.17.3.149:3000/ws/api/chat';
  String uploadFileUrl = '$mainUrl/api/chat/upload/';

  final TextEditingController chatController = TextEditingController();
  WebSocketChannel channel;

  // FocusNode focusNode;
  Size size;
  ScrollController chatScrollController = ScrollController();
  File file;
  bool isEditing = false;
  String repliedUser, repliedText;
  int repliedTextId;
  Message messageToEdit;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    // focusNode = FocusScope.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.chatAppbar(
          context, widget.otherUserImageUrl, widget.otherUser),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: kMyProgressIndicator,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: MessageBubbles(
                chatScrollController: chatScrollController,
                size: size,
                onSwipe: (id, text, user) {
                  onSwiped(id, text, user);
                },
                scrollToBottom: () {
                  scrollToBottom();
                },
                fetcher: () {
                  fetcher();
                },
                changeEditingToFalse: () {
                  changeEditToFalse();
                },
                channel: channel,
                otherUserImageUrl: widget.otherUserImageUrl,
                otherUser: widget.otherUser,
                chatRoomId: widget.chatRoomId,
                user: widget.user,
                chatController: chatController,
                isEditing: isEditing,
                messageToEdit: messageToEdit,
                changeEditingToTrue: () {
                  changeEditToTrue();
                },
                onEditPressed: (message) {
                  onEditPressed(message);
                },
                onRepliedPressed: (id, text, user) {
                  onRepliedInDialogPressed(id, text, user);
                },
              ),
            ),
            ChatMessageTextField(
              // node: focusNode,
              repliedText: repliedText,
              repliedUser: repliedUser,
              repliedTextId: repliedTextId,
              channel: channel,
              scrollToBottom: () {
                scrollToBottom();
              },
              onClearPressed: () {
                cleaner();
              },
              chatController: chatController,
              onFileSelectorPressed: () {
                showFileSelector();
              },
              fetcher: () {
                fetcher();
              },
              changeEditingToFalse: () {
                changeEditToFalse();
              },
              isEditing: isEditing,
              messageToEdit: messageToEdit,
            ),
          ],
        ),
      ),
    );
  }

  void showFileSelector() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path);
      // setState(() {});
      uploadFile();
    } else {
      // User canceled the picker
    }
  }

  onSwiped(int textId, String text, String user) {
    repliedTextId = textId;
    repliedText = text;
    repliedUser = user;
    changeEditToFalse();
    setState(() {});
  }

  onRepliedInDialogPressed(int textId, String text, String user) {
    repliedTextId = textId;
    repliedText = text;
    repliedUser = user;
    changeEditToFalse();
    Navigator.pop(context);
    setState(() {});
  }

  @override
  void initState() {
    socketUrl = '$socketUrl/${widget.chatRoomId}/';
    channel = WebSocketChannel.connect(
      Uri.parse(socketUrl),
    );
    onChatConnected();
    super.initState();
  }

  onChatConnected() {
    // print('${widget.user.token.replaceAll('Token ', '')}');
    // trying to authorize user
    channel.sink.add(
      convert.json.encode(
        {
          'Authorization': widget.user.token.replaceAll('Token ', ''),
          'type': 'authenticate',
        },
      ),
    );
    // print('auth');
    // fetching all messages
    // fetcher();
  }

  onClearPressed() {
    repliedTextId = null;
    repliedText = null;
    repliedUser = null;
    changeEditToFalse();
    setState(() {});
  }

  void cleaner() {
    file = null;
    onClearPressed();
  }

  scrollToBottom() {
    // chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if(chatScrollController.hasClients){
    //     // chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
    //     chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
    //   }
    // });

    Timer(Duration(milliseconds: 800), () {
      chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
    });

    // chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);

    // if(chatScrollController.hasClients){
    //   chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
    // }

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print(timeStamp.inMilliseconds);
    //   chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
    // });

  }

  onEditPressed(Message message) {
    cleaner();
    changeEditToTrue();
    chatController.text = message.text;
    repliedText = message.text;
    repliedUser = message.currentUsername;
    messageToEdit = message;
    // print('============================');
    // print(messageToEdit.textId);
    Navigator.pop(context);
  }

  fetcher() {
    channel.sink.add(
      convert.json.encode(
        {
          'type': 'fetch',
        },
      ),
    );
  }

  changeEditToTrue() {
    isEditing = true;
  }

  changeEditToFalse() {
    isEditing = false;
  }

  uploadFile() async {
    // print('-------------------------');
    setState(() {
      showSpinner = false;
    });
    // print(uploadFileUrl);
    // print(file.path);
    Dio dio = new Dio();
    String lastPart = file.path.split('/').last;
    FormData formData;
    formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: lastPart,
      ),
      'chat_id': widget.chatRoomId,
    });
    dio
        .post(
      uploadFileUrl,
      data: formData,
      options: Options(
          method: 'POST',
          headers: {
            HttpHeaders.authorizationHeader: widget.user.token,
          },
          responseType: ResponseType.json),
    )
        .then((response) {
      // uploadAll();
      // print('----------------------------');
      // print(response);
      setState(() {
        showSpinner = false;
      });
      fetcher();
      // file = null;
    }).catchError((error) {
      // print('*****************************');
      // print(error);
      fetcher();
      StaticMethods.showErrorDialog(context, 'An error occured while uploading files');
      setState(() {
        showSpinner = false;
      });
      // file = null;
    });
  }
}
