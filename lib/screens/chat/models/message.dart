class Message {
  String currentUsername, text, dateTime, repliedMessageText, repliedMessageUser;
  int textId, repliedMessageId, currentUserId;
  bool isMe;
  int chatRoomId;
  String file;

  Message({
    this.text,
    this.currentUsername,
    this.textId,
    this.dateTime,
    this.repliedMessageId,
    this.repliedMessageText,
    this.repliedMessageUser,
    this.isMe,
    this.chatRoomId,
    this.currentUserId,
    this.file,
  });
}
